<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>고객사 관리 목록</title>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/egovframework/com/pms/CustomerList.css'/>?v=1.1" >
</head>
<body>
    <c:import url="/WEB-INF/jsp/egovframework/com/pms/include/menu.jsp" />

    <div class="content-page">
        <h2>고객사 관리 목록</h2>


        <div class="search-box">
            <form name="listForm" action="<c:url value='/pms/customerList.do'/>" method="post">
                <input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>

                <label>고객사명: </label>
                <input type="text" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>" placeholder="고객사명을 입력하세요" style="width:200px;" />
                <button type="submit" class="btn btn-blue">검색</button>
            </form>
        </div>




        <table>
            <thead>
                <tr>
                    <th width="7%">즐겨찾기</th>
                    <th width="28%">고객사명</th>
                    <th width="15%">사업자등록번호</th>
                    <th width="8%">대표</th>
                    <th width="8%">담당자</th>
                    <th width="15%">연락처</th>
                    <th width="9%">고객 등급</th>
                    <th width="10%">관리</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="result" items="${resultList}" varStatus="status">
                    <tr>
                    	<td>
						    <a href="javascript:void(0);"
						       onclick="fn_toggle_favorite('${result.custId}', '${result.favYn}', 'CUSTOMER');"
						       id="fav_${result.custId}" class="fav-link">
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
                            <a href="javascript:void(0);" onclick="fn_open_customer_popup('${result.custId}', '${result.custNm}');" style="font-weight:bold; color:#007bff;">
                                <c:out value="${result.custNm}"/>
                            </a>
                        </td>

                        <td><c:out value=""/>${result.bizRegNo}</td>
						<td><c:out value="${result.ceoNm}"/></td>
                        <td><c:out value="${result.picNm}"/></td>

                        <td><c:out value="${result.picTel}"/></td>

                        <td><c:out value="${result.custGrade}"/></td>

                        <td>
                           <a href="<c:url value='/pms/updateCustomerView.do'/>?selectedId=${result.custId}"
                              class="btn btn-yellow btn-sm">수정</a>

                            <%--
                            <a href="<c:url value='/pms/deleteCustomer.do'/>?selectedId=${result.custId}"
                               class="btn btn-red btn-sm"
                               onclick="return confirm('고객사 정보를 삭제하시겠습니까?');">삭제</a>
                            --%>

                           <a href="javascript:void(0);"
                              class="btn btn-red btn-sm"
                              onclick="if(confirm('삭제하시겠습니까?')) location.href='<c:url value='/pms/deleteCustomer.do'/>?selectedId=${result.custId}';">
                              삭제
                           </a>

                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty resultList}">
                    <tr>
                        <td colspan="7">등록된 고객사 내역이 없습니다.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>

        <div class="pagination-wrapper" style="text-align:center; margin-top:20px;">
            <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_link_page" />
        </div>

        <div class="action-bar">
            <a href="<c:url value='/pms/addCustomerView.do'/>" class="btn btn-blue">신규 고객 등록</a>
        </div>

		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        <script type="text/javascript">
            function fn_egov_link_page(pageNo){
                document.listForm.pageIndex.value = pageNo;
                document.listForm.action = "<c:url value='/pms/customerList.do'/>";
                document.listForm.submit();
            }

            function fn_open_customer_popup(custId, custNm) {
                var windowName = "customer_pop_" + custId;
                var url = "<c:url value='/pms/customerDetailPopup.do'/>?selectedId=" + custId;
                var options = "width=700, height=600, resizable=yes, scrollbars=yes, status=no";
                window.open(url, windowName, options);
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
    </div>
</body>
</html>