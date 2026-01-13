<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>직원 상세 정보</title>
    <link rel="stylesheet" href="<c:url value='/css/egovframework/com/com.css'/>">
    <style>
        body { padding: 20px; font-family: 'Malgun Gothic'; }
        .popup-header { border-bottom: 2px solid #333; padding-bottom: 10px; margin-bottom: 20px; }
        .btn-close { margin-top: 20px; text-align: center; }
    </style>
</head>
<body>
    <div class="popup-header">
        <h2>📂 직원 정보 : ${userVO.userId}</h2>
    </div>

    <table class="w3-table-all">
        <colgroup>
            <col style="width:30%;">
            <col style="width:70%;">
        </colgroup>
        <tr>
            <th>이름</th>
            <td></td>
        </tr>
        <tr>
            <th>부서</th>
            <td></td>
        </tr>
        <tr>
            <th>직무</th>
            <td></td>
        </tr>
        <tr>
            <th>직급</th>
            <td></td>
        </tr>
        <tr>
            <th>경력연수</th>
            <td></td>
        </tr>
        <tr>
            <th>전문분야</th>
            <td></td>
        </tr>
        <tr>
            <th>업무부하량</th>
            <td></td>
        </tr>
        <tr>
            <th>가입일</th>
            <td></td>
        </tr>
        <tr>
            <th>권한레벨</th>
            <td></td>
        </tr>
        <tr>
            <th>재직</th>
            <td></td>
        </tr>
        <tr>
            <th>보유스택</th>
            <td></td>
        </tr>
        </table>

    <div class="btn-close">
        <button type="button" onclick="window.close();" class="btn_s">닫기</button>
    </div>
</body>
</html>