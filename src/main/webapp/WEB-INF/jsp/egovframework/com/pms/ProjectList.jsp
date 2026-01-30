<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<title>업무 목록</title>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/egovframework/com/pms/ProjectList.css'/>?v=1.1">
</head>
<body>
	<c:import url="/WEB-INF/jsp/egovframework/com/pms/include/menu.jsp" />

	<div class="content-page">
	    <h2>PMS 업무 목록</h2>

	    <div class="search-box">
            <form name="listForm" action="<c:url value='/pms/projectList.do'/>" method="post">
                <input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>

                <label>프로젝트명: </label>
                <input type="text" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>" placeholder="프로젝트명을 입력하세요" style="width:200px;" />
                <button type="submit" class="btn btn-blue">검색</button>
            </form>
        </div>

	    <table>
	        <thead>
	            <tr>
	                <th width="7%">타입</th>
                    <th width="30%">프로젝트명</th>
                    <!-- <th width="15%">고객사</th> -->
                    <th width="8%">주담당자</th>
                    <th width="15%">경과율</th>
                    <th width="15%">종료일</th>
                    <th width="10%">상태</th>
                    <th width="10%">관리</th>
	            </tr>
	        </thead>
	        <tbody>
	            <c:forEach var="result" items="${resultList}" varStatus="status">
	                <tr>
	                    <td><c:out value="${result.projType}"/></td>
	                    <td class="text-left">
						    <a href="javascript:void(0);" onclick="fn_open_project_popup('${result.projId}', '${result.projNm}');" style="font-weight:bold; color:#007bff;">
						        <c:out value="${result.projNm}"/>
						    </a>
						</td>
						<%-- <td><c:out value="${result.custNm}"/></td> --%>
						<td><c:out value="${result.mainMgrNm}"/></td>
						<td style="vertical-align: middle;">
						    <div style="display: flex; align-items: center; justify-content: space-between; width: 160px; margin: 0 auto;">
						        <div style="flex-grow: 1; background-color: #e5e7eb; border-radius: 9999px; h-height: 8px; height: 8px; position: relative; overflow: hidden;">
						            <div style="position: absolute; top: 0; left: 0; height: 100%; transition: width 0.5s ease-in-out;
						                width: <c:out value='${result.progressRate}'/>%;
						                background-color:
						                <c:choose>
						                    <c:when test='${result.progressRate ge 80}'>#ef4444</c:when>
						                    <c:when test='${result.progressRate ge 40}'>#f59e0b</c:when>
						                    <c:otherwise>#10b981</c:otherwise>
					                    </c:choose>;">
						            </div>
						        </div>
						        <span style="font-size: 12px; font-weight: 600; color: #374151; margin-left: 8px; min-width: 35px; text-align: right;">
						            <c:out value="${result.progressRate}"/>%
						        </span>
						    </div>
						</td>						
	                    <td><c:out value="${result.endDt}"/></td>
						<td style="position: relative;">
						    <div class="status-container">
						        <a href="javascript:void(0);" 
						           class="status-badge ${result.status eq '완료' ? 'status-won' : result.status eq '진행중' ? 'status-ing' : 'status-lost'}"
						           onclick="fn_toggle_status_menu('${result.projId}', event);"
						           style="cursor:pointer; text-decoration:none; display:inline-block;">
						            ${result.status} ▼
						        </a>
						
						        <div id="status_menu_${result.projId}" class="status-menu-layer" style="display:none; position: absolute; z-index: 999; background: #fff; border: 1px solid #ccc; box-shadow: 2px 2px 5px rgba(0,0,0,0.2); width: 100px; left: 50%; transform: translateX(-50%);">
						            <ul style="list-style:none; padding:0; margin:0;">
						                <li style="border-bottom:1px solid #eee;"><a href="javascript:void(0);" onclick="fn_update_project_status('${result.projId}', '배정중')" style="display:block; padding:8px; font-size:12px; color:#333;">배정중</a></li>
						                <li style="border-bottom:1px solid #eee;"><a href="javascript:void(0);" onclick="fn_update_project_status('${result.projId}', '진행중')" style="display:block; padding:8px; font-size:12px; color:#333;">진행중</a></li>
						                <li style="border-bottom:1px solid #eee;"><a href="javascript:void(0);" onclick="fn_update_project_status('${result.projId}', '업무완료')" style="display:block; padding:8px; font-size:12px; color:#333;">업무완료</a></li>
						                <li style="border-bottom:1px solid #eee;"><a href="javascript:void(0);" onclick="fn_update_project_status('${result.projId}', '업무취소')" style="display:block; padding:8px; font-size:12px; color:#333;">업무취소</a></li>
						                <li><a href="javascript:void(0);" onclick="fn_update_project_status('${result.projId}', '보류')" style="display:block; padding:8px; font-size:12px; color:#333;">보류</a></li>
						            </ul>
						        </div>
						    </div>
						</td>
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
		
		<div class="pagination-wrapper" style="text-align:center; margin-top:20px;">
	        <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_link_page" />
	    </div>
		
	    <div style="margin-top: 20px;">
            <a href="<c:url value='/pms/addProjectView.do'/>" class="btn btn-blue">신규 프로젝트 등록</a>
        </div>
		
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
		
		<script type="text/javascript">
	        function fn_egov_link_page(pageNo){
	            document.listForm.pageIndex.value = pageNo;
	            document.listForm.action = "<c:url value='/pms/projectList.do'/>";
	            document.listForm.submit();
	        }

	        function fn_open_project_popup(projId, projNm) {
	            var windowName = "project_pop_" + projId;
	            var url = "<c:url value='/pms/projectDetailPopup.do'/>?selectedId=" + projId;
	            var options = "width=900, height=900, resizable=yes, scrollbars=yes, status=no";
	            window.open(url, windowName, options);
	        }
	        
	        function fn_toggle_status_menu(id, event) {
	            event.stopPropagation();
	            $(".status-menu-layer").hide();
	            $("#status_menu_" + id).toggle();
	        }

	        $(document).click(function() {
	            $(".status-menu-layer").hide();
	        });

	        function fn_update_project_status(projId, nextStatus) {
	            if(!confirm("업무 상태를 [" + nextStatus + "]로 변경하시겠습니까?")) return;

	            $.ajax({
	                url: "<c:url value='/pms/updateProjectStatusAjax.do'/>",
	                type: "POST",
	                data: { 
	                    "selectedId": projId, 
	                    "status": nextStatus 
	                },
	                dataType: "json",
	                success: function(data) {
	                    if(data.status == "success") {
	                        alert("업무 상태가 변경되었습니다.");
	                        location.reload();
	                    } else {
	                        alert("변경 실패: " + data.message);
	                    }
	                },
	                error: function() { alert("서버 통신 오류"); }
	            });
	        }
	        
	        function fn_delete_assign(assignId) {
	            if(!confirm("정말 삭제하시겠습니까?")) return;
	            
	            $.ajax({
	                url: "<c:url value='/pms/deleteProjectAssignAjax.do'/>",
	                type: "POST",
	                data: { assignId: assignId },
	                success: function(data) {
	                    alert("삭제되었습니다.");
	                    fn_load_assign_list();
	                }
	            });
	        }
	        
	    </script>
	</div>
</body>
</html>