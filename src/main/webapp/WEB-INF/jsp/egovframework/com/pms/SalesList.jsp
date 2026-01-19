<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>영업 관리 목록</title>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/egovframework/com/pms/SalesList.css'/>?v=1.1">

</head>
<body>
	<c:import url="/WEB-INF/jsp/egovframework/com/pms/include/menu.jsp" />
	<div class="content-page">
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
	                <th width="23%">영업건명</th>
	                <th width="15%">고객사</th>
	                <th width="10%">담당자</th>
	                <th width="15%">예상금액</th>
	                <th width="12%">확률</th>
	                <th width="10%">상태</th>
	                <th width="10%">관리</th>
	            </tr>
	        </thead>
	        <tbody>
	            <c:forEach var="result" items="${resultList}">
	                <tr>
	                    <td>${result.salesId}</td>
	                    <td class="text-left">
	                        <a href="javascript:void(0);" onclick="fn_open_sales_popup('${result.salesId}', '${result.salesTitle}');" style="font-weight:bold; color:#007bff;">
	                            <c:out value="${result.salesTitle}"/>
	                        </a>
	                    </td>
	                    <td>${result.custNm}</td>
	                    <td>${result.salesNm}</td>
	                    <td><fmt:formatNumber value="${result.expectedAmt}" pattern="#,###"/>원</td>
	                    <td>
	                        <span>${result.probability}%</span>
                            <div class="prob-container">
                                <div class="prob-bar" style="width: ${result.probability}%;"></div>
                            </div>
                        </td>
	                    <td style="position: relative;">
	                    	<div class="status-container">
						        <a href="javascript:void(0);" 
						           class="status-badge ${result.status eq '영업중' ? 'status-won' : result.status eq '수주완료' ? 'status-negotiating' : 'status-lost'}"
						           onclick="fn_toggle_status_menu('${result.salesId}', event);"
						           style="cursor:pointer; text-decoration:none; display:inline-block;">
						            ${result.status} ▼
						        </a>
						
						        <div id="status_menu_${result.salesId}" class="status-menu-layer" style="display:none; position: absolute; z-index: 999; background: #fff; border: 1px solid #ccc; box-shadow: 2px 2px 5px rgba(0,0,0,0.2); width: 100px; left: 50%; transform: translateX(-50%);">
						            <ul style="list-style:none; padding:0; margin:0;">
						                <li style="border-bottom:1px solid #eee;"><a href="javascript:void(0);" onclick="fn_update_sales_status('${result.salesId}', '영업중')" style="display:block; padding:8px; font-size:12px; color:#333;">영업중</a></li>
						                <li style="border-bottom:1px solid #eee;"><a href="javascript:void(0);" onclick="fn_update_sales_status('${result.salesId}', '수주완료')" style="display:block; padding:8px; font-size:12px; color:#333;">수주완료</a></li>
						                <li><a href="javascript:void(0);" onclick="fn_update_sales_status('${result.salesId}', '영업실패')" style="display:block; padding:8px; font-size:12px; color:#333;">영업실패</a></li>
						            </ul>
						        </div>
						    </div>
						</td>
	                    <td>
		                   <a href="<c:url value='/pms/updateSalesView.do'/>?selectedId=${result.salesId}"
		                    class="btn btn-yellow btn-sm" >수정</a>
                           <a href="javascript:void(0);"
                            class="btn btn-red btn-sm"  onclick="if(confirm('삭제하시겠습니까?')) location.href='<c:url value='/pms/deleteSales.do'/>?selectedId=${result.salesId}';">삭제</a>
	                    </td>
	                </tr>
	            </c:forEach>
	        </tbody>
	    </table>

	    <div class="pagination-wrapper" style="text-align:center; margin-top:20px;">
	        <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_link_page" />
	    </div>

	    <div style="margin-top: 20px;">
	        <a href="<c:url value='/pms/addSalesView.do'/>" class="btn btn-blue">신규 영업 등록</a>
	    </div>
	    
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
		
	    <script type="text/javascript">
	        function fn_egov_link_page(pageNo){
	            document.listForm.pageIndex.value = pageNo;
	            document.listForm.action = "<c:url value='/pms/salesList.do'/>";
	            document.listForm.submit();
	        }

	        function fn_open_sales_popup(salesId, salesTitle) {
	            var windowName = "sales_pop_" + salesId;
	            var url = "<c:url value='/pms/salesDetailPopup.do'/>?selectedId=" + salesId;
	            var options = "width=700, height=600, resizable=yes, scrollbars=yes, status=no";
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

	        function fn_update_sales_status(salesId, nextStatus) {
	            if(!confirm("영업 상태를 [" + nextStatus + "]로 변경하시겠습니까?")) return;

	            $.ajax({
	                url: "<c:url value='/pms/updateSalesStatusAjax.do'/>",
	                type: "POST",
	                data: { 
	                    "selectedId": salesId, 
	                    "status": nextStatus 
	                },
	                dataType: "json",
	                success: function(data) {
	                    if(data.status == "success") {
	                        alert("영업 상태가 변경되었습니다.");
	                        location.reload();
	                    } else {
	                        alert("변경 실패: " + data.message);
	                    }
	                },
	                error: function() { alert("서버 통신 오류"); }
	            });
	        }
	    </script>
    </div>
</body>
</html>