<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>청구 및 정산 관리</title>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/egovframework/com/pms/BillingList.css'/>?v=1.1" >
</head>
<body>
	<c:import url="/WEB-INF/jsp/egovframework/com/pms/include/menu.jsp" />

	<div class="content-page">
	    <h2>청구 및 정산 목록</h2>
	
	    <div class="search-box">
            <form name="listForm" action="<c:url value='/pms/billingList.do'/>" method="post">
                <input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>

                <label>업무명: </label>
                <input type="text" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>" placeholder="업무명을 입력하세요" style="width:200px;" />
                <button type="submit" class="btn btn-blue">검색</button>
            </form>
        </div>
	
	    <table>
	        <thead>
	            <tr>
		            <th width="27%">업무명</th>
		            <th width="10">고객사</th>
		            <th width="12%">계약금액</th>
		            <th width="12%">누적청구액</th>
		            <th width="12%">실수금합계</th>
		            <th width="12%">미수금잔액</th>
		            <th width="8%">청구상태</th>
		            <th width="7%">정산상태</th>
		            
	            </tr>
	        </thead>
	        <tbody>
	            <c:forEach var="result" items="${resultList}">
	                <tr>
	                    <td>
						    <a href="javascript:void(0);" onclick="fn_open_billing_popup('${result.projId}');" style="font-weight:bold; color:#007bff; text-decoration:underline;">
						        <c:out value="${result.projNm}"/>
						    </a>
						</td>
						<td>${result.custNm}</td>
	                    <td style="text-align:right; padding-right:15px;">
	                   		<fmt:formatNumber value="${result.totalAmt}" pattern="#,###"/>원
	                    </td>
	                    <td style="text-align:right; padding-right:15px; color:#28a745; font-weight:bold;">
	                    	<fmt:formatNumber value="${result.totalBilledAmt}" pattern="#,###"/>원
	                    </td>
	                    <td style="text-align:right; padding-right:15px;">
	                   		<fmt:formatNumber value="${result.totalPaidAmt}" pattern="#,###"/>원
	                    
	                    </td>
	                    <td style="text-align:right; padding-right:15px; color:#f06948; font-weight:bold;">
	                   		<fmt:formatNumber value="${result.totalAmt - result.totalPaidAmt}" pattern="#,###"/>원
	                    
	                    </td>
	                    <td>
                            <c:choose>
                                <%-- 정산완료 상태 --%>
                                <c:when test="${result.isPaid == 'Y'}">
                                    <span class="status-badge status-paid">입금완료</span>
                                </c:when>

                                <c:otherwise>
                                    <c:choose>
                                        <%-- 입금대기 상태 (금액이 일치할 때) --%>
                                        <c:when test="${result.totalAmt == result.totalBilledAmt}">
                                            <span class="status-badge status-waiting">청구완료</span>
                                        </c:when>
                                        <%-- 청구진행중 상태 --%>
                                        <c:otherwise>
                                            <span class="status-badge status-pending">청구진행중</span>
                                        </c:otherwise>
                                    </c:choose>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td style="position: relative;">
						    <div class="status-container">
						        <a href="javascript:void(0);" 
						           class="status-badge ${result.billStatus eq '정상' ? 'status-won' : result.billStatus eq '보류' ? 'status-ing' : 'status-lost'}"
						           onclick="fn_toggle_status_menu('${result.projId}', event);"
						           style="cursor:pointer; text-decoration:none; display:inline-block;">
						            ${result.billStatus} ▼
						        </a>
						
						        <div id="status_menu_${result.projId}" class="status-menu-layer" style="display:none; position: absolute; z-index: 999; background: #fff; border: 1px solid #ccc; box-shadow: 2px 2px 5px rgba(0,0,0,0.2); width: 100px; left: 50%; transform: translateX(-50%);">
						            <ul style="list-style:none; padding:0; margin:0;">
						                <li style="border-bottom:1px solid #eee;"><a href="javascript:void(0);" onclick="fn_update_billing_status('${result.projId}', '정상')" style="display:block; padding:8px; font-size:12px; color:#333;">정상</a></li>
						                <li style="border-bottom:1px solid #eee;"><a href="javascript:void(0);" onclick="fn_update_billing_status('${result.projId}', '보류')" style="display:block; padding:8px; font-size:12px; color:#333;">보류</a></li>
						                <li style="border-bottom:1px solid #eee;"><a href="javascript:void(0);" onclick="fn_update_billing_status('${result.projId}', '청구파기')" style="display:block; padding:8px; font-size:12px; color:#333;">청구파기</a></li>
						            </ul>
						        </div>
						    </div>
						</td>
	                </tr>
	            </c:forEach>
	        </tbody>
	    </table>
	
	    <div class="pagination-wrapper" style="text-align:center; margin-top:20px;">
	        <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_link_page" />
	    </div>
		
		<div style="margin-top: 20px; font-size: 13px; color: #888;">
		    ※ 청구 데이터는 업무 등록 시 자동으로 생성됩니다. 상세 내용을 확인하시려면 업무명을 클릭하세요.
		</div>
		
		
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script>
        function fn_egov_link_page(pageNo){
            document.listForm.pageIndex.value = pageNo;
            document.listForm.action = "<c:url value='/pms/billingList.do'/>";
            document.listForm.submit();
        }
        
        function fn_open_billing_popup(projId) {
            var windowName = "billing_pop_" + projId;
            var url = "<c:url value='/pms/billingDetailPopup.do'/>?projId=" + projId;
            var options = "width=850, height=700, resizable=yes, scrollbars=yes";
            window.open(url, windowName, options);
        }
        
        function fn_egov_link_page(pageNo){
            document.listForm.pageIndex.value = pageNo;
            document.listForm.submit();
        }

        function fn_open_billing_popup(projId) {
            var url = "<c:url value='/pms/billingDetailPopup.do'/>?projId=" + projId;
            window.open(url, "billing_pop_" + projId, "width=900, height=750, resizable=yes, scrollbars=yes");
        }
        
        function fn_toggle_status_menu(projId, event) {
            event.stopPropagation();
            $(".status-menu-layer").hide();
            $("#status_menu_" + projId).toggle();
        }
        $(document).on("click", function() {
            $(".status-menu-layer").hide();
        });

        function fn_update_billing_status(projId, newStatus) {
            if(!confirm("해당 건의 정산 상태를 [" + newStatus + "](으)로 변경하시겠습니까?")) return;

            $.ajax({
                url: "<c:url value='/pms/updateProjectBillStatusAjax.do'/>",
                type: "POST",
                data: { 
                    "selectedId": projId, 
                    "billStatus": newStatus 
                },
                success: function(data) {
                    if(data.status === "success") {
                        location.reload();
                    } else {
                        alert("변경 실패: " + data.message);
                    }
                }
            });
        }
    </script>
    </div>
</body>
</html>