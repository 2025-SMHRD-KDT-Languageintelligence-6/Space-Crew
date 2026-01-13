<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>영업 정보 수정</title>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/egovframework/com/pms/SalesForm.css'/>">
</head>
<body>
    <div class="form-container">
        <h2>영업 정보 수정</h2>

        <%-- 주의: action을 updateSales.do로 변경하는 것을 권장합니다 --%>
        <form:form modelAttribute="salesVO" action="${pageContext.request.contextPath}/pms/updateSales.do" method="post">

            <form:hidden path="salesId" />

            <table>
                <tr>
                    <th>영업 번호</th>
                    <td><span class="readonly-text">#<c:out value="${salesVO.salesId}"/></span></td>
                </tr>
                <tr>
                    <th class="required">영업건명</th>
                    <td><form:input path="salesTitle" required="required" /></td>
                </tr>
                <tr>
                    <th class="required">고객사</th>
                    <td>
                        <form:select path="custId" required="required">
                            <form:option value="" label="-- 고객사 선택 --"/>
                            <form:options items="${customerList}" itemValue="custId" itemLabel="custNm"/>
                        </form:select>
                    </td>
                </tr>
                <tr>
                    <th class="required">담당 영업사원</th>
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
                    <td>
                        <div style="display:flex; align-items:center;">
                            <form:input path="expectedAmt" type="number" style="width:200px;" />
                            <span style="margin-left:10px;">원</span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>예상 수주시점</th>
                    <td><form:input path="expectedDt" type="date" style="width:200px;" /></td>
                </tr>
                <tr>
                    <th>수주 확률 (%)</th>
                    <td><form:input path="probability" type="number" min="0" max="100" style="width:100px;" /> %</td>
                </tr>
                <tr>
                    <th>진행 상태</th>
                    <td>
                        <form:select path="status" style="width:150px;">
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

            <div class="btn-area">
                <button type="submit" class="btn btn-blue">수정완료</button>
                <a href="<c:url value='/pms/salesList.do'/>" class="btn btn-gray">취소</a>
            </div>
        </form:form>
    </div>
</body>
</html>