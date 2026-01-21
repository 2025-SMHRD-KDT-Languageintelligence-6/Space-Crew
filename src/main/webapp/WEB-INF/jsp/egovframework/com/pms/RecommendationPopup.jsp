<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>AI 스마트 인력 추천</title>
    <style>
        body { font-family: 'Malgun Gothic', sans-serif; padding: 20px; background-color: #f4f6f9; }
        .container { background: #fff; padding: 20px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h2 { color: #333; border-bottom: 2px solid #007bff; padding-bottom: 10px; margin-bottom: 20px; }

        /* 상단 요구사항 박스 */
        .req-box { background: #e9ecef; padding: 15px; border-radius: 5px; margin-bottom: 20px; }
        .req-box strong { color: #007bff; }

        /* 가중치 슬라이더 영역 */
        .slider-area { background: #fff3cd; padding: 15px; border-radius: 5px; margin-bottom: 20px; border: 1px solid #ffeeba; }
        .slider-container { display: flex; align-items: center; justify-content: space-between; margin-top: 10px; }
        input[type=range] { width: 60%; cursor: pointer; }
        .badge { padding: 5px 10px; border-radius: 15px; font-weight: bold; color: white; }
        .bg-ai { background-color: #28a745; }
        .bg-career { background-color: #17a2b8; }

        /* 테이블 스타일 */
        table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        th { background: #343a40; color: #fff; padding: 12px; text-align: center; }
        td { border-bottom: 1px solid #ddd; padding: 12px; text-align: center; color: #333; }
        tr:hover { background-color: #f1f1f1; }

        /* 점수 강조 */
        .score { font-weight: bold; color: #dc3545; font-size: 1.1em; }

        /* 버튼 */
        .btn-select { background: #007bff; color: white; border: none; padding: 8px 16px; border-radius: 4px; cursor: pointer; }
        .btn-select:hover { background: #0056b3; }

        /* 스니펫(요약) 텍스트 */
        .snippet { font-size: 0.85em; color: #666; text-align: left; margin-top: 5px; }
    </style>
</head>
<body>

<div class="container">
    <h2>AI 스마트 인력 추천 결과</h2>

    <div class="req-box">
        <strong>입력된 요구사항:</strong><br>
        "${reqSkills}"
    </div>

    <div class="slider-area">
        <strong>⚖️ 가중치 설정 (AI vs 경력)</strong>
        <div class="slider-container">
            <span class="badge bg-ai">AI <span id="aiVal">${aiWeight}</span>%</span>

            <input type="range" id="weightSlider" min="0" max="100" value="${aiWeight}"
                   oninput="updateLabel(this.value)" onchange="refreshList(this.value)">

            <span class="badge bg-career">경력 <span id="careerVal">${careerWeight}</span>%</span>
        </div>
        <small style="color: #856404;">* 슬라이더를 놓으면 즉시 재계산됩니다.</small>
    </div>

    <table>
            <colgroup>
                <col style="width: 20%;"> <col style="width: 20%;"> <col style="width: 20%;"> <col style="width: 20%;"> </colgroup>
            <thead>
                <tr>
                    <th>직원명</th>

                    <th>현재 가동률</th>

                    <th>AI 매칭 점수</th>

                    <th>선택</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${empty recommendList}">
                    <tr>
                        <td colspan="4" style="padding: 30px;">
                            검색 결과가 없거나 AI 서버 연결에 실패했습니다. 😢
                        </td>
                    </tr>
                </c:if>

                <c:forEach var="item" items="${recommendList}" varStatus="status">
                    <tr>
                        <td>
                            <strong>${item.name}</strong>
                        </td>

                        <td>
                            <span class="badge" style="background-color: #6c757d;">
                                ${item.currentLoad != null ? item.currentLoad : 0}%
                            </span>
                        </td>

                        <td>
                            <span class="score">${item.score}점</span>
                        </td>

                        <td>
                            <button type="button" class="btn-select"
                                    onclick="selectStaff('${item.name}')">
                                담당자 선정
                            </button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
</div>

<script>
    // 1. 슬라이더 움직일 때 숫자만 먼저 변경 (UX)
    function updateLabel(val) {
        document.getElementById('aiVal').innerText = val;
        document.getElementById('careerVal').innerText = (100 - val);
    }

    // 2. 슬라이더 놓았을 때(Change), 서버에 재요청 (페이지 새로고침)
    function refreshList(val) {
        var aiWeight = val / 100.0;
        var careerWeight = (100 - val) / 100.0;

        var projId = "${projId}";
        var reqSkills = "${reqSkills}"; // 기존 입력값 유지

        // 같은 주소로 파라미터만 바꿔서 다시 호출 (SSR 방식)
        location.href = "/pms/openAIRecommendation.do?projId=" + projId +
                        "&reqSkills=" + encodeURIComponent(reqSkills) +
                        "&aiWeight=" + aiWeight +
                        "&careerWeight=" + careerWeight;
    }

    // 3. [담당자 선정] 버튼 클릭 시 부모창에 값 넣고 닫기
    function selectStaff(name) {
        // 부모 창(opener)이 살아있는지 확인
        if (opener && !opener.closed) {

            // ★ 중요: 부모 창의 '주담당자' 입력칸 ID가 'mainManager'라고 가정함!
            // 만약 ID가 다르다면, opener.document.getElementById("여기를_수정해")
            var parentInput = opener.document.getElementById("mainManager") ||
                              opener.document.querySelector("input[name='mainManager']");

            if (parentInput) {
                parentInput.value = name; // 이름 넣기
                alert("'" + name + "' 님이 주담당자로 선정되었습니다!");
                window.close(); // 팝업 닫기
            } else {
                alert("부모 창에 담당자 입력칸을 찾을 수 없습니다.\n개발자에게 'ID 확인'을 요청하세요.");
                // 임시로 그냥 닫기 (테스트용)
                window.close();
            }
        } else {
            alert("원래 창이 닫혀서 데이터를 전달할 수 없습니다.");
        }
    }
</script>

</body>
</html>