<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>청구 수정</title>
    <style>
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid #ddd; padding: 10px; }
        th { background-color: #f4f4f4; width: 20%; }
        input, select, textarea { width: 95%; padding: 5px; }
    </style>
</head>
<body>
    <h2>청구 수정</h2>
    <form:form modelAttribute="billingVO" action="${pageContext.request.contextPath}/pms/addBilling.do" method="post">
        <form:hidden path="billId" />
        <table>
            <tr>
                <th>연관 프로젝트 *</th>
                <td>
                    <form:select path="projectId" required="required">
                        <form:option value="" label="-- 프로젝트 선택 --"/>
                        <form:options items="${projectList}" itemValue="projId" itemLabel="projNm"/>
                    </form:select>
                </td>
            </tr>
            <tr>
                <th>청구 명칭 *</th>
                <td><form:input path="billTitle" placeholder="예: 1차 중도금 청구" required="required" /></td>
            </tr>
            <tr>
                <th>청구 금액 *</th>
                <td><form:input path="billAmt" type="number" required="required" /> 원</td>
            </tr>
            <tr>
                <th>계산서 발행일</th>
                <td><form:input path="taxBillDt" type="date" /></td>
            </tr>
            <tr>
                <th>입금 예정일</th>
                <td><form:input path="payDt" type="date" /></td>
            </tr>
            <tr>
                <th>입금 여부</th>
                <td>
                    <form:radiobutton path="isPaid" value="N" label="미납" />
                    <form:radiobutton path="isPaid" value="Y" label="입금완료" />
                </td>
            </tr>
            <tr>
                <th>실제 입금일</th>
                <td><form:input path="actualPayDt" type="date" /></td>
            </tr>
            <tr>
                <th>비고</th>
                <td><form:textarea path="billRemark" rows="4" /></td>
            </tr>
        </table>
        <div style="margin-top:20px; text-align:center;">
            <button type="submit" class="btn-blue" style="padding:10px 20px; cursor:pointer;">수정 완료</button>
            <a href="<c:url value='/pms/billingList.do'/>">취소</a>
        </div>
    </form:form>
</body>
</html>