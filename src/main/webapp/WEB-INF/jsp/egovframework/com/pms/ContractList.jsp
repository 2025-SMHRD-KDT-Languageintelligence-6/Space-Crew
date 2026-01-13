<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>계약 관리 목록</title>
    <style>
        table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: center; }
        th { background-color: #f8f9fa; }
        .search-box { margin-bottom: 20px; padding: 15px; background: #f1f3f5; border-radius: 5px; }
        .btn { padding: 6px 12px; text-decoration: none; cursor: pointer; border: 1px solid #dee2e6; border-radius: 4px; display: inline-block; }
        .btn-blue { background: #007bff; color: white; border: none; }
        .btn-red { background: #dc3545; color: white; border: none; }
        .text-right { text-align: right; }
        .content-page { margin-left: 220px; padding: 20px; }
    </style>
</head>
<body>
	<c:import url="/WEB-INF/jsp/egovframework/com/pms/include/menu.jsp" />
	<div class="content-page">
	    <h2>계약 관리 목록</h2>
	
	    <div class="search-box">
	        <form name="listForm" action="<c:url value='/pms/contractList.do'/>" method="post">
	            <input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
	            
	            <label>계약명: </label>
	            <input type="text" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>" style="width:200px;" />
	            <button type="submit" class="btn btn-blue">검색</button>
	        </form>
	    </div>
	
	    <table>
	        <thead>
	            <tr>
	                <th width="8%">ID</th>
	                <th width="25%">계약명</th>
	                <th width="15%">계약금액(원)</th>
	                <th width="10%">담당자</th>
	                <th width="10%">상태</th>
	                <th width="12%">계약일</th>
	                <th width="10%">관리</th>
	            </tr>
	        </thead>
	        <tbody>
	            <c:forEach var="result" items="${resultList}" varStatus="status">
	                <tr>
	                    <td><c:out value="${result.contId}"/></td>
	                    <td class="text-left">
	                        <a href="javascript:void(0);" onclick="fn_open_contract_popup('${result.contId}', '${result.contNm}');" style="font-weight:bold; color:#007bff;">
	                            <c:out value="${result.contNm}"/>
	                        </a>
	                    </td>
	                    <td class="text-right">
	                        <fmt:formatNumber value="${result.contAmt}" pattern="#,###" />
	                    </td>
	                    <td><c:out value="${result.picUserName}"/></td>
	                    <td><c:out value="${result.contStatus}"/></td>
	                    <td><c:out value="${result.contDt}"/></td>
	                    <td>
	                        <a href="<c:url value='/pms/updateContractView.do'/>?selectedId=${result.contId}" 
     						   class="btn" style="padding: 2px 5px; font-size: 12px; background:#ffc107;">수정</a>
     						   
	                        <a href="<c:url value='/pms/deleteContract.do'/>?selectedId=${result.contId}" 
	                           class="btn btn-red" style="padding: 2px 5px; font-size: 12px;"
	                           onclick="return confirm('계약 정보를 삭제하시겠습니까?');">삭제</a>
	                    </td>
	                </tr>
	            </c:forEach>
	            <c:if test="${empty resultList}">
	                <tr>
	                    <td colspan="7">등록된 계약 내역이 없습니다.</td>
	                </tr>
	            </c:if>
	        </tbody>
	    </table>
	
	    <div style="text-align:center; margin-top:20px;">
	        <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_link_page" />
	    </div>
	
	    <div style="margin-top: 20px;">
	        <a href="<c:url value='/pms/addContractView.do'/>" class="btn btn-blue">신규 계약 등록</a>
	    </div>
	
	    <script type="text/javascript">
	        function fn_egov_link_page(pageNo){
	            document.listForm.pageIndex.value = pageNo;
	            document.listForm.action = "<c:url value='/pms/contractList.do'/>";
	            document.listForm.submit();
	        }
	        
	        function fn_open_contract_popup(contId, contNm) {
	            var windowName = "contract_pop_" + contId;
	            var url = "<c:url value='/pms/contractDetailPopup.do'/>?selectedId=" + contId;
	            var options = "width=700, height=600, resizable=yes, scrollbars=yes, status=no";
	            window.open(url, windowName, options);
	        }
	    </script>
    </div>
</body>
</html>