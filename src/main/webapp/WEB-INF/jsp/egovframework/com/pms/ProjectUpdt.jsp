<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>업무 수정</title>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/egovframework/com/pms/Regist-Updt-Form.css'/>">
</head>
<body>

    <div class="form-container">
        <h2>업무 수정</h2>

        <%-- 주의: 수정 시에는 updateProject.do와 같은 수정 전용 액션 경로를 확인하세요 --%>
        <form:form modelAttribute="projectVO" action="${pageContext.request.contextPath}/pms/updateProject.do" method="post">

            <%-- 필수: 데이터 수정을 위한 키 값 --%>
            <form:hidden path="projId" />

            <table>
                <tr>
                    <th>업무 ID</th>
                    <td>
                        <span class="readonly-id">#<c:out value="${projectVO.projId}"/></span>
                        <small>(자동 생성된 번호입니다)</small>
                    </td>
                </tr>
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
                        <form:select path="projType" required="required">
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
				        <form:select path="mainMgrId" required="required"> <form:option value="" label="-- 선택 --"/>
				            <c:forEach var="user" items="${userList}">
				                <form:option value="${user.userId}" label="${user.userNm} (${user.deptNm})"/>
				            </c:forEach>
				        </form:select>
				    </td>
				</tr>
                <tr>
				    <th class="required">부담당자</th>
				    <td>
				        <form:select path="subMgrId" required="required"> <form:option value="" label="-- 선택 --"/>
				            <c:forEach var="user" items="${userList}">
				                <form:option value="${user.userId}" label="${user.userNm} (${user.deptNm})"/>
				            </c:forEach>
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
                	<td><form:input path="estEffort" type="number" style="width: 50px;" min="0" value="${empty projectVO.estEffort ? 0 : projectVO.estEffort}"/> M/M</td>
                </tr>
                <tr>
                	<th>특이사항</th>
                	<td><form:textarea path="projRemark" rows="4" placeholder="업무에 필요한 요구사항과 특이사항을 써주세요" /></td>
                </tr>
            </table>

            <div class="btn-area">
                <button type="submit" class="btn btn-blue">수정완료</button>
                <a href="<c:url value='/pms/projectList.do'/>" class="btn btn-gray">취소</a>
            </div>
        </form:form>
    </div>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script type="text/javascript">
	    $(document).ready(function() {
	        $("input[name='startDt']").on("change", function() {
	            var startDate = $(this).val();
	            if (startDate) {
	                $("input[name='endDt']").attr("min", startDate);
	            }
	        });
	
	        $("input[name='endDt']").on("change", function() {
	            var endDate = $(this).val();
	            if (endDate) {
	                $("input[name='startDt']").attr("max", endDate);
	            }
	        });
	
	        var preStart = $("input[name='startDt']").val();
	        var preEnd = $("input[name='endDt']").val();
	        if (preStart) $("input[name='endDt']").attr("min", preStart);
	        if (preEnd) $("input[name='startDt']").attr("max", preEnd);
	    });
	
	    $("form").submit(function(e) {
	    	var mainMgr = $("select[name='mainMgrId']").val();
	        var subMgr = $("select[name='subMgrId']").val();
	        var estEffort = $("input[name='estEffort']").val();

	        if (mainMgr && subMgr && mainMgr === subMgr) {
	            alert("주담당자와 부담당자는 동일한 사람일 수 없습니다.");
	            $("select[name='subMgrId']").focus();
	            e.preventDefault();
	            return false;
	        }

	        if (!estEffort) {
	            $("input[name='estEffort']").val(0);
	        }
	    	
	        var startDate = $("input[name='startDt']").val();
	        var endDate = $("input[name='endDt']").val();
	
	        if (startDate && endDate) {
	            if (startDate > endDate) {
	                alert("수행 종료일은 시작일보다 빠를 수 없습니다.");
	                $("input[name='endDt']").focus();
	                e.preventDefault();
	                return false;
	            }
	        }
	    });
	</script>
</body>
</html>