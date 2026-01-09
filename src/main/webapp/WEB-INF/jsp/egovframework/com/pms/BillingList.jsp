<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>청구 및 정산 관리</title>
    <style>
        table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: center; }
        th { background-color: #f8f9fa; }
        .btn { padding: 6px 12px; text-decoration: none; cursor: pointer; border: 1px solid #dee2e6; border-radius: 4px; display: inline-block; }
        .btn-blue { background: #007bff; color: white; border: none; }
        .status-y { color: blue; font-weight: bold; }
        .status-n { color: red; font-weight: bold; }
        .content-page { margin-left: 220px; padding: 20px; }
    </style>
</head>
<body>
	<c:import url="/WEB-INF/jsp/egovframework/com/pms/include/menu.jsp" />
	<div class="content-page">
	    <h2>청구 및 정산 목록</h2>
	
	    <div style="margin-bottom: 20px;">
	        <form name="listForm" action="<c:url value='/pms/billingList.do'/>" method="post">
	            <input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
	            <label>청구명: </label>
	            <input type="text" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>" />
	            <button type="submit" class="btn btn-blue">검색</button>
	        </form>
	    </div>
	
	    <table>
	        <thead>
	            <tr>
	                <th>ID</th>
	                <th>프로젝트명</th>
	                <th>청구회차/명칭</th>
	                <th>청구금액</th>
	                <th>발행일</th>
	                <th>입금여부</th>
	                <th>관리</th>
	            </tr>
	        </thead>
	        <tbody>
	            <c:forEach var="result" items="${resultList}">
	                <tr>
	                    <td>${result.billId}</td>
	                    <td>${result.projectName}</td>
	                    <td style="text-align:left;">
	                        <a href="<c:url value='/pms/updateBillingView.do'/>?selectedId=${result.billId}">${result.billTitle}</a>
	                    </td>
	                    <td style="text-align:right;"><fmt:formatNumber value="${result.billAmt}" pattern="#,###"/>원</td>
	                    <td>${result.taxBillDt}</td>
	                    <td>
	                        <span class="${result.isPaid == 'Y' ? 'status-y' : 'status-n'}">
	                            ${result.isPaid == 'Y' ? '입금완료' : '미납'}
	                        </span>
	                    </td>
	                    <td>
	                        <a href="<c:url value='/pms/deleteBilling.do'/>?selectedId=${result.billId}" onclick="return confirm('삭제하시겠습니까?');">삭제</a>
	                    </td>
	                </tr>
	            </c:forEach>
	        </tbody>
	    </table>
	
	    <div style="text-align:center; margin-top:20px;">
	        <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_link_page" />
	    </div>
	
	    <div style="margin-top: 20px;">
	        <a href="<c:url value='/pms/addBillingView.do'/>" class="btn btn-blue">신규 청구 등록</a>
	    </div>
	
	    <script>
	        function fn_egov_link_page(pageNo){
	            document.listForm.pageIndex.value = pageNo;
	            document.listForm.submit();
	        }
	    </script>
    </div>
</body>
</html>