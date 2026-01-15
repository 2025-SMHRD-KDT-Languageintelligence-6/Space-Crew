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
                </tr>
                <tr>
                    <th class="required">성명</th>
                    <td><form:input path="userNm" required="required" placeholder="성명을 입력하세요" /></td>
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
                    <th>재직 여부</th>
                    <td class="radio-group">
                        <form:radiobutton path="useYn" value="Y" id="useY" /><label for="useY">재직</label>
                        <form:radiobutton path="useYn" value="N" id="useN" style="margin-left:20px;" /><label for="useN">미재직</label>
                    </td>
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