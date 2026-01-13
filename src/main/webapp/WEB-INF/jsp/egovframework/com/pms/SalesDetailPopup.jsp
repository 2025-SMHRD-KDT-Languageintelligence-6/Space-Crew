<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>영업 상세 정보</title>
    <link rel="stylesheet" href="<c:url value='/css/egovframework/com/com.css'/>">
    <style>
        body { padding: 20px; font-family: 'Malgun Gothic'; }
        .popup-header { border-bottom: 2px solid #333; padding-bottom: 10px; margin-bottom: 20px; }
        .btn-close { margin-top: 20px; text-align: center; }
    </style>
</head>
<body>
    <div class="popup-header">
        <h2>📂 영업 정보 : ${customerVO.custNm}</h2>
    </div>

    <table class="w3-table-all">
        <colgroup>
            <col style="width:30%;">
            <col style="width:70%;">
        </colgroup>
        <tr>
            <th>고객사</th>
            <td></td>
        </tr>
        <tr>
            <th>영업담당자</th>
            <td></td>
        </tr>
        <tr>
            <th>예상금액</th>
            <td></td>
        </tr>
        <tr>
            <th>예상 수주 시기</th>
            <td></td>
        </tr>
        <tr>
            <th>확률</th>
            <td></td>
        </tr>
        <tr>
            <th>상태</th>
            <td></td>
        </tr>
        <tr>
            <th>영업추진내용</th>
            <td></td>
        </tr>
        <tr>
            <th>등록일시</th>
            <td></td>
        </tr>
        </table>

    <div class="btn-close">
        <button type="button" onclick="window.close();" class="btn_s">닫기</button>
    </div>
</body>
</html>