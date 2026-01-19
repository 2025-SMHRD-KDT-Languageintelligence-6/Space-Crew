<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>계약 관리 목록</title>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/egovframework/com/pms/ContractList.css'/>?v=1.1">
</head>
<body>
    <c:import url="/WEB-INF/jsp/egovframework/com/pms/include/menu.jsp" />
    <div class="content-page">
        <h2>계약 관리 목록</h2>

        <div class="search-box">
            <form name="listForm" action="<c:url value='/pms/contractList.do'/>" method="post">
                <input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>

                <label>계약명: </label>
                <input type="text" name="searchKeyword" value="<c:out value='${searchVO.searchKeyword}'/>" placeholder="계약명을 입력하세요" style="width:200px;" />
                <button type="submit" class="btn btn-blue" style="margin-left:10px;">검색</button>
            </form>
        </div>

	    <table>
	        <thead>
	            <tr>
	                <th width="8%">ID</th>
	                <th width="25%">계약명</th>
	                <th width="15%">계약금액(원)</th>
	                <th width="10%">담당자</th>
	                <th width="10%">상태</th>
	                <th width="12%">계약일</th>
	                <th width="10%">관리</th>
	            </tr>
	        </thead>
	        <tbody>
	            <c:forEach var="result" items="${resultList}" varStatus="status">
	                <tr>
	                    <td><c:out value="${result.contId}"/></td>
	                    <td class="text-left">
	                        <a href="javascript:void(0);" onclick="fn_open_contract_popup('${result.contId}', '${result.contNm}');"  style="font-weight:bold; color:#007bff;">
	                            <c:out value="${result.contNm}"/>
	                        </a>
	                    </td>
	                    <td class="text-right">
	                        <fmt:formatNumber value="${result.contAmt}" pattern="#,###" />
	                    </td>
	                    <td><c:out value="${result.picUserNm}"/></td>
	                    <td style="position: relative;">
						    <div class="status-container">
						        <a href="javascript:void(0);" 
						           class="status-badge ${result.contStatus eq '계약완료' ? 'status-won' : result.contStatus eq '검토중' ? 'status-ing' : 'status-lost'}"
						           onclick="fn_toggle_status_menu('${result.contId}', event);"
						           >
						            ${result.contStatus} ▼
						        </a>
						
						        <div id="status_menu_${result.contId}" class="status-menu-layer" style="display:none; position: absolute; z-index: 999; background: #fff; border: 1px solid #ccc; box-shadow: 2px 2px 5px rgba(0,0,0,0.2); width: 100px; left: 50%; transform: translateX(-50%);">
						            <ul style="list-style:none; padding:0; margin:0;">
						                <li style="border-bottom:1px solid #eee;"><a href="javascript:void(0);" onclick="fn_update_contract_status('${result.contId}', '검토중')" style="display:block; padding:8px; font-size:12px; color:#333;">검토중</a></li>
						                <li style="border-bottom:1px solid #eee;"><a href="javascript:void(0);" onclick="fn_update_contract_status('${result.contId}', '계약완료')" style="display:block; padding:8px; font-size:12px; color:#333;">계약완료</a></li>
						                <li><a href="javascript:void(0);" onclick="fn_update_contract_status('${result.contId}', '계약종료')" style="display:block; padding:8px; font-size:12px; color:#333;">계약종료</a></li>
						            </ul>
						        </div>
						    </div>
						</td>
	                    <td><c:out value="${result.contDt}"/></td>
	                    <td>

                                <a href="<c:url value='/pms/updateContractView.do'/>?selectedId=${result.contId}"
                                   class="btn btn-yellow btn-sm">수정</a>

                                <a href="javascript:void(0);"
                                   class="btn btn-red btn-sm"
                                   onclick="if(confirm('계약 정보를 삭제하시겠습니까?')) location.href='<c:url value='/pms/deleteContract.do'/>?selectedId=${result.contId}';">
                                   삭제
                                </a>

                        </td>

	                </tr>
	            </c:forEach>
	            <c:if test="${empty resultList}">
	                <tr>
	                    <td colspan="7">등록된 계약 내역이 없습니다.</td>
	                </tr>
	            </c:if>
	        </tbody>
	    </table>

	    <div class="pagination-wrapper" style="text-align:center; margin-top:20px;">
	        <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_link_page" />
	    </div>

	    <div style="margin-top: 20px;">
	        <a href="<c:url value='/pms/addContractView.do'/>" class="btn btn-blue">신규 계약 등록</a>
	    </div>

		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

	    <script type="text/javascript">
	        function fn_egov_link_page(pageNo){
	            document.listForm.pageIndex.value = pageNo;
	            document.listForm.action = "<c:url value='/pms/contractList.do'/>";
	            document.listForm.submit();
	        }

	        function fn_open_contract_popup(contId, contNm) {
	            var windowName = "contract_pop_" + contId;
	            var url = "<c:url value='/pms/contractDetailPopup.do'/>?selectedId=" + contId;
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

	        function fn_update_contract_status(contId, nextStatus) {
	            if(!confirm("계약 상태를 [" + nextStatus + "]로 변경하시겠습니까?")) return;

	            $.ajax({
	                url: "<c:url value='/pms/updateContractStatusAjax.do'/>",
	                type: "POST",
	                data: { 
	                    "selectedId": contId,
	                    "contStatus": nextStatus 
	                },
	                dataType: "json",
	                success: function(data) {
	                    if(data.status == "success") {
	                        alert("계약 상태가 변경되었습니다.");
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