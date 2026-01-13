<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>청구 등록</title>
    <%-- 기존에 생성한 공용 등록/수정 폼 CSS 연결 --%>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/egovframework/com/pms/Regist-Updt-Form.css'/>">
</head>
<body>

    <div class="form-container">
        <h2>신규 청구 등록</h2>

        <form:form modelAttribute="billingVO" action="${pageContext.request.contextPath}/pms/addBilling.do" method="post">
            <table>
                <tr>
                    <th class="required">연관 프로젝트</th>
                    <td>
                        <form:select path="projId" required="required">
                            <form:option value="" label="-- 프로젝트 선택 --"/>
                            <form:options items="${projectList}" itemValue="projId" itemLabel="projNm"/>
                        </form:select>
                    </td>
                </tr>
                <tr>
                    <th class="required">청구 명칭</th>
                    <td><form:input path="billTitle" placeholder="예: 1차 중도금 청구" required="required" /></td>
                </tr>
                <tr>
                    <th class="required">청구 금액</th>
                    <td>
                        <div style="display: flex; align-items: center;">
                            <form:input path="billAmt" type="number" required="required" style="width: 200px;" />
                            <span style="margin-left: 10px; font-weight: bold; color: #666;">원</span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>계산서 발행일</th>
                    <td><form:input path="taxBillDt" type="date" style="width: 200px;" /></td>
                </tr>
                <tr>
                    <th>입금 예정일</th>
                    <td><form:input path="payDt" type="date" style="width: 200px;" /></td>
                </tr>
                <tr>
                    <th>입금 여부</th>
                    <td class="radio-group">
                        <form:radiobutton path="isPaid" value="N" id="paidN" /><label for="paidN">미납</label>
                        <form:radiobutton path="isPaid" value="Y" id="paidY" style="margin-left:20px;" /><label for="paidY">입금완료</label>
                    </td>
                </tr>
                <tr>
                    <th>실제 입금일</th>
                    <td><form:input path="actualPayDt" type="date" style="width: 200px;" /></td>
                </tr>
                <tr>
                    <th>비고</th>
                    <td><form:textarea path="billRemark" rows="4" placeholder="특이사항을 입력하세요." /></td>
                </tr>
            </table>

            <div class="btn-area">
                <button type="submit" class="btn btn-blue">청구 저장</button>
                <a href="<c:url value='/pms/billingList.do'/>" class="btn btn-gray">취소</a>
            </div>
        </form:form>
    </div>

</body>
</html>