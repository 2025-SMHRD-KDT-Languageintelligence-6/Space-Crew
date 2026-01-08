<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>고객사 등록</title>
    <style>
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid #ddd; padding: 10px; }
        th { background-color: #f4f4f4; width: 20%; text-align: left; }
        .btn-area { margin-top: 20px; text-align: center; }
        .btn { padding: 7px 15px; cursor: pointer; text-decoration: none; border: none; border-radius: 3px; display: inline-block;}
        .btn-blue { background: #007bff; color: white; }
        .btn-gray { background: #6c757d; color: white; }
        input[type="text"], input[type="email"] { width: 90%; padding: 5px; }
        textarea { width: 90%; padding: 5px; }
    </style>
</head>
<body>

    <h2>신규 고객사 등록</h2>

    <form:form modelAttribute="customerVO" action="${pageContext.request.contextPath}/pms/addCustomer.do" method="post">
        <table>
            <tr>
                <th>고객사명 *</th>
                <td><form:input path="custNm" required="required" placeholder="예: (주)대한시스템즈" /></td>
            </tr>
            <tr>
                <th>사업자 등록번호</th>
                <td><form:input path="bizRegNo" placeholder="000-00-00000" /></td>
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
                <td><form:input path="picTel" placeholder="010-0000-0000" /></td>
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
            <button type="submit" class="btn btn-blue">저장하기</button>
            <a href="<c:url value='/pms/customerList.do'/>" class="btn btn-gray">취소</a>
        </div>
    </form:form>

</body>
</html>