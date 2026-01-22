<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>영업 등록</title>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/egovframework/com/pms/Regist-Updt-Form.css'/>">
    <style>
        .input-half { width: 45% !important; display: inline-block; }
        .unit-text { margin-left: 5px; color: #666; font-size: 0.9em; }
        .required::after { content: ' *'; color: red; }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>신규 영업 등록</h2>

        <form:form modelAttribute="salesVO" action="${pageContext.request.contextPath}/pms/addSales.do" method="post">
            <table>
                <colgroup>
                    <col style="width: 25%;">
                    <col style="width: 75%;">
                </colgroup>

                <tr>
                    <th class="required">영업건명</th>
                    <td><form:input path="salesTitle" required="required" placeholder="예: 2026년 인프라 고도화 사업" /></td>
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
                    <th class="required">영업담당자</th>
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
                        <input type="number" name="expectedAmt" class="input-half" placeholder="0" />
                        <span class="unit-text">원</span>
                    </td>
                </tr>

                <tr>
                    <th>예상 수주시점</th>
                    <td><input type="date" name="expectedDt" class="input-half" /></td>
                </tr>

                <tr>
                    <th>수주 확률</th>
                    <td>
                        <input type="number" name="probability" min="0" max="100" class="input-half" placeholder="0" />
                        <span class="unit-text">%</span>
                    </td>
                </tr>

                <tr>
                    <th>진행 상태</th>
                    <td>
                        <select name="status" class="input-half">
                            <option value="영업중">영업중</option>
                            <option value="수주완료">수주완료</option>
                            <option value="영업실패">영업실패</option>
                        </select>
                    </td>
                </tr>

                <tr>
                    <th>영업 내용</th>
                    <td>
                        <textarea name="salesContent" rows="6" style="width:95%;" placeholder="고객사 미팅 내용 및 향후 계획을 입력하세요."></textarea>
                    </td>
                </tr>
            </table>

            <div class="btn-area">
                <button type="submit" class="btn btn-blue">저장하기</button>
                <a href="<c:url value='/pms/salesList.do'/>" class="btn btn-gray">취소</a>
            </div>
        </form:form>
    </div>
</body>
</html>