<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>프로젝트 목록</title>
</head>
<body>
    <h2>PMS 프로젝트 목록</h2>
    <table border="1" style="width:100%; border-collapse:collapse;">
        <thead>
            <tr>
                <th>ID</th>
                <th>프로젝트명</th>
                <th>상태</th>
                <th>시작일</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="result" items="${resultList}" varStatus="status">
                <tr>
                    <td><c:out value="${result.projId}"/></td>
                    <td>
					    <a href="<c:url value='/pms/updateProjectView.do'/>?selectedId=${result.projId}">
					        <c:out value="${result.projNm}"/>
					    </a>
					</td>
                    <td><c:out value="${result.status}"/></td>
                    <td><c:out value="${result.startDt}"/></td>
                    <td>
					    <a href="<c:url value='/pms/deleteProject.do'/>?selectedId=${result.projId}" 
					       onclick="return confirm('정말 삭제하시겠습니까?');" 
					       style="color:red;">삭제</a>
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

</body>
</html>