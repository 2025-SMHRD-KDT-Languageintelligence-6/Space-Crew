<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>계약 정보 수정</title>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/egovframework/com/pms/Regist-Updt-Form.css'/>">
</head>
<body>

    <div class="form-container">
        <h2>계약 정보 수정</h2>

        <form:form modelAttribute="contractVO" action="${pageContext.request.contextPath}/pms/updateContract.do" method="post">
            <%-- 수정 시 필수 식별 값 --%>
            <form:hidden path="contId" />

            <table>
                <colgroup>
                    <col style="width: 20%;">
                    <col style="width: 80%;">
                </colgroup>

                <tr>
                    <th class="required">계약명</th>
                    <td><form:input path="contNm" required="required" style="width:80%;" /></td>
                </tr>

                <tr>
                    <th class="required">고객사</th>
                    <td><form:input path="custNm" required="required" style="width:80%;" placeholder="고객사명을 입력하세요" /></td>
                </tr>

                <tr>
                    <th class="required">계약담당자</th>
                    <td><form:input path="picUserNm" required="required" style="width:50%;" placeholder="담당자 이름을 입력하세요" /></td>
                </tr>

                <tr>
                    <th class="required">계약금액</th>
                    <td>
                        <form:input path="contAmt" type="number" style="width:200px;" />
                        <span style="margin-left:5px; font-weight:bold; color:#666;">원</span>
                    </td>
                </tr>

                <tr>
                    <th class="required">계약일자</th>
                    <td><form:input path="contDt" type="date" /></td>
                </tr>

                <tr>
                    <th>수행 시작일</th>
                    <td><form:input path="startDt" type="date" /></td>
                </tr>

                <tr>
                    <th>수행 종료일</th>
                    <td><form:input path="endDt" type="date" /></td>
                </tr>

                <tr>
                    <th>계약상태</th>
                    <td><form:input path="contStatus" style="width:50%;" placeholder="예: 대기, 진행, 완료" /></td>
                </tr>

                <tr>
                    <th>비고</th>
                    <td><form:textarea path="contRemark" rows="5" style="width:80%;" placeholder="기타 참고사항을 입력하세요" /></td>
                </tr>
            </table>

            <div class="btn-area">
                <button type="submit" class="btn btn-blue">수정완료</button>
                <a href="<c:url value='/pms/contractList.do'/>" class="btn btn-gray">취소</a>
            </div>
        </form:form>
    </div>

</body>
</html>