<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>영업 정보 수정</title>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/egovframework/com/pms/Regist-Updt-Form.css'/>">
    <style>
        .input-half { width: 45% !important; display: inline-block; }
        .unit-text { margin-left: 5px; color: #666; font-size: 0.9em; }
        .readonly-text { font-weight: bold; color: #555; background: #f9f9f9; padding: 5px 10px; border-radius: 4px; border: 1px solid #ddd; }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>영업 정보 수정</h2>

        <form:form modelAttribute="salesVO" action="${pageContext.request.contextPath}/pms/updateSales.do" method="post">
            <%-- 수정 시 반드시 필요한 PK 값 --%>
            <form:hidden path="salesId" />

            <table>
                <colgroup>
                    <col style="width: 25%;">
                    <col style="width: 75%;">
                </colgroup>

                <tr>
                    <th>영업 번호</th>
                    <td><span class="readonly-text"><c:out value="${salesVO.salesId}"/></span></td>
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
                        <input type="number" name="expectedAmt" min="0" oninput="if(this.value < 0) this.value = 0;" value="${salesVO.expectedAmt}" class="input-half" />
                        <span class="unit-text">원</span>
                    </td>
                </tr>

                <tr>
                    <th>예상 수주시점</th>
                    <td>
                        <input type="date" name="expectedDt" value="${salesVO.expectedDt}" class="input-half" />
                    </td>
                </tr>

                <tr>
                    <th>수주 확률</th>
                    <td>
                        <input type="number" name="probability" value="${salesVO.probability}" min="0" max="100" class="input-half" />
                        <span class="unit-text">%</span>
                    </td>
                </tr>

                <tr>
                    <th>진행 상태</th>
                    <td>
                        <select name="status" class="input-half">
                            <option value="영업중" <c:if test="${salesVO.status eq '영업중'}">selected</c:if>>영업중</option>
                            <option value="영업완료" <c:if test="${salesVO.status eq '영업완료'}">selected</c:if>>영업완료</option>
                            <option value="영업취소" <c:if test="${salesVO.status eq '영업취소'}">selected</c:if>>영업취소</option>
                            <option value="보류" <c:if test="${salesVO.status eq '보류'}">selected</c:if>>보류</option>
                        </select>
                    </td>
                </tr>

                <tr>
                    <th>영업 내용</th>
                    <td>
                        <textarea name="salesContent" rows="6" style="width:95%;"><c:out value="${salesVO.salesContent}"/></textarea>
                    </td>
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