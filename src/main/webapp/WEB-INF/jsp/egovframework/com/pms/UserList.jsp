<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>사용자 관리 목록</title>
    <style>
        table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: center; }
        th { background-color: #f4f4f4; }
        .search-box { margin-bottom: 20px; padding: 10px; background: #f9f9f9; }
        .btn { padding: 5px 10px; text-decoration: none; cursor: pointer; }
        .btn-blue { background: #007bff; color: white; border-radius: 3px; }
        .content-page { margin-left: 220px; padding: 20px; }
    </style>
</head>
<body>
	<c:import url="/WEB-INF/jsp/egovframework/com/pms/include/menu.jsp" />
	<div class="content-page">
	    <h2>사용자 관리 목록</h2>
	
	    <div class="search-box">
	        <form name="listForm" action="<c:url value='/pms/userList.do'/>" method="post">
	            <input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
	            
	            <label>사용자명: </label>
	            <input type="text" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>" />
	            <button type="submit" class="btn btn-blue">검색</button>
	        </form>
	    </div>
	
	    <table>
	        <thead>
	            <tr>
	                <th>아이디</th>
	                <th>성명</th>
	                <th>부서</th>
	                <th>직무</th>
	                <th>업무부하량</th>
	                <th>가입일</th>
	                <th>관리</th>
	            </tr>
	        </thead>
	        <tbody>
	            <c:forEach var="result" items="${resultList}" varStatus="status">
	                <tr>
	                    <td>
	                        <a href="javascript:void(0);" onclick="fn_open_user_popup('${result.userId}', '${result.userNm}');" style="font-weight:bold; color:#007bff;">
	                            <c:out value="${result.userId}"/>
	                        </a>
	                    </td>
	                    <td><c:out value="${result.userNm}"/></td>
	                    <td><c:out value="${result.deptNm}"/></td>
	                    <td><c:out value="${result.jobRole}"/></td>
	                    <td><c:out value="${result.currentLoad}"/> %</td>
	                    <td><c:out value="${result.joinDt}"/></td>
	                    <td>
		                    <a href="<c:url value='/pms/updateUserView.do'/>?selectedId=${result.userId}" 
     						   class="btn" style="padding: 2px 5px; font-size: 12px; background:#ffc107;">수정</a>
     						   
	                        <a href="<c:url value='/pms/deleteUser.do'/>?selectedId=${result.userId}" 
	                           class="btn btn-red" style="padding: 2px 5px; font-size: 12px;"
	                           onclick="return confirm('고객사 정보를 삭제하시겠습니까?');">삭제</a>
	                    </td>
	                </tr>
	            </c:forEach>
	            <c:if test="${empty resultList}">
	                <tr>
	                    <td colspan="7">등록된 사용자가 없습니다.</td>
	                </tr>
	            </c:if>
	        </tbody>
	    </table>
	
	    <div id="paging" style="text-align:center; margin-top:20px;">
	        <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_link_page" />
	    </div>
	
	    <div style="margin-top: 20px;">
	        <a href="<c:url value='/pms/addUserView.do'/>" class="btn btn-blue">신규 사용자 등록</a>
	        <a href="<c:url value='/pms/projectList.do'/>" class="btn" style="background:#6c757d; color:white;">프로젝트 목록으로</a>
	    </div>
	
	    <script type="text/javascript">
	        function fn_egov_link_page(pageNo){
	            document.listForm.pageIndex.value = pageNo;
	            document.listForm.action = "<c:url value='/pms/userList.do'/>";
	            document.listForm.submit();
	        }
	        
	        function fn_open_customer_popup(userId, userNm) {
	            var windowName = "user_pop_" + custId;
	            var url = "<c:url value='/pms/userDetailPopup.do'/>?selectedId=" + userId;
	            var options = "width=700, height=600, resizable=yes, scrollbars=yes, status=no";
	            window.open(url, windowName, options);
	        }
	    </script>
    </div>
</body>
</html>