from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import List
import pymysql
from sentence_transformers import SentenceTransformer, util
from datetime import datetime, timedelta

# ==========================================
# 1. 설정 및 모델 로딩
# ==========================================
app = FastAPI(title="AI 인력 추천 시스템 API")

# CORS 설정 (프론트엔드 통신 허용)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=False,
    allow_methods=["*"],
    allow_headers=["*"],
)

# DB 설정 (비밀번호 확인 필수!)
DB_CONFIG = {

}

print("⏳ AI 모델 로딩 중... (약 5~10초 소요)")
model = SentenceTransformer('snunlp/KR-SBERT-V40K-klueNLI-augSTS')
print("✅ AI 모델 준비 완료!")

# ==========================================
# 2. 데이터 모델
# ==========================================
class MatchRequest(BaseModel):
    req_skills: str
    ai_weight: int = 70

class AssignmentRequest(BaseModel):
    assign_id: int  # <-- 업데이트할 배정 ID
    userId: str     # <-- 선택된 직원 ID

class EmployeeResponse(BaseModel):
    rank: int
    userId: str
    name: str
    career_years: int
    utilization: float
    total_score: float
    ai_score: float
    career_score: float
    desc: str
    tags: str

# ==========================================
# 3. 핵심 로직
# ==========================================
def get_db_connection():
    return pymysql.connect(**DB_CONFIG, cursorclass=pymysql.cursors.DictCursor)

def get_utilization_map(cursor):
    """현재 날짜 기준 직원의 가동률 계산"""
    now_str = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    sql = """
        SELECT EMP_ID, SUM(INPUT_RATE) AS TOTAL_RATE
        FROM TB_ASSIGNMENT
        WHERE DEL_YN = 'N' AND %s BETWEEN START_DT AND END_DT
        GROUP BY EMP_ID
    """
    cursor.execute(sql, (now_str,))
    result = cursor.fetchall()
    return {row['EMP_ID']: float(row['TOTAL_RATE']) for row in result}

# [삭제됨] is_tag_match 함수 (태그 매칭 로직 완전 제거)

# ==========================================
# 4. API 엔드포인트
# ==========================================

# [API] AI 매칭 실행
@app.post("/api/match", response_model=List[EmployeeResponse])
def match_employees(req: MatchRequest):
    conn = get_db_connection()
    try:
        with conn.cursor() as cursor:
            if not req.req_skills:
                raise HTTPException(status_code=400, detail="Requirement text is empty")

            # 1. 직원 조회 (설명이 있는 사람만)
            cursor.execute("SELECT EMP_ID, EMP_NM, SKILL_DESC, TECH_TAGS, CAREER_YEARS FROM TB_EMP WHERE SKILL_DESC IS NOT NULL AND SKILL_DESC != ''")
            all_candidates = cursor.fetchall()
            
            util_map = get_utilization_map(cursor)
            proj_desc_vector = model.encode(req.req_skills, convert_to_tensor=True)

            results = []
            w_ai = req.ai_weight / 100.0
            w_career = 1.0 - w_ai

            for emp in all_candidates:
                try:
                    # 데이터 세이프티 체크 (필수!)
                    eid = str(emp['EMP_ID']) if emp['EMP_ID'] else "UNKNOWN"
                    enm = str(emp['EMP_NM']) if emp['EMP_NM'] else "이름없음"
                    skill_text = str(emp['SKILL_DESC'])
                    
                    # 가동률 체크
                    current_util = float(util_map.get(emp['EMP_ID'], 0.0))
                    if current_util >= 100.0: continue

                    # AI 점수 계산
                    emp_vector = model.encode(skill_text, convert_to_tensor=True)
                    ai_sim = util.cos_sim(proj_desc_vector, emp_vector).item()
                    
                    # 점수가 음수거나 이상하면 0처리
                    ai_score = max(0, ai_sim)
                    
                    years = int(emp['CAREER_YEARS']) if emp['CAREER_YEARS'] else 0
                    career_score = min(years, 10) / 10.0
                    
                    final_score = (ai_score * w_ai) + (career_score * w_career)
                    
                    results.append({
                        "rank": 0, 
                        "userId": eid, 
                        "name": enm,
                        "career_years": years, 
                        "utilization": current_util,
                        "total_score": float(round(final_score * 100, 1)),
                        "ai_score": float(round(ai_score * 100, 1)),
                        "career_score": float(round(career_score * 100, 1)),
                        "desc": skill_text[:50] + "...", 
                        "tags": str(emp['TECH_TAGS']) if emp['TECH_TAGS'] else ""
                    })
                except Exception as inner_e:
                    print(f"⚠️ 특정 사원 처리 중 스킵: {inner_e}")
                    continue

            results.sort(key=lambda x: x['total_score'], reverse=True)
            for i, res in enumerate(results): res['rank'] = i + 1
            
            return results
    except Exception as e:
        print(f"🔥 파이썬 메인 에러 발생: {e}")
        raise HTTPException(status_code=500, detail=str(e))
    finally:
        conn.close()

if __name__ == "__main__":
    import uvicorn
    # 외부 접속 허용 (0.0.0.0)
    uvicorn.run(app, host="0.0.0.0", port=8000)