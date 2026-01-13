<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>고객사 관리 목록</title>
    <style>
        table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: center; }
        th { background-color: #f8f9fa; }
        .search-box { margin-bottom: 20px; padding: 15px; background: #f1f3f5; border-radius: 5px; }
        .btn { padding: 6px 12px; text-decoration: none; cursor: pointer; border: 1px solid #dee2e6; border-radius: 4px; display: inline-block; }
        .btn-blue { background: #007bff; color: white; border: none; }
        .btn-red { background: #dc3545; color: white; border: none; }
        .text-left { text-align: left; }
        .content-page { margin-left: 220px; padding: 20px; }
    </style>
</head>
<body>
	<c:import url="/WEB-INF/jsp/egovframework/com/pms/include/menu.jsp" />
	<div class="content-page">
	    <h2>고객사 관리 목록</h2>
	
	    <div class="search-box">
	        <form name="listForm" action="<c:url value='/pms/customerList.do'/>" method="post">
	            <input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
	            
	            <label>고객사명: </label>
	            <input type="text" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>" style="width:200px;" />
	            <button type="submit" class="btn btn-blue">검색</button>
	        </form>
	    </div>
	
	    <table>
	        <thead>
	            <tr>
	                <th width="8%">ID</th>
	                <th width="25%">고객사명</th>
	                <th width="15%">사업자번호</th>
	                <th width="12%">대표자</th>
	                <th width="12%">담당자</th>
	                <th width="18%">연락처</th>
	                <th width="10%">관리</th>
	            </tr>
	        </thead>
	        <tbody>
	            <c:forEach var="result" items="${resultList}" varStatus="status">
	                <tr>
	                    <td><c:out value="${result.custId}"/></td>
	                    <td class="text-left">
	                        <a href="javascript:void(0);" onclick="fn_open_customer_popup('${result.custId}', '${result.custNm}');" style="font-weight:bold; color:#007bff;">
	                            <c:out value="${result.custNm}"/>
	                        </a>
	                    </td>
	                    <td><c:out value="${result.bizRegNo}"/></td>
	                    <td><c:out value="${result.ceoNm}"/></td>
	                    <td><c:out value="${result.picNm}"/></td>
	                    <td><c:out value="${result.picTel}"/></td>
	                    <td>
	                    	<a href="<c:url value='/pms/updateCustomerView.do'/>?selectedId=${result.custId}" 
      						   class="btn" style="padding: 2px 5px; font-size: 12px; background:#ffc107;">수정</a>
      						   
	                        <a href="<c:url value='/pms/deleteCustomer.do'/>?selectedId=${result.custId}" 
	                           class="btn btn-red" style="padding: 2px 5px; font-size: 12px;"
	                           onclick="return confirm('고객사 정보를 삭제하시겠습니까?');">삭제</a>
	                    </td>
	                </tr>
	            </c:forEach>
	            <c:if test="${empty resultList}">
	                <tr>
	                    <td colspan="7">등록된 고객사 내역이 없습니다.</td>
	                </tr>
	            </c:if>
	        </tbody>
	    </table>
	
	    <div style="text-align:center; margin-top:20px;">
	        <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_link_page" />
	    </div>
	
	    <div style="margin-top: 20px;">
	        <a href="<c:url value='/pms/addCustomerView.do'/>" class="btn btn-blue">신규 고객 등록</a>
	    </div>
	
	    <script type="text/javascript">
	        function fn_egov_link_page(pageNo){
	            document.listForm.pageIndex.value = pageNo;
	            document.listForm.action = "<c:url value='/pms/customerList.do'/>";
	            document.listForm.submit();
	        }
	        
	        function fn_open_customer_popup(custId, custNm) {
	            var windowName = "customer_pop_" + custId;
	            var url = "<c:url value='/pms/customerDetailPopup.do'/>?selectedId=" + custId;
	            var options = "width=700, height=600, resizable=yes, scrollbars=yes, status=no";
	            window.open(url, windowName, options);
	        }
	    </script>
    </div>
</body>
</html>