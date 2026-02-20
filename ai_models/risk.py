from fastapi import FastAPI, UploadFile, File, Form
from pydantic import BaseModel
from openai import OpenAI
import uvicorn
import io
import docx
import olefile
import json


app = FastAPI()

# 1. GPT-4o 클라이언트 설정 (팀장님의 API Key 필요)
client = OpenAI(api_key="")

# 2. 요청 데이터 규격 (Spring에서 보낼 JSON과 일치)
#class RiskRequest(BaseModel):
#    project_id: int
#    report_id: int
#    content: str

def extract_text(file_content, filename):
    ext = filename.split('.')[-1].lower()
    text = ""
    
    if ext == 'txt':
        text = file_content.decode('utf-8', errors='ignore')
    
    elif ext == 'docx':
        doc = docx.Document(io.BytesIO(file_content))
        text = "\n".join([para.text for para in doc.paragraphs])
    
    elif ext == 'hwp':
        try:
            f = olefile.OleFileIO(io.BytesIO(file_content))
            dirs = f.listdir()
            if ['BodyText', 'Section0'] in dirs:
                text = f.openstream('BodyText/Section0').read().decode('utf-16', errors='ignore')
        except:
            text = "HWP 파싱 실패 (텍스트 추출 불가)"
            
    return text


# 3. 리스크 분석 엔드포인트
@app.post("/api/v1/analyze/risk")
#async def analyze_risk(request: RiskRequest):
async def analyze_risk(
    file: UploadFile = File(...), 
    project_id: int = Form(...), 
    report_id: int = Form(...)
):
    content_bytes = await file.read()
    
    extracted_text = extract_text(content_bytes, file.filename)
    
    # GPT-4o에게 내릴 정밀 지시문 (프롬프트)
    prompt = f"""
    당신은 20년 경력의 냉철한 IT 프로젝트 관리 전문가(PMP)입니다.
    분석 대상 내용: {extracted_text}
    
    [엄격한 분석 규칙]
    1. 오직 'IT 소프트웨어 개발 프로젝트'의 관점에서만 리스크를 평가하십시오.
    2. 일정(Schedule), 예산(Cost), 기술 결함(Technical), 인력(Resource), 범위(Scope)와 직접 관련 없는 내용은 무조건 0점을 부여하십시오.
    3. 명절, 문화, 종교, 연예 등 프로젝트 외부 이슈는 리스크가 없는 것(SAFE, 0점)으로 간주하십시오.
    
    결과는 반드시 다음 JSON 형식으로만 응답하세요:
    {{
        "risk_score": 0~100 사이 정수,
        "risk_level": "SAFE" 또는 "CAUTION" 또는 "DANGER",
        "analysis_summary": "핵심 위험 사유 1줄 요약 (관련 없을 시 '프로젝트와 관련 없음'으로 표기)",
        "risk_keywords": ["위험어1", "위험어2"]
    }}
    """

    # GPT-4o 호출
    response = client.chat.completions.create(
        model="gpt-4o",
        messages=[{"role": "user", "content": prompt}],
        response_format={ "type": "json_object" } # JSON 응답 보장
    )

    # 분석 결과 반환
    #import json
    #result = json.loads(response.choices[0].message.content)
    #result["report_id"] = request.report_id
    result = json.loads(response.choices[0].message.content)
    result["project_id"] = project_id
    result["report_id"] = report_id
    result["filename"] = file.filename

    return result

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8002)