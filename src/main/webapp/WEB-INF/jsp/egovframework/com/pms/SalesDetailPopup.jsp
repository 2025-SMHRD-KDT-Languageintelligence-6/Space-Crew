<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
        <h2>📂 영업 정보 : ${salesVO.salesTitle}</h2>
    </div>

    <table class="w3-table-all">
        <colgroup>
            <col style="width:30%;">
            <col style="width:70%;">
        </colgroup>
        <tr>
            <th>고객사</th>
            <td>${salesVO.custNm}</td>
        </tr>
        <tr>
            <th>영업담당자</th>
            <td>${salesVO.salesNm}</td>
        </tr>
        <tr>
            <th>예상금액</th>
            <td>${salesVO.expectedAmt}</td>
        </tr>
        <tr>
            <th>예상 수주 시기</th>
            <td>${salesVO.expectedDt}</td>
        </tr>
        <tr>
            <th>확률</th>
            <td>${salesVO.probability}</td>
        </tr>
        <tr>
            <th>상태</th>
            <td>${salesVO.status}</td>
        </tr>
        <tr>
            <th>영업추진내용</th>
            <td>${salesVO.salesContent}</td>
        </tr>
        </table>

    <div class="btn-close">
    	<button type="button" onclick="fn_go_update_page('${salesVO.salesId}');" class="btn_blue">수정</button>
        <button type="button" onclick="window.close();" class="btn_s">닫기</button>
    </div>
    <script>
		function fn_go_update_page(id) {
		    if(!id || id === "") {
		        alert("ID 정보가 없어 수정 페이지로 이동할 수 없습니다.");
		        return;
		    }
	
		    if (!window.opener || window.opener.closed) {
		        alert("부모 창을 찾을 수 없습니다.");
		        return;
		    }
		    if (!confirm("수정 페이지로 이동하시겠습니까?\n(현재 팝업은 자동으로 닫힙니다)")) return;
		    
		    var updateUrl = "<c:url value='/pms/updateSalesView.do'/>?selectedId=" + id;
		    
		    try {
		        window.opener.location.href = updateUrl;
		        
		        setTimeout(function() {
		            window.close();
		        }, 100);
		    } catch (e) {
		        window.opener.location = updateUrl;
		        window.close();
		    }
		}
    </script>
</body>
</html>