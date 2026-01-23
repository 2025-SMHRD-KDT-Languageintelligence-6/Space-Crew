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
				    <th class="required">계약명</th>
				    <td>
				        <form:select path="contId" required="required">
				            <form:option value="" label="-- 연결할 계약을 선택하세요 --"/>
				            <c:forEach var="contract" items="${contractList}">
				                <form:option value="${contract.contId}" label="${contract.contNm} (${contract.custNm})" />
				            </c:forEach>
				        </form:select>
				    </td>
				</tr>
                <tr>
                    <th class="required">프로젝트명</th>
                    <td><form:input path="projNm" required="required" placeholder="프로젝트명을 입력하세요" /></td>
                </tr>
                <tr>
                    <th class="required">유형</th>
                    <td>
                        <form:select path="projType">
                            <form:option value="개발" label="개발"/>
                            <form:option value="유지보수" label="유지보수"/>
                            <form:option value="하자보수" label="하자보수"/>
                            <form:option value="일반용역" label="일반용역"/>
                        </form:select>
                    </td>
                </tr>
                <tr>
                    <th>상태</th>
                    <td>
                        <form:select path="status">
                            <form:option value="배정중" label="배정중"/>
                            <form:option value="진행중" label="진행중"/>
                            <form:option value="업무완료" label="업무완료"/>
                            <form:option value="업무실패" label="업무실패"/>
                            <form:option value="보류" label="보류"/>
                        </form:select>
                    </td>
                </tr>
                <tr>
				    <th class="required">주담당자</th>
				    <td>
				        <form:select path="mainMgrNm" required="required">
				            <form:option value="" label="-- 선택 --"/>
				            <form:options items="${userList}" itemValue="userId" itemLabel="userNm"/>
				        </form:select>
				    </td>
				</tr>
                <tr>
				    <th class="required">부담당자</th>
				    <td>
				        <form:select path="subMgrNm" required="required">
				            <form:option value="" label="-- 선택 --"/>
				            <form:options items="${userList}" itemValue="userId" itemLabel="userNm"/>
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
                <tr>
                	<th>예상 인력</th>
                	<td><form:input path="estEffort" type="number" style="width: 50px;" min="0"/>  M/M</td>
                </tr>
                <tr>
                	<th>요구 및 특이사항</th>
                	<td><form:textarea path="reqSkills" rows="4" placeholder="업무에 필요한 요구사항과 특이사항을 써주세요" /></td>
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