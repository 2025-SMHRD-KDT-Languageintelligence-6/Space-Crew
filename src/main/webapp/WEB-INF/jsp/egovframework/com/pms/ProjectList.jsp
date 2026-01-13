<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<title>업무 목록</title>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/egovframework/com/pms/ProjectList.css'/>">
</head>
<body>
	<c:import url="/WEB-INF/jsp/egovframework/com/pms/include/menu.jsp" />

	<div class="content-page">
	    <h2>PMS 업무 목록</h2>

	    <div class="search-box">
            <form name="listForm" action="<c:url value='/pms/projectList.do'/>" method="post">
                <input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>

                <label>업무명: </label>
                <input type="text" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>" style="width:200px;" />
                <button type="submit" class="btn btn-blue">검색</button>
            </form>
        </div>

	    <table>
	        <thead>
	            <tr>
	                <th width="10%">ID</th>
                    <th width="40%">업무명</th>
                    <th width="15%">상태</th>
                    <th width="15%">시작일</th>
                    <th width="20%">관리</th>
	            </tr>
	        </thead>
	        <tbody>
	            <c:forEach var="result" items="${resultList}" varStatus="status">
	                <tr>
	                    <td><c:out value="${result.projId}"/></td>
	                    <td class="text-left">
						    <a href="javascript:void(0);" onclick="fn_open_project_popup('${result.projId}', '${result.projNm}');" style="font-weight:bold; color:#007bff;">
						        <c:out value="${result.projNm}"/>
						    </a>
						</td>
	                    <td><c:out value="${result.status}"/></td>
	                    <td><c:out value="${result.startDt}"/></td>
	                    <td>
						    <a href="<c:url value='/pms/updateProjectView.do'/>?selectedId=${result.projId}"
                               class="btn btn-yellow btn-sm">수정</a>
                            <a href="javascript:void(0);"
                               class="btn btn-red btn-sm"
                               onclick="if(confirm('업무 정보를 삭제하시겠습니까?')) location.href='<c:url value='/pms/deleteProject.do'/>?selectedId=${result.projId}';">삭제</a>
						</td>
	                </tr>
	            </c:forEach>
	            <c:if test="${empty resultList}">
	                <tr>
	                    <td colspan="4">조회된 데이터가 없습니다.</td>
	                </tr>
	            </c:if>
	        </tbody>
	    </table>

	    <div style="margin-top: 20px;">
            <a href="<c:url value='/pms/addProjectView.do'/>" class="btn btn-blue">신규 프로젝트 등록</a>
        </div>

		<script type="text/javascript">
	        function fn_egov_link_page(pageNo){
	            document.listForm.pageIndex.value = pageNo;
	            document.listForm.action = "<c:url value='/pms/projectList.do'/>";
	            document.listForm.submit();
	        }

	        function fn_open_project_popup(projId, projNm) {
	            var windowName = "project_pop_" + projId;
	            var url = "<c:url value='/pms/projectDetailPopup.do'/>?selectedId=" + projId;
	            var options = "width=700, height=600, resizable=yes, scrollbars=yes, status=no";
	            window.open(url, windowName, options);
	        }
	    </script>
	</div>
</body>
</html>