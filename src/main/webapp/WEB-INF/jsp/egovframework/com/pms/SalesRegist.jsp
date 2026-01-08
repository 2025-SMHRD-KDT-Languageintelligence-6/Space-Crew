<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>영업 등록</title>
    <style>
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid #ddd; padding: 10px; }
        th { background-color: #f4f4f4; width: 20%; }
        input, select, textarea { width: 95%; padding: 5px; }
    </style>
</head>
<body>
    <h2>신규 영업 등록</h2>
    <form:form modelAttribute="salesVO" action="${pageContext.request.contextPath}/pms/addSales.do" method="post">
        <table>
            <tr>
                <th>영업건명 *</th>
                <td><form:input path="salesTitle" required="required" /></td>
            </tr>
            <tr>
                <th>고객사 *</th>
                <td>
                    <form:select path="custId" required="required">
                        <form:option value="" label="-- 고객사 선택 --"/>
                        <form:options items="${customerList}" itemValue="custId" itemLabel="custNm"/>
                    </form:select>
                </td>
            </tr>
            <tr>
                <th>담당 영업사원 *</th>
                <td>
                    <form:select path="salesUserId" required="required">
                        <form:option value="" label="-- 담당자 선택 --"/>
                        <c:forEach var="user" items="${userList}">
                            <form:option value="${user.userId}" label="${user.userNm} (${user.deptNm})"/>
                        </c:forEach>
                    </form:select>
                </td>
            </tr>
            <tr>
                <th>예상 수주금액</th>
                <td><form:input path="expectedAmt" type="number" /> 원</td>
            </tr>
            <tr>
                <th>예상 수주시점</th>
                <td><form:input path="expectedDt" type="date" /></td>
            </tr>
            <tr>
                <th>수주 확률 (%)</th>
                <td><form:input path="probability" type="number" min="0" max="100" /></td>
            </tr>
            <tr>
                <th>진행 상태</th>
                <td>
                    <form:select path="status">
                        <form:option value="영업중" label="영업중"/>
                        <form:option value="수주완료" label="수주완료"/>
                        <form:option value="영업실패" label="영업실패"/>
                    </form:select>
                </td>
            </tr>
            <tr>
                <th>영업 내용</th>
                <td><form:textarea path="salesContent" rows="5" /></td>
            </tr>
        </table>
        <div style="margin-top:20px; text-align:center;">
            <button type="submit" class="btn-blue" style="padding:10px 20px;">저장</button>
            <a href="<c:url value='/pms/salesList.do'/>">취소</a>
        </div>
    </form:form>
</body>
</html>