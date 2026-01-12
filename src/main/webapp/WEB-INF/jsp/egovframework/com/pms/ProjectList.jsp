<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>업무 목록</title>
	<style>
		.content-page { margin-left: 220px; padding: 20px; }
	</style>
</head>
<body>
	<c:import url="/WEB-INF/jsp/egovframework/com/pms/include/menu.jsp" />
	<div class="content-page">
	    <h2>PMS 업무 목록</h2>
	    <table border="1" style="width:100%; border-collapse:collapse;">
	        <thead>
	            <tr>
	                <th>ID</th>
	                <th>업무명</th>
	                <th>상태</th>
	                <th>시작일</th>
	            </tr>
	        </thead>
	        <tbody>
	            <c:forEach var="result" items="${resultList}" varStatus="status">
	                <tr>
	                    <td><c:out value="${result.projId}"/></td>
	                    <td>
						    <a href="javascript:void(0);" onclick="fn_open_project_popup('${result.projId}', '${result.projNm}');" style="font-weight:bold; color:#007bff;">
						        <c:out value="${result.projNm}"/>
						    </a>
						</td>
	                    <td><c:out value="${result.status}"/></td>
	                    <td><c:out value="${result.startDt}"/></td>
	                    <td>
						    <a href="<c:url value='/pms/updateProjectView.do'/>?selectedId=${result.projId}" 
     						   class="btn" style="padding: 2px 5px; font-size: 12px; background:#ffc107;">수정</a>
     						   
	                        <a href="<c:url value='/pms/deleteProject.do'/>?selectedId=${result.projId}" 
	                           class="btn btn-red" style="padding: 2px 5px; font-size: 12px;"
	                           onclick="return confirm('고객사 정보를 삭제하시겠습니까?');">삭제</a>
						</td>
	                </tr>
	            </c:forEach>
	            <c:if test="${empty resultList}">
	                <tr>
	                    <td colspan="4">조회된 데이터가 없습니다.</td>
	                </tr>
	            </c:if>
	        </tbody>
	    </table>
	    
	    <div style="margin-top: 20px;">
	   		<a href="<c:url value='/pms/addProjectView.do'/>" style="padding: 10px; background: blue; color: white; text-decoration: none;">신규 프로젝트 등록</a>
		</div>
		<script type="text/javascript">
	        function fn_egov_link_page(pageNo){
	            document.listForm.pageIndex.value = pageNo;
	            document.listForm.action = "<c:url value='/pms/projectList.do'/>";
	            document.listForm.submit();
	        }
	        
	        function fn_open_customer_popup(projId, projNm) {
	            var windowName = "project_pop_" + custId;
	            var url = "<c:url value='/pms/projectDetailPopup.do'/>?selectedId=" + projId;
	            var options = "width=700, height=600, resizable=yes, scrollbars=yes, status=no";
	            window.open(url, windowName, options);
	        }
	    </script>
	</div>
</body>
</html>