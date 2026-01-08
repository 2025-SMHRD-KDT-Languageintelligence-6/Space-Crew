<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head><title>프로젝트 등록</title></head>
<body>
    <h2>프로젝트 등록</h2>
    <form:form modelAttribute="projectVO" action="${pageContext.request.contextPath}/pms/addProject.do" method="post">
        <table border="1">
            <tr>
                <th>프로젝트명</th>
                <td><form:input path="projNm" /></td>
            </tr>
            <tr>
                <th>유형</th>
                <td>
                    <form:select path="projType">
                        <form:option value="개발" label="개발"/>
                        <form:option value="유지보수" label="유지보수"/>
                        <form:option value="인프라" label="인프라"/>
                    </form:select>
                </td>
            </tr>
            <tr>
                <th>상태</th>
                <td><form:input path="status" /></td>
            </tr>
            <tr>
                <th>시작일</th>
                <td><form:input path="startDt" placeholder="YYYY-MM-DD" /></td>
            </tr>
            <tr>
                <th>종료일</th>
                <td><form:input path="endDt" placeholder="YYYY-MM-DD" /></td>
            </tr>
        </table>
        <br>
        <button type="submit">저장하기</button>
        <a href="<c:url value='/pms/projectList.do'/>">목록으로</a>
    </form:form>
</body>
</html>