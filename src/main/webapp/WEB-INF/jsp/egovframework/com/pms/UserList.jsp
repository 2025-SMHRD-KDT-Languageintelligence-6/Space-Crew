<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>직원 관리 목록</title>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/egovframework/com/pms/UserList.css'/>?v=1.1">
</head>
<body>
    <c:import url="/WEB-INF/jsp/egovframework/com/pms/include/menu.jsp" />
    <div class="content-page">
        <h2>직원 관리 목록</h2>

        <div class="search-box">
            <form name="listForm" action="<c:url value='/pms/userList.do'/>" method="post">
                <input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>

                <label>직원명</label>
                <input type="text" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>" placeholder="성명을 입력하세요" />
                <button type="submit" class="btn btn-blue" style="margin-left: 10px;">검색</button>
            </form>
        </div>

        <table>
            <thead>
                <tr>
                    <th width="12%">사원번호</th>
                    <th width="12%">성명</th>
                    <th width="15%">부서</th>
                    <th width="15%">직무</th>
                    <th width="13%">직급</th>
                    <th width="18%">업무부하량</th>
                    <th width="15%">관리</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="result" items="${resultList}" varStatus="status">
                    <tr>
                        <td>
                            <a href="javascript:void(0);" onclick="fn_open_user_popup('${result.userId}', '${result.userNm}');" class="user-link">
                                <c:out value="${result.userId}"/>
                            </a>
                        </td>
                        <td style="font-weight: 600;"><c:out value="${result.userNm}"/></td>
                        <td><c:out value="${result.deptNm}"/></td>
                        <td><c:out value="${result.jobRole}"/></td>
                        <td><c:out value="${result.positionNm}"/></td>
                        <td>
                            <div class="${result.currentLoad > 100 ? 'text-danger-bold' : ''}" style="font-size: 13px; margin-bottom: 3px;">
                                <fmt:formatNumber value="${result.currentLoad}" pattern="#" />%
                            </div>

                            <div class="load-container">
                            	<fmt:parseNumber var="intLoad" value="${result.currentLoad}" integerOnly="true" />
                            	
                                <c:set var="baseWidth" value="${intLoad > 100 ? 100 : intLoad}" />
                                <c:set var="loadType" value="load-low" />
                                <c:if test="${intLoad > 40}"><c:set var="loadType" value="load-medium" /></c:if>
                                <c:if test="${intLoad > 75}"><c:set var="loadType" value="load-high" /></c:if>

                                <div class="load-bar-base ${loadType}" style="width: ${baseWidth}%"></div>

                                <c:if test="${intLoad > 100}">
                                    <c:set var="overWidth" value="${intLoad - 100}" />
                                    <div class="load-bar-over" style="width: ${overWidth}%"></div>
                                </c:if>
                            </div>
                        </td>
                        
                        <td>
                            <div class="btn-group">
                                <a href="<c:url value='/pms/updateUserView.do'/>?selectedId=${result.userId}"
                                   class="btn btn-yellow btn-sm">수정</a>
                                <a href="javascript:void(0);"
                                   class="btn btn-red btn-sm"
                                   onclick="if(confirm('직원 정보를 삭제하시겠습니까?')) location.href='<c:url value='/pms/deleteUser.do'/>?selectedId=${result.userId}';">삭제</a>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty resultList}">
                    <tr>
                        <td colspan="7">등록된 직원이 없습니다.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>

        <div class="pagination-wrapper" style="text-align:center; margin-top:30px;">
            <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_link_page" />
        </div>

        <div style="margin-top: 20px;">
            <a href="<c:url value='/pms/addUserView.do'/>" class="btn btn-blue">신규 사용자 등록</a>
        </div>
    </div>

    <script type="text/javascript">
        function fn_egov_link_page(pageNo){
            document.listForm.pageIndex.value = pageNo;
            document.listForm.submit();
        }

        function fn_open_user_popup(userId, userNm) {
            var url = "<c:url value='/pms/userDetailPopup.do'/>?selectedId=" + userId;
            window.open(url, "user_pop_" + userId, "width=800, height=700, resizable=yes, scrollbars=yes");
        }
    </script>
</body>
</html>