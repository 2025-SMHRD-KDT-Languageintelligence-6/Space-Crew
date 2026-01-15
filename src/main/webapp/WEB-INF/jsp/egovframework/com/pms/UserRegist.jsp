<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>사용자 등록</title>
    <%-- 기존에 생성한 공용 등록/수정 폼 CSS 연결 --%>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/egovframework/com/pms/Regist-Updt-Form.css'/>">
</head>
<body>

    <div class="form-container">
        <h2>신규 직원 등록</h2>

        <form:form modelAttribute="userVO" action="${pageContext.request.contextPath}/pms/addUser.do" method="post">
            <table>
                <tr>
                    <th class="required">사원번호</th>
                    <td><form:input path="userId" required="required" placeholder="사원번호 입력" /></td>
                </tr>
                <tr>
                    <th class="required">성명</th>
                    <td><form:input path="userNm" required="required" placeholder="이름 입력" /></td>
                </tr>
                <tr>
                    <th>부서명</th>
                    <td><form:input path="deptNm" placeholder="소속 부서" /></td>
                </tr>
                <tr>
                    <th>직무 / 직위</th>
                    <td>
                        <div style="display: flex; gap: 10px;">
                            <form:input path="jobRole" placeholder="직무 (예: 개발)" style="flex: 1;" />
                            <form:input path="positionNm" placeholder="직위 (예: 대리)" style="flex: 1;" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>경력(년)</th>
                    <td>
                        <form:input path="careerYears" type="number" style="width: 150px;" min="0" />
                        <span style="margin-left: 10px; font-weight: bold; color: #666;">년</span>
                    </td>
                </tr>
                <tr>
                    <th>전문분야</th>
                    <td><form:input path="jobField" placeholder="예: Java, Spring Boot, React" /></td>
                </tr>
                <tr>
                    <th class="required">입사일</th>
                    <td>
                        <div style="display: flex; align-items: center; gap: 15px;">
                            <form:input path="joinDt" type="date" style="width: 180px;" required="required" />
                        </div>
                    </td>
                </tr>
            </table>

            <div class="btn-area">
                <button type="submit" class="btn btn-blue">등록하기</button>
                <a href="<c:url value='/pms/userList.do'/>" class="btn btn-gray">취소</a>
            </div>
        </form:form>
    </div>

</body>
</html>