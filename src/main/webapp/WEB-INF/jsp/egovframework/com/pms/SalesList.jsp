<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
	<style>
		.fav-link {
		    text-decoration: none;
		    transition: transform 0.2s ease-in-out;
		    display: inline-block;
		}
		
		.fav-link:hover {
		    transform: scale(1.2);
		}
	</style>
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
                <input type="text" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>" placeholder="영업건명을 입력하세요" style="width:200px;" />
                <button type="submit" class="btn btn-blue">검색</button>
            </form>
        </div>

        <table>
            <thead>
                <tr>
					<th width="5%">즐겨찾기</th>
                    <th width="23%">영업건명</th>
                    <th width="12%">고객사</th>
                    <th width="10%">영업담당자</th>
                    <th width="15%">예상금액</th>
                    <th width="12%">수주확률</th>
                    <th width="13%">상태</th>
                    <th width="10%">관리</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="result" items="${resultList}" varStatus="status">
                    <tr>
                    	<td>
						    <a href="javascript:void(0);"
						       onclick="fn_toggle_favorite('${result.salesId}', '${result.favYn}', 'SALES');"
						       id="fav_${result.salesId}" class="fav-link">
						        <c:choose>
						            <c:when test="${result.favYn eq 'Y'}">
						                <span style="color: #ffc107; font-size: 18px;">★</span>
						            </c:when>
						            <c:otherwise>
						                <span style="color: #ccc; font-size: 18px;">☆</span>
						            </c:otherwise>
						        </c:choose>
						    </a>
						</td>
                        <td class="text-left">
                            <a href="javascript:void(0);" onclick="fn_open_sales_popup('${result.salesId}', '${result.salesTitle}');" style="font-weight:bold; color:#007bff;">
                                <c:out value="${result.salesTitle}"/>
                            </a>
                        </td>

                        <td><c:out value="${result.custNm}"/></td>

                        <td><c:out value="${result.salesNm}"/></td>

                        <td>
                            <c:choose>
                                <c:when test="${not empty result.expectedAmt}">
                                    <fmt:formatNumber value="${result.expectedAmt}" pattern="#,###"/>원
                                </c:when>
                                <c:otherwise>-</c:otherwise>
                            </c:choose>
                        </td>

                        <td>
                            <c:if test="${not empty result.probability}">
                                <span><c:out value="${result.probability}"/>%</span>
                                <div class="prob-container">
                                    <div class="prob-bar" style="width: ${result.probability}%;"></div>
                                </div>
                            </c:if>
                        </td>

                        <td style="position: relative;">
                           <div class="status-container">
                               <c:choose>
                                   <c:when test="${not empty result.status}">
                                       <a href="javascript:void(0);"
                                          class="status-badge ${result.status eq '영업중' ? 'status-won' : result.status eq '수주완료' ? 'status-negotiating' : 'status-lost'}"
                                          onclick="fn_toggle_status_menu('${result.salesId}', event);">
                                           <c:out value="${result.status}"/> ▼
                                       </a>
                                       <div id="status_menu_${result.salesId}" class="status-menu-layer" style="display:none;">
                                           <ul>
                                               <li><a href="javascript:void(0);" onclick="fn_update_sales_status('${result.salesId}', '영업중')">영업중</a></li>
                                               <li><a href="javascript:void(0);" onclick="fn_update_sales_status('${result.salesId}', '영업완료')">영업완료</a></li>
                                               <li><a href="javascript:void(0);" onclick="fn_update_sales_status('${result.salesId}', '영업취소')">영업취소</a></li>
                                               <li><a href="javascript:void(0);" onclick="fn_update_sales_status('${result.salesId}', '보류')">보류</a></li>
                                           </ul>
                                       </div>
                                   </c:when>
                                   <c:otherwise>-</c:otherwise>
                               </c:choose>
                           </div>
                        </td>

                        <td>
                          <a href="<c:url value='/pms/updateSalesView.do'/>?selectedId=${result.salesId}" class="btn btn-yellow btn-sm">수정</a>
                          <a href="javascript:void(0);" class="btn btn-red btn-sm" onclick="if(confirm('삭제하시겠습니까?')) location.href='<c:url value='/pms/deleteSales.do'/>?selectedId=${result.salesId}';">삭제</a>
                        </td>
                    </tr>
                </c:forEach>

                <c:if test="${empty resultList}">
                    <tr>
                        <td colspan="8">등록된 영업 내역이 없습니다.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>

        <div class="pagination-wrapper">
            <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_link_page" />
        </div>

        <div style="margin-top: 20px;">
            <a href="<c:url value='/pms/addSalesView.do'/>" class="btn btn-blue">신규 영업 등록</a>
        </div>

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
    
    function fn_toggle_favorite(targetId, currentFavYn, targetType) {
        $.ajax({
            url: "<c:url value='/pms/toggleCustomerFavoriteAjax.do'/>",
            type: "POST",
            data: { 
                "targetId": targetId, 
                "targetType": targetType
            },
            dataType: "json",
            success: function(data) {
                if(data.status === "success") {
                    location.reload(); 
                } else {
                    alert("처리 중 문제가 발생했습니다: " + data.message);
                }
            },
            error: function() { 
                alert("서버 통신 중 오류가 발생했습니다."); 
            }
        });
    }
    </script>

</body>
</html>