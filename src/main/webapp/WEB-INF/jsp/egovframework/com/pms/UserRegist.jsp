<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>사용자 등록</title>
    <style>
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid #ddd; padding: 10px; }
        th { background-color: #f4f4f4; width: 20%; }
        .btn-area { margin-top: 20px; text-align: center; }
        .btn { padding: 7px 15px; cursor: pointer; text-decoration: none; border: none; border-radius: 3px; }
        .btn-blue { background: #007bff; color: white; }
        .btn-gray { background: #6c757d; color: white; }
    </style>
</head>
<body>

    <h2>사용자 등록</h2>

    <form:form modelAttribute="userVO" action="${pageContext.request.contextPath}/pms/addUser.do" method="post">
        <table>
            <tr>
                <th>아이디</th>
                <td><form:input path="userId" required="required" /></td>
            </tr>
            <tr>
                <th>비밀번호</th>
                <td><form:password path="userPwd" required="required" /></td>
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
                <th>경력(년)</th>
                <td><form:input path="careerYears" type="number" /></td>
            </tr>
            <tr>
                <th>전문분야</th>
                <td><form:input path="jobField" /></td>
            </tr>
            <tr>
                <th>입사일</th>
                <td><form:input path="joinDt" type="date" /></td>
            </tr>
            <tr>
                <th>권한레벨</th>
                <td>
                    <form:select path="authLevel">
                        <form:option value="2" label="일반사용자"/>
                        <form:option value="1" label="관리자"/>
                    </form:select>
                </td>
            </tr>
        </table>

        <div class="btn-area">
            <button type="submit" class="btn btn-blue">등록</button>
            <a href="<c:url value='/pms/userList.do'/>" class="btn btn-gray">취소</a>
        </div>
    </form:form>

</body>
</html>