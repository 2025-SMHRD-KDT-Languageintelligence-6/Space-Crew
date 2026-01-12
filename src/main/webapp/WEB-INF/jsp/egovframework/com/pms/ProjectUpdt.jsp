<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head><title>업무 수정</title></head>
<body>
    <h2>업무 수정</h2>
    <form:form modelAttribute="projectVO" action="${pageContext.request.contextPath}/pms/addProject.do" method="post">
        
        <form:hidden path="projId" />

        <table border="1">
            <tr>
                <th>업무명</th>
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
                <td><form:input path="startDt" /></td>
            </tr>
            <tr>
                <th>종료일</th>
                <td><form:input path="endDt" /></td>
            </tr>
        </table>
        <br>
        <button type="submit">수정완료</button>
        <a href="<c:url value='/pms/projectList.do'/>">취소</a>
    </form:form>
</body>
</html>