<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>청구 및 정산 관리</title>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/egovframework/com/pms/BillingList.css'/>" >
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
	                <th width="10">프로젝트ID</th>
		            <th width="30%">프로젝트명</th>
		            <th width="25%">계약금액</th>
		            <th width="25%">누적청구액</th>
		            <th width="10%">정산여부</th>
	            </tr>
	        </thead>
	        <tbody>
	            <c:forEach var="result" items="${resultList}">
	                <tr>
	                    <td>${result.projId}</td>
	                    <td>
						    <a href="javascript:void(0);" onclick="fn_open_billing_popup('${result.projId}');" style="font-weight:bold; color:#007bff; text-decoration:underline;">
						        <c:out value="${result.projNm}"/>
						    </a>
						</td>
	                    <td style="text-align:right; padding-right:15px;">
	                   		<fmt:formatNumber value="${result.totalAmt}" pattern="#,###"/>원
	                    </td>
	                    <td style="text-align:right; padding-right:15px; color:#28a745; font-weight:bold;">
	                    	<fmt:formatNumber value="${result.totalBilledAmt}" pattern="#,###"/>원
	                    </td>
	                    <td>
	                        <c:choose>
			                    <c:when test="${result.isPaid == 'Y'}">
			                        <span class="status-y" style="background:#e7f3ff; padding:4px 10px; border-radius:12px; font-size:11px;">정산완료</span>
			                    </c:when>
			                    <c:otherwise>
			                        <c:choose>
			                            <c:when test="${result.totalAmt == result.totalBilledAmt}">
			                                <span style="background:#fff3cd; color:#856404; padding:4px 10px; border-radius:12px; font-size:11px;">입금대기</span>
			                            </c:when>
			                            <c:otherwise>
			                                <span class="status-n" style="background:#fff0f0; padding:4px 10px; border-radius:12px; font-size:11px;">청구진행중</span>
			                            </c:otherwise>
			                        </c:choose>
			                    </c:otherwise>
			                </c:choose>
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
	            document.listForm.action = "<c:url value='/pms/billingList.do'/>";
	            document.listForm.submit();
	        }
	        
	        function fn_open_billing_popup(projId) {
	            var windowName = "billing_pop_" + projId;
	            var url = "<c:url value='/pms/billingDetailPopup.do'/>?projId=" + projId;
	            var options = "width=850, height=700, resizable=yes, scrollbars=yes";
	            window.open(url, windowName, options);
	        }
	    </script>
    </div>

    <script>
        function fn_egov_link_page(pageNo){
            document.listForm.pageIndex.value = pageNo;
            document.listForm.submit();
        }

        function fn_open_billing_popup(projId) {
            var url = "<c:url value='/pms/billingDetailPopup.do'/>?projId=" + projId;
            window.open(url, "billing_pop_" + projId, "width=900, height=750, resizable=yes, scrollbars=yes");
        }
    </script>
</body>
</html>