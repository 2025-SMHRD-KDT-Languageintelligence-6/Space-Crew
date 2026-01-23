<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>계약 등록</title>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/egovframework/com/pms/Regist-Updt-Form.css'/>">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

    <div class="form-container">
        <h2>계약 등록</h2>

        <form:form modelAttribute="contractVO" action="${pageContext.request.contextPath}/pms/addContract.do" method="post">
            <table>
            	<tr>
				    <th>연결된 영업건</th>
				    <td>
				        <form:select path="salesId">
				            <form:option value="" label="-- 단독 계약 (영업 연동 없음) --"/>
				            <c:forEach var="sales" items="${salesList}">
				                <form:option value="${sales.salesId}">
								    ${sales.salesTitle} (${sales.custNm}, ${sales.ceoNm})
								</form:option>
				            </c:forEach>
				        </form:select>
				    </td>
				</tr>
                <tr>
                    <th class="required">계약명</th>
                    <td><form:input path="contNm" required="required" placeholder="계약명을 입력하세요" /></td>
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
                    <th class="required">계약담당자</th>
                    <td>
				        <form:select path="picUserId" required="required">
				            <form:option value="" label="-- 담당자 선택 --"/>
				            <c:forEach var="user" items="${userList}">
				                <form:option value="${user.userId}" label="${user.userNm} (${user.deptNm})"/>
				            </c:forEach>
				        </form:select>
				    </td>
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
                    <td>
				        <form:select path="contStatus">
				            <form:option value="대기" label="대기"/>
				            <form:option value="진행" label="진행"/>
				            <form:option value="완료" label="완료"/>
				            <form:option value="중단" label="중단"/>
				        </form:select>
				    </td>
                </tr>

                <tr>
                    <th>비고</th>
                    <td><form:textarea path="contRemark" rows="5" placeholder="기타 참고사항을 입력하세요" /></td>
                </tr>
            </table>

            <div class="btn-area">
                <button type="submit" class="btn btn-blue">등록하기</button>
                <a href="<c:url value='/pms/contractList.do'/>" class="btn btn-gray">취소</a>
            </div>
        </form:form>
    </div>
    
    
	<script type="text/javascript">
	    var salesInfoList = [];
	    <c:forEach var="sales" items="${salesList}">
	        salesInfoList.push({
	            salesId: "${sales.salesId}",
	            custId: "${sales.custId}",
	            salesUserId: "${sales.salesUserId}"
	        });
	    </c:forEach>
	    
	    $(document).ready(function() {
	        $("select[name='salesId']").change(function() {
	            var selectedId = $(this).val();
	            
	            if (!selectedId) return;

	            var matched = salesInfoList.find(function(item) {
	                return item.salesId == selectedId;
	            });

	            if (matched) {
	                $("select[name='custId']").val(matched.custId).change();
	                if (matched.salesUserId) {
	                    $("select[name='picUserId']").val(matched.salesUserId).change();
	                }
	            }
	        });
	    });
	    
	    
	    
	</script>
	
	
	
</body>
</html>