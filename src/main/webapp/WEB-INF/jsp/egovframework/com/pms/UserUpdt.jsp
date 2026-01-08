<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>사용자 정보 수정</title>
    <style>
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid #ddd; padding: 10px; }
        th { background-color: #f4f4f4; width: 20%; }
        .btn-area { margin-top: 20px; text-align: center; }
        .btn { padding: 7px 15px; cursor: pointer; text-decoration: none; border: none; border-radius: 3px; }
        .btn-blue { background: #007bff; color: white; }
        .btn-gray { background: #6c757d; color: white; }
        .readonly { background-color: #eee; }
    </style>
</head>
<body>

    <h2>사용자 정보 수정</h2>

    <form:form modelAttribute="userVO" action="${pageContext.request.contextPath}/pms/addUser.do" method="post">
        <form:hidden path="userId" />
        
        <table>
            <tr>
                <th>아이디</th>
                <td><strong><c:out value="${userVO.userId}"/></strong> (아이디는 수정 불가)</td>
            </tr>
            <tr>
                <th>성명</th>
                <td><form:input path="userNm" required="required" /></td>
            </tr>
            <tr>
                <th>부서명</th>
                <td><form:input path="deptNm" /></td>
            </tr>
            <tr>
                <th>직무</th>
                <td><form:input path="jobRole" /></td>
            </tr>
            <tr>
                <th>직위</th>
                <td><form:input path="positionNm" /></td>
            </tr>
            <tr>
                <th>업무 부하량(%)</th>
                <td><form:input path="currentLoad" type="number" step="0.01" /></td>
            </tr>
            <tr>
                <th>사용 여부</th>
                <td>
                    <form:radiobutton path="useYn" value="Y" label="사용"/>
                    <form:radiobutton path="useYn" value="N" label="미사용"/>
                </td>
            </tr>
        </table>

        <div class="btn-area">
            <button type="submit" class="btn btn-blue">수정완료</button>
            <a href="<c:url value='/pms/userList.do'/>" class="btn btn-gray">취소</a>
        </div>
    </form:form>

</body>
</html>