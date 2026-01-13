<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>영업 관리 목록</title>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/egovframework/com/pms/SalesList.css'/>">

</head>
<body>
	<c:import url="/WEB-INF/jsp/egovframework/com/pms/include/menu.jsp" />
	<div class="content-page">
	    <h2>영업 관리 목록</h2>

	    <div class="search-box">
	        <form name="listForm" action="<c:url value='/pms/salesList.do'/>" method="post">
	            <input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
	            <label>영업건명: </label>
	            <input type="text" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>" />
	            <button type="submit" class="btn btn-blue">검색</button>
	        </form>
	    </div>

	    <table>
	        <thead>
	            <tr>
	                <th width="5%">ID</th>
	                <th width="23%">영업건명</th>
	                <th width="15%">고객사</th>
	                <th width="10%">담당자</th>
	                <th width="15%">예상금액</th>
	                <th width="12%">확률</th>
	                <th width="10%">상태</th>
	                <th width="10%">관리</th>
	            </tr>
	        </thead>
	        <tbody>
	            <c:forEach var="result" items="${resultList}">
	                <tr>
	                    <td>${result.salesId}</td>
	                    <td class="text-left">
	                        <a href="javascript:void(0);" onclick="fn_open_sales_popup('${result.salesId}', '${result.salesTitle}');" style="font-weight:bold; color:#007bff;">
	                            <c:out value="${result.salesTitle}"/>
	                        </a>
	                    </td>
	                    <td>${result.customerName}</td>
	                    <td>${result.salesUserName}</td>
	                    <td><fmt:formatNumber value="${result.expectedAmt}" pattern="#,###"/>원</td>
	                    <td>
	                        <span>${result.probability}%</span>
                            <div class="prob-container">
                                <div class="prob-bar" style="width: ${result.probability}%;"></div>
                            </div>
                        </td>
	                    <td>
                            <c:choose>
                                <c:when test="${result.status eq '영업중'}">
                                    <span class="status-badge status-won">영업중</span>
                                </c:when>

                                <c:when test="${result.status eq '수주완료'}">
                                    <span class="status-badge status-negotiating">수주완료</span>
                                </c:when>

                                <c:when test="${result.status eq '영업실패'}">
                                    <span class="status-badge status-lost">영업실패</span>
                                </c:when>

                            </c:choose>
	                    </td>
	                    <td>
		                   <a href="<c:url value='/pms/updateSalesView.do'/>?selectedId=${result.salesId}"
		                    class="btn btn-yellow btn-sm" >수정</a>
                           <a href="javascript:void(0);"
                            class="btn btn-red btn-sm"  onclick="if(confirm('삭제하시겠습니까?')) location.href='<c:url value='/pms/deleteSales.do'/>?selectedId=${result.salesId}';">삭제</a>
	                    </td>
	                </tr>
	            </c:forEach>
	        </tbody>
	    </table>

	    <div style="text-align:center; margin-top:20px;">
	        <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_link_page" />
	    </div>

	    <div style="margin-top: 20px;">
	        <a href="<c:url value='/pms/addSalesView.do'/>" class="btn btn-blue">신규 영업 등록</a>
	    </div>

	    <script>
	        function fn_egov_link_page(pageNo){
	            document.listForm.pageIndex.value = pageNo;
	            document.listForm.action = "<c:url value='/pms/salesList.do'/>";
	            document.listForm.submit();
	        }

	        function fn_open_customer_popup(salesId, salesTitle) {
	            var windowName = "sales_pop_" + custId;
	            var url = "<c:url value='/pms/salesDetailPopup.do'/>?selectedId=" + salesId;
	            var options = "width=700, height=600, resizable=yes, scrollbars=yes, status=no";
	            window.open(url, windowName, options);
	        }
	    </script>
    </div>
</body>
</html>