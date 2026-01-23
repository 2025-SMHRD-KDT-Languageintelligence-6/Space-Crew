<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>계약 상세 정보</title>
    <link rel="stylesheet" href="<c:url value='/css/egovframework/com/com.css'/>">
    <style>
        body { padding: 20px; font-family: 'Malgun Gothic'; }
        .popup-header { border-bottom: 2px solid #333; padding-bottom: 10px; margin-bottom: 20px; }
        .btn-close { margin-top: 20px; text-align: center; }
    </style>
</head>
<body>
    <div class="popup-header">
        <h2>📂 계약 정보 : ${contractVO.contNm}</h2>
    </div>

    <table class="w3-table-all">
        <colgroup>
            <col style="width:30%;">
            <col style="width:70%;">
        </colgroup>
        <tr>
            <th>고객사 ID</th>
            <td>${contractVO.custNm}</td>
        </tr>
        <tr>
            <th>영업건명</th>
            <td>${contractVO.salesTitle}</td>
        </tr>
        <tr>
            <th>영업담당자</th>
            <td>${contractVO.salesUserNm}</td>
        </tr>
        <tr>
            <th>계약담당자</th>
            <td>${contractVO.picUserNm}</td>
        </tr>
        <tr>
            <th>계약금액</th>
            <td>${contractVO.contAmt}</td>
        </tr>
        <tr>
            <th>계약일</th>
            <td>${contractVO.contDt}</td>
        </tr>
        <tr>
            <th>계약시작일</th>
            <td>${contractVO.startDt}</td>
        </tr>
        <tr>
            <th>계약종료일</th>
            <td>${contractVO.endDt}</td>
        </tr>
        <tr>
            <th>상태</th>
            <td>${contractVO.contStatus}</td>
        </tr>
        <tr>
            <th>특이사항</th>
            <td>${contractVO.contRemark}</td>
        </tr>
        </table>

    <div class="btn-close">
    	<button type="button" onclick="fn_go_update_page('${contractVO.contId}');" class="btn_blue">수정</button>
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
		    
		    var updateUrl = "<c:url value='/pms/updateContractView.do'/>?selectedId=" + id;
		    
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