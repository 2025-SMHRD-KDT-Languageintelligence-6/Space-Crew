<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>사용자 정보 수정</title>
    <%-- 공용 등록/수정 폼 CSS 연결 --%>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/egovframework/com/pms/Regist-Updt-Form.css'/>">
</head>
<body>

    <div class="form-container">
        <h2>사용자 정보 수정</h2>

        <%-- 수정 처리를 위해 action 경로가 updateUser.do인지 확인해 주세요 --%>
        <form:form modelAttribute="userVO" action="${pageContext.request.contextPath}/pms/updateUser.do" method="post">

            <%-- 필수: 데이터 수정을 위한 키 값 --%>
            <form:hidden path="userId" />

            <table>
                <tr>
                    <th>사원번호</th>
                    <td>
                        <span class="readonly-id"><c:out value="${userVO.userId}"/></span>
                        <small style="color: #868e96; margin-left: 10px;">(사원번호는 수정할 수 없습니다)</small>
                    </td>
                <tr>
                    <th class="required">성명</th>
                    <td><form:input path="userNm" required="required" placeholder="이름 입력" /></td>
                </tr>
                <tr>
                    <th>부서명</th>
                    <td><form:input path="deptNm" placeholder="소속 부서" /></td>
                </tr>
                <tr>
                    <th>직무 / 직급</th>
                    <td>
                        <div style="display: flex; gap: 10px;">
                            <form:input path="jobRole" placeholder="직무 (예: 개발)" style="flex: 1;" />
                            <form:input path="positionNm" placeholder="직급 (예: 대리)" style="flex: 1;" />
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
					        <form:input path="joinDt" type="date" 
					                    style="width: 180px; ${not empty userVO.joinDt ? 'background-color: #e9ecef;' : ''}" 
					                    required="required" 
					                    readonly="${not empty userVO.joinDt ? 'true' : 'false'}" />
					        
					        <c:if test="${not empty userVO.joinDt}">
					            <small style="color: #fa5252;">(입사일은 이미 등록되어 수정할 수 없습니다)</small>
					        </c:if>
					    </div>
                    </td>
                </tr>
                <tr>
                    <th class="required">재직여부</th>
                    <td>
                    	<form:input path="useYn" required="required" style="width: 50px;" min="0" placeholder="Y/N" />
                    </td>
                </tr>
                <tr>
                    <th class="required">보유스택</th>
                    <td>
                        <form:input path="skillDesc"/>
                    </td>
                </tr>
                <tr>
                    <th>특이사항</th>
                    <td></td>
                </tr>
            </table>

            <div class="btn-area">
                <button type="submit" class="btn btn-blue">수정완료</button>
                <a href="<c:url value='/pms/userList.do'/>" class="btn btn-gray">취소</a>
            </div>
        </form:form>
    </div>

</body>
</html>