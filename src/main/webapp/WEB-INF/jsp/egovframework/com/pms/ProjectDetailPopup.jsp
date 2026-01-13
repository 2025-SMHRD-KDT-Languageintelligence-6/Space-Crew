<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>업무 상세 정보</title>
    <link rel="stylesheet" href="<c:url value='/css/egovframework/com/com.css'/>">
    <style>
        body { padding: 20px; font-family: 'Malgun Gothic'; }
        .popup-header { border-bottom: 2px solid #333; padding-bottom: 10px; margin-bottom: 20px; }
        .btn-close { margin-top: 20px; text-align: center; }
    </style>
</head>
<body>
    <div class="popup-header">
        <h2>📂 업무 정보 : ${customerVO.custNm}</h2>
    </div>

    <table class="w3-table-all">
        <colgroup>
            <col style="width:30%;">
            <col style="width:70%;">
        </colgroup>
        <tr>
            <th>고객사명</th>
            <td></td>
        </tr>
        <tr>
            <th>영업건명</th>
            <td></td>
        </tr>
        <tr>
            <th>영업담당자</th>
            <td></td>
        </tr>
        <tr>
            <th>계약명</th>
            <td></td>
        </tr>
        <tr>
            <th>계약담당자</th>
            <td></td>
        </tr>
        <tr>
            <th>업무 유형</th>
            <td></td>
        </tr>
        <tr>
            <th>상태</th>
            <td></td>
        </tr>
        <tr>
            <th>주담당자</th>
            <td></td>
        </tr>
        <tr>
            <th>부담당자</th>
            <td></td>
        </tr>
        <tr>
            <th>시작일</th>
            <td></td>
        </tr>
        <tr>
            <th>종료일</th>
            <td></td>
        </tr>
        <tr>
            <th>진행률</th>
            <td></td>
        </tr>
        <tr>
            <th>난이도</th>
            <td></td>
        </tr>
        <tr>
            <th>요구 기술 사항</th>
            <td></td>
        </tr>
        </table>

    <div class="btn-close">
        <button type="button" onclick="window.close();" class="btn_s">닫기</button>
    </div>
</body>
</html>