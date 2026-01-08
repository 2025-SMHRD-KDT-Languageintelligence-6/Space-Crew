<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>영업 관리 목록</title>
    <style>
        table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: center; }
        th { background-color: #f8f9fa; }
        .search-box { margin-bottom: 20px; padding: 15px; background: #f1f3f5; border-radius: 5px; }
        .btn { padding: 6px 12px; text-decoration: none; cursor: pointer; border: 1px solid #dee2e6; border-radius: 4px; display: inline-block; }
        .btn-blue { background: #007bff; color: white; border: none; }
        .text-left { text-align: left; }
    </style>
</head>
<body>
    <h2>영업 관리 목록</h2>

    <div class="search-box">
        <form name="listForm" action="<c:url value='/pms/salesList.do'/>" method="post">
            <input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
            <label>영업건명: </label>
            <input type="text" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>" />
            <button type="submit" class="btn btn-blue">검색</button>
        </form>
    </div>

    <table>
        <thead>
            <tr>
                <th width="5%">ID</th>
                <th width="30%">영업건명</th>
                <th width="15%">고객사</th>
                <th width="10%">담당자</th>
                <th width="15%">예상금액</th>
                <th width="10%">확률</th>
                <th width="15%">상태</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="result" items="${resultList}">
                <tr>
                    <td>${result.salesId}</td>
                    <td class="text-left">
                        <a href="<c:url value='/pms/updateSalesView.do'/>?selectedId=${result.salesId}">${result.salesTitle}</a>
                    </td>
                    <td>${result.customerName}</td>
                    <td>${result.salesUserName}</td>
                    <td><fmt:formatNumber value="${result.expectedAmt}" pattern="#,###"/>원</td>
                    <td>${result.probability}%</td>
                    <td>${result.status}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <div style="text-align:center; margin-top:20px;">
        <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_link_page" />
    </div>

    <div style="margin-top: 20px;">
        <a href="<c:url value='/pms/addSalesView.do'/>" class="btn btn-blue">신규 영업 등록</a>
    </div>

    <script>
        function fn_egov_link_page(pageNo){
            document.listForm.pageIndex.value = pageNo;
            document.listForm.submit();
        }
    </script>
</body>
</html>