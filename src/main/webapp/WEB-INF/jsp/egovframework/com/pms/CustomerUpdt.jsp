<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>고객사 정보 수정</title>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/egovframework/com/pms/Customer-Form.css'/>">
</head>
<body>

    <div class="form-container">
        <h2>고객사 정보 수정</h2>

        <form:form modelAttribute="customerVO" action="${pageContext.request.contextPath}/pms/updateCustomer.do" method="post">
            <%-- 수정 시 필수인 PK 값 --%>
            <form:hidden path="custId" />

            <table>
                <tr>
                    <th>고객사 ID</th>
                    <%-- 수정 불가능한 필드는 강조 스타일 적용 --%>
                    <td><span class="readonly-id"><c:out value="${customerVO.custId}"/></span> <small>(자동생성)</small></td>
                </tr>
                <tr>
                    <th class="required">고객사명</th>
                    <td><form:input path="custNm" required="required" /></td>
                </tr>
                <tr>
                    <th>사업자 등록번호</th>
                    <td><form:input path="bizRegNo" /></td>
                </tr>
                <tr>
                    <th>대표자명</th>
                    <td><form:input path="ceoNm" /></td>
                </tr>
                <tr>
                    <th>담당자 성함</th>
                    <td><form:input path="picNm" /></td>
                </tr>
                <tr>
                    <th>담당자 연락처</th>
                    <td><form:input path="picTel" /></td>
                </tr>
                <tr>
                    <th>담당자 이메일</th>
                    <td><form:input path="picEmail" type="email" /></td>
                </tr>
                <tr>
                    <th>고객사 주소</th>
                    <td><form:input path="custAddr" /></td>
                </tr>
                <tr>
                    <th>특이사항</th>
                    <td><form:textarea path="custRemark" rows="4" /></td>
                </tr>
            </table>

            <div class="btn-area">
                <button type="submit" class="btn btn-blue">수정완료</button>
                <a href="<c:url value='/pms/customerList.do'/>" class="btn btn-gray">취소</a>
            </div>
        </form:form>
    </div>

</body>
</html>