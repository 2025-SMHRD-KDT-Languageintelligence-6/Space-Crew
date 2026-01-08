<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>계약 수정</title>
    <style>
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid #ddd; padding: 10px; }
        th { background-color: #f4f4f4; width: 20%; }
        .btn-area { margin-top: 20px; text-align: center; }
        .btn { padding: 7px 15px; cursor: pointer; text-decoration: none; border: none; border-radius: 3px; }
        .btn-blue { background: #007bff; color: white; }
    </style>
</head>
<body>

    <h2>계약 수정</h2>

    <form:form modelAttribute="contractVO" action="${pageContext.request.contextPath}/pms/addContract.do" method="post">
        <form:hidden path="contId" />

        <table>
            <tr>
                <th>계약명</th>
                <td><form:input path="contNm" required="required" style="width:80%;" /></td>
            </tr>
            <tr>
                <th>계약금액</th>
                <td><form:input path="contAmt" type="number" /> 원</td>
            </tr>
            <tr>
                <th>계약일자</th>
                <td><form:input path="contDt" type="date" /></td>
            </tr>
            <tr>
                <th>수행기간</th>
                <td>
                    <form:input path="startDt" type="date" /> ~ 
                    <form:input path="endDt" type="date" />
                </td>
            </tr>
            <tr>
                <th>내부 담당자</th>
                <td>
                    <form:select path="picUserId">
                        <c:forEach var="user" items="${userList}">
                            <form:option value="${user.userId}" label="${user.userNm} (${user.deptNm})"/>
                        </c:forEach>
                    </form:select>
                </td>
            </tr>
            <tr>
                <th>계약상태</th>
                <td>
                    <form:select path="contStatus">
                        <form:option value="대기" label="대기"/>
                        <form:option value="진행" label="진행"/>
                        <form:option value="완료" label="완료"/>
                        <form:option value="파기" label="파기"/>
                    </form:select>
                </td>
            </tr>
            <tr>
                <th>비고</th>
                <td><form:textarea path="contRemark" rows="5" style="width:80%;" /></td>
            </tr>
        </table>

        <div class="btn-area">
            <button type="submit" class="btn btn-blue">수정완료</button>
            <a href="<c:url value='/pms/contractList.do'/>" class="btn">취소</a>
        </div>
    </form:form>

</body>
</html>