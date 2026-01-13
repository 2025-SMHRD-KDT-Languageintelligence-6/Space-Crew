<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>업무 등록</title>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/egovframework/com/pms/Regist-Updt-Form.css'/>">
</head>
<body>

    <div class="form-container">
        <h2>업무 등록</h2>

        <form:form modelAttribute="projectVO" action="${pageContext.request.contextPath}/pms/addProject.do" method="post">
            <table>
                <tr>
                    <th class="required">업무명</th>
                    <td><form:input path="projNm" required="required" placeholder="업무명을 입력하세요" /></td>
                </tr>
                <tr>
                    <th class="required">유형</th>
                    <td>
                        <form:select path="projType">
                            <form:option value="개발" label="개발"/>
                            <form:option value="유지보수" label="유지보수"/>
                            <form:option value="인프라" label="인프라"/>
                        </form:select>
                    </td>
                </tr>
                <tr>
                    <th>상태</th>
                    <td>
                        <form:select path="status">
                            <form:option value="준비" label="준비"/>
                            <form:option value="진행" label="진행"/>
                            <form:option value="테스트" label="테스트"/>
                            <form:option value="종료" label="종료"/>
                        </form:select>
                    </td>
                </tr>
                <tr>
                    <th class="required">수행 기간</th>
                    <td>
                        <div style="display: flex; align-items: center; gap: 10px;">
                            <form:input path="startDt" type="date" style="width: 180px;" />
                            <span>~</span>
                            <form:input path="endDt" type="date" style="width: 180px;" />
                        </div>
                    </td>
                </tr>
            </table>

            <div class="btn-area">
                <button type="submit" class="btn btn-blue">저장하기</button>
                <a href="<c:url value='/pms/projectList.do'/>" class="btn btn-gray">목록으로</a>
            </div>
        </form:form>
    </div>

</body>
</html>