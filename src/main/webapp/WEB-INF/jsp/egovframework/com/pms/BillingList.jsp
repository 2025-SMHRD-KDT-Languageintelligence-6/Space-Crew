<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>청구 및 정산 관리</title>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/egovframework/com/pms/BillingList.css'/>" >
</head>
<body>
    <c:import url="/WEB-INF/jsp/egovframework/com/pms/include/menu.jsp" />

    <div class="content-page">
        <h2>청구 및 정산 목록</h2>

        <div class="search-box">
            <form name="listForm" action="<c:url value='/pms/billingList.do'/>" method="post">
                <input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
                <label>청구명</label>
                <input type="text" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>" placeholder="청구 또는 프로젝트명 입력" />
                <button type="submit" class="btn btn-blue">검색</button>
            </form>
        </div>

        <table>
            <thead>
                <tr>
                    <th width="8%">ID</th>
                    <th width="20%">프로젝트명</th>
                    <th width="25%">청구회차/명칭</th>
                    <th width="15%">청구금액</th>
                    <th width="12%">발행일</th>
                    <th width="10%">상태</th>
                    <th width="10%">관리</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="result" items="${resultList}">
                    <tr>
                        <td>${result.billId}</td>
                        <td class="text-left">
                            <a href="javascript:void(0);" onclick="fn_open_billing_popup('${result.projId}');" class="proj-link">
                                <c:out value="${result.projNm}"/>
                            </a>
                        </td>
                        <td class="text-left"><c:out value="${result.billTitle}"/></td>
                        <td class="text-right">
                            <span class="amt-text"><fmt:formatNumber value="${result.billAmt}" pattern="#,###"/>원</span>
                        </td>
                        <td>${result.taxBillDt}</td>
                        <td>
                            <span class="status-badge ${result.isPaid == 'Y' ? 'status-paid' : 'status-unpaid'}">
                                ${result.isPaid == 'Y' ? '입금완료' : '미납'}
                            </span>
                        </td>
                        <td>
                            <div class="btn-group">
                                <a href="<c:url value='/pms/updateBillingView.do'/>?selectedId=${result.billId}" class="btn btn-yellow btn-sm">수정</a>
                                <a href="javascript:void(0);" class="btn btn-red btn-sm" onclick="if(confirm('청구 정보를 삭제하시겠습니까?')) location.href='<c:url value='/pms/deleteBilling.do'/>?selectedId=${result.billId}';">삭제</a>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty resultList}">
                    <tr>
                        <td colspan="7">조회된 청구 내역이 없습니다.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>

        <div class="pagination-wrapper">
            <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_link_page" />
        </div>

        <div class="action-bar">
            <a href="<c:url value='/pms/addBillingView.do'/>" class="btn btn-blue">신규 청구 등록</a>
        </div>
    </div>

    <script>
        function fn_egov_link_page(pageNo){
            document.listForm.pageIndex.value = pageNo;
            document.listForm.submit();
        }

        function fn_open_billing_popup(projId) {
            var url = "<c:url value='/pms/billingDetailPopup.do'/>?projId=" + projId;
            window.open(url, "billing_pop_" + projId, "width=900, height=750, resizable=yes, scrollbars=yes");
        }
    </script>
</body>
</html>