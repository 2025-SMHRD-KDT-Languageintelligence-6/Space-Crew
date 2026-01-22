<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>고객사 정보 수정</title>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/egovframework/com/pms/Regist-Updt-Form.css'/>">
</head>
<body>

    <div class="form-container">
        <h2>고객사 정보 수정</h2>

        <form:form modelAttribute="customerVO" action="${pageContext.request.contextPath}/pms/updateCustomer.do" method="post">
            <%-- 수정 시 필수인 PK 값 (기존 경로) --%>
            <form:hidden path="custId" />

            <table>
                <tr>
                    <th>고객사 ID</th>
                    <td><span class="readonly-id"><c:out value="${customerVO.custId}"/></span> <small>(수정불가)</small></td>
                </tr>

                <%-- [기존 경로] VO에 존재하는 필드들 --%>
                <tr>
                    <th class="required">고객사명</th>
                    <td><form:input path="custNm" required="required" /></td>
                </tr>
                <tr>
                    <th>사업자 등록번호</th>
                    <td><form:input path="bizRegNo" /></td>
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
                    <td><form:input path="picTel" /></td>
                </tr>

                <%-- [신규 경로] VO에 없을 경우 500 에러를 유발하므로 일반 HTML 태그로 처리 --%>
                <tr>
                    <th>담당자 이메일</th>
                    <td>
                        <input type="email" name="temp_picEmail" value="" placeholder="VO 필드 추가 필요" style="width:95%;" />
                    </td>
                </tr>
                <tr>
                    <th>고객사 주소</th>
                    <td>
                        <input type="text" name="temp_custAddr" value="" placeholder="VO 필드 추가 필요" style="width:95%;" />
                    </td>
                </tr>
                <tr>
                    <th>고객 등급</th>
                    <td>
                        <select name="temp_custGrade" style="width:95%;">
                            <option value="">-- 등급 선택 (임시) --</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>비고/특이사항</th>
                    <td>
                        <textarea name="temp_custRemark" rows="4" style="width:95%;" placeholder="VO 필드 추가 필요"></textarea>
                    </td>
                </tr>
            </table>

            <div class="btn-area">
                <button type="submit" class="btn btn-blue">수정완료</button>
                <a href="<c:url value='/pms/customerList.do'/>" class="btn btn-gray">취소</a>
            </div>
        </form:form>
    </div>

</body>
</html>