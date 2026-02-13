<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
	<style>
		.fav-link {
		    text-decoration: none;
		    transition: transform 0.2s ease-in-out;
		    display: inline-block;
		}
		
		.fav-link:hover {
		    transform: scale(1.2);
		}
	</style>
	<title>데이터 복구</title>
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/egovframework/com/pms/ProjectList.css'/>?v=1.1">
</head>
<body>
	<c:import url="/WEB-INF/jsp/egovframework/com/pms/include/menu.jsp" />

	<div class="content-page">
	    <h2>삭제 목록</h2>

	    <div class="search-box">
		    <form name="listForm" action="<c:url value='/pms/deleteList.do'/>" method="post">
		        <input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
		
		        <select name="targetType" style="width:120px; height:35px; vertical-align:middle;">
		            <option value="">유형</option>
		            <option value="CUSTOMER" <c:if test="${searchVO.targetType == 'CUSTOMER'}">selected</c:if>>고객사</option>
		            <option value="SALES" <c:if test="${searchVO.targetType == 'SALES'}">selected</c:if>>영업</option>
		            <option value="CONTRACT" <c:if test="${searchVO.targetType == 'CONTRACT'}">selected</c:if>>계약</option>
		            <option value="PROJECT" <c:if test="${searchVO.targetType == 'PROJECT'}">selected</c:if>>업무</option>
		            <option value="ASSIGNMENT" <c:if test="${searchVO.targetType == 'ASSIGNMENT'}">selected</c:if>>세부업무</option>
		            <option value="BILLING" <c:if test="${searchVO.targetType == 'BILLING'}">selected</c:if>>청구/정산</option>
		        	<option value="EMP" <c:if test="${searchVO.targetType == 'EMP'}">selected</c:if>>직원</option>
		        </select>
		
		        <label> 명칭: </label>
		        <input type="text" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>" placeholder="검색어를 입력하세요" style="width:200px;" />
		        <button type="submit" class="btn btn-blue">검색</button>
		    </form>
		</div>

	    <table>
		    <thead>
		        <tr>
		            <th width="10%">유형</th>
		            <th width="35%">데이터 명칭</th>
		            <th width="15%">삭제자</th>
		            <th width="20%">삭제 일시</th>
		            <th width="20%">복구 관리</th>
		        </tr>
		    </thead>
		    <tbody>
		        <c:forEach var="result" items="${resultList}">
		            <tr>
		                <td><span class="badge badge-gray"><c:out value="${result.targetType}"/></span></td>
		                <td class="text-left" style="font-weight:bold;"><c:out value="${result.title}"/></td>
		                <td><c:out value="${result.delUsrId}"/></td> <td><c:out value="${result.delDt}"/></td>
		                <td>
		                    <a href="javascript:void(0);" 
		                       class="btn btn-blue btn-sm" 
		                       onclick="fn_restore_data('${result.targetType}', '${result.targetId}');">
		                       <i class="fas fa-undo"></i> 복구하기
		                    </a>
		                </td>
		            </tr>
		        </c:forEach>
		    </tbody>
		</table>
		
		<div class="pagination-wrapper" style="text-align:center; margin-top:20px;">
	        <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_link_page" />
	    </div>
		
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
		
		<script type="text/javascript">
			function fn_restore_data(targetType, targetId) {
			    if(!confirm("해당 데이터를 복구하시겠습니까?")) return;
	
			    $.ajax({
			        url: "<c:url value='/pms/restoreDataAjax.do'/>",
			        type: "POST",
			        data: { 
			            "targetType": targetType, 
			            "targetId": targetId 
			        },
			        success: function(data) {
			            if(data === "SUCCESS") {
			                alert("성공적으로 복구되었습니다!");
			                location.reload();
			            } else {
			                alert("복구에 실패했습니다. 로그를 확인하세요.");
			            }
			        },
			        error: function() { alert("서버 통신 오류가 발생했습니다."); }
			    });
			}
	    </script>
	</div>
</body>
</html>