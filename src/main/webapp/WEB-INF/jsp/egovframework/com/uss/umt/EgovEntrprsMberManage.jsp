<%
 /**
  * @Class Name : EgovEntrprsMberManage.jsp
  * @Description : 기업회원관리(조회,삭제) JSP
  * @Modification Information
  * @
  * @  수정일         수정자                   수정내용
  * @ -------    --------    ---------------------------
  * @ 2009.03.02    조재영          최초 생성
  * @ 2016.07.26    장동한          표준프레임워크 v3.6 개선
  *
  *  @author 공통서비스 개발팀 조재영
  *  @since 2009.03.02
  *  @version 1.0
  *  @see
  *
  */
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="pageTitle"><spring:message code="comUssUmt.entrprsUserManage.title"/></c:set>
<!DOCTYPE html>
<html>
<head>
<title>${pageTitle} <spring:message code="title.list" /></title><!-- 기업회원관리 목록 -->
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/com/com.css' />">
<!-- 메니저 권한 디자인 css 추가  -->
<link rel="stylesheet" href="<c:url value='/css/egovframework/com/manage.css'/>">
<script type="text/javaScript" language="javascript" defer="defer">
<!--
function fncCheckAll() {
    var checkField = document.listForm.checkField;
    if(document.listForm.checkAll.checked) {
        if(checkField) {
            if(checkField.length > 1) {
                for(var i=0; i < checkField.length; i++) {
                    checkField[i].checked = true;
                }
            } else {
                checkField.checked = true;
            }
        }
    } else {
        if(checkField) {
            if(checkField.length > 1) {
                for(var j=0; j < checkField.length; j++) {
                    checkField[j].checked = false;
                }
            } else {
                checkField.checked = false;
            }
        }
    }
}
function fnDeleteUser() {
    var checkField = document.listForm.checkField;
    var id = document.listForm.checkId;
    var checkedIds = "";
    var checkedCount = 0;
    if(checkField) {
        if(checkField.length > 1) {
            for(var i=0; i < checkField.length; i++) {
                if(checkField[i].checked) {
                    checkedIds += ((checkedCount==0? "" : ",") + id[i].value);
                    checkedCount++;
                }
            }
        } else {
            if(checkField.checked) {
                checkedIds = id.value;
            }
        }
    }
    if(checkedIds.length > 0) {
        if(confirm("<spring:message code="common.delete.msg" />")){
        	document.listForm.checkedIdForDel.value=checkedIds;
            document.listForm.action = "<c:url value='/uss/umt/EgovEntrprsMberDelete.do'/>";
            document.listForm.submit();
        }
    }
}
function fnSelectUser(id) {
    document.listForm.selectedId.value = id;
    array = id.split(":");
    if(array[0] == "") {
    } else {
        userTy = array[0];
        userId = array[1];
    }
   	document.listForm.selectedId.value = userId;
    document.listForm.action = "<c:url value='/uss/umt/EgovEntrprsMberSelectUpdtView.do'/>";
    document.listForm.submit();

}
function fnAddUserView() {
	document.listForm.action = "<c:url value='/uss/umt/EgovEntrprsMberInsertView.do'/>";
    document.listForm.submit();
}
function fnLinkPage(pageNo){
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/uss/umt/EgovEntrprsMberManage.do'/>";
    document.listForm.submit();
}
function fnSearch(){
	document.listForm.pageIndex.value = 1;
	document.listForm.action = "<c:url value='/uss/umt/EgovEntrprsMberManage.do'/>";
    document.listForm.submit();
}
<c:if test="${!empty resultMsg}">alert("<spring:message code="${resultMsg}" />");</c:if>
-->
</script>
</head>
<body class="popup-body">

<!-- javascript warning tag  -->
<noscript class="noScriptTitle"><spring:message code="common.noScriptTitle.msg" /></noscript>

<form name="listForm" action="<c:url value='/uss/umt/EgovEntrprsMberManage.do'/>" method="post"> 
<div class="board">
	<div class="page-head">
      <h1 class="page-title">${pageTitle} <spring:message code="title.list" /></h1>
    </div>
	
	<!-- 검색영역 -->
	<div class="search_box" title="<spring:message code="common.searchCondition.msg" />">

      <!-- 1줄: 요약 + 필터 -->
      <div class="search-row">
        <div class="search-meta">
          사용자수 <strong><c:out value="${paginationInfo.totalRecordCount}"/></strong>
        </div>

        <div class="search-filters">
          <select name="sbscrbSttus" id="sbscrbSttus" title="<spring:message code="comUssUmt.userManageSsearch.sbscrbSttusTitle" />">
            <option value="0" <c:if test="${empty mberVO.sbscrbSttus || mberVO.sbscrbSttus == '0'}">selected="selected"</c:if> ><spring:message code="comUssUmt.userManageSsearch.sbscrbSttusAll" /></option>
            <option value="가입신청" <c:if test="${mberVO.sbscrbSttus == 'A'}">selected="selected"</c:if> ><spring:message code="comUssUmt.userManageSsearch.sbscrbSttusA" /></option>
            <option value="승인" <c:if test="${mberVO.sbscrbSttus == 'D'}">selected="selected"</c:if> ><spring:message code="comUssUmt.userManageSsearch.sbscrbSttusD" /></option>
            <option value="삭제" <c:if test="${mberVO.sbscrbSttus == 'P'}">selected="selected"</c:if> ><spring:message code="comUssUmt.userManageSsearch.sbscrbSttusP" /></option>
          </select>

          <select name="searchCondition" id="searchCondition" title="<spring:message code="comUssUmt.userManageSsearch.searchConditioTitle" />">
            <option value="0" <c:if test="${mberVO.searchCondition == '0'}">selected="selected"</c:if> ><spring:message code="comUssUmt.userManageSsearch.searchConditionId" /></option>
            <option value="1" <c:if test="${empty mberVO.searchCondition || mberVO.searchCondition == '1'}">selected="selected"</c:if> ><spring:message code="comUssUmt.userManageSsearch.searchConditionName" /></option>
          </select>
        </div>
      </div>

      <!-- 2줄: 검색어 + 버튼 -->
      <div class="search-row">
        <div class="search-inputs">
          <input class="s_input" name="searchKeyword" type="text" size="35"
                 title="<spring:message code="title.search" /> <spring:message code="input.input" />"
                 value='<c:out value="${userSearchVO.searchKeyword}"/>'
                 maxlength="255" />
        </div>

        <div class="search-actions">
          <input type="submit" class="s_btn" value="<spring:message code="button.inquire" />" />
          <input type="button" class="s_btn" onClick="fnDeleteUser(); return false;" value="<spring:message code="title.delete" />" />
          <span class="btn_b">
            <a href="<c:url value='/uss/umt/EgovEntrprsMberInsertView.do'/>" onClick="fnAddUserView(); return false;">
              <spring:message code="button.create" />
            </a>
          </span>
        </div>
      </div>

    </div>

    <div class="board_list_wrap">
        <table class="board_list" summary="<spring:message code="common.summary.list" arguments="${pageTitle}" />">
        <caption>${pageTitle} <spring:message code="title.list" /></caption>
        <colgroup>
            <col style="width: 6%;"> <!-- 번호 -->
            <col style="width: 5%;"> <!-- 체크 -->

            <col style="width: 14%;"> <!-- 기업회원아이디(줄바꿈 방지 핵심) -->
            <col style="width: 12%;"> <!-- 회사명 -->
            <col style="width: 10%;"> <!-- 사용자이름 -->
            <col style="width: 22%;"> <!-- 이메일 -->
            <col style="width: 14%;"> <!-- 전화번호 -->
            <col style="width: 10%;"> <!-- 등록일 -->
            <col> <!-- 가입상태 -->
        </colgroup>
        <thead>
        <tr>
            <th><spring:message code="table.num" /></th><!-- 번호 -->
            <th><input type="checkbox" name="checkAll" class="check2" onclick="javascript:fncCheckAll()" title="<spring:message code="input.selectAll.title" />"></th><!-- 전체선택 -->

            <th class="board_th_link"><spring:message code="comUssUmt.entrprsUserManageList.id" /></th><!--아이디 -->
            <th><spring:message code="comUssUmt.entrprsUserManageList.company" /></th><!-- 회사명 -->
            <th><spring:message code="comUssUmt.entrprsUserManageList.name" /></th><!-- 신청자이름 -->
            <th><spring:message code="comUssUmt.entrprsUserManageList.email" /></th><!-- 사용자이메일 -->
            <th><spring:message code="comUssUmt.entrprsUserManageList.phone" /></th><!-- 전화번호 -->
            <th><spring:message code="table.regdate" /></th><!-- 등록일 -->
            <th><spring:message code="comUssUmt.entrprsUserManageList.sbscrbSttus" /></th><!-- 가입상태 -->

        </tr>
        </thead>
        <tbody class="ov">
        <c:if test="${fn:length(resultList) == 0}">
        <tr>
            <td colspan="9"><spring:message code="common.nodata.msg" /></td>
        </tr>
        </c:if>
        <c:forEach var="result" items="${resultList}" varStatus="status">
        <tr>
            <td><c:out value="${status.count}"/></td>
            <td>
                <input type="checkbox" name="checkField" class="check2" title="선택"/>
                <input name="checkId" type="hidden" value="<c:out value='${result.userTy}'/>:<c:out value='${result.uniqId}'/>"/>
            </td>
            <td title="<c:out value='${result.userId}'/>"><a href="<c:url value='/uss/umt/EgovEntrprsMberSelectUpdtView.do'/>?selectedId=<c:out value="${result.uniqId}"/>"  onclick="javascript:fnSelectUser('<c:out value="${result.userTy}"/>:<c:out value="${result.uniqId}"/>'); return false;"><c:out value="${result.userId}"/></a></td>
            <td><c:out value="${result.cmpnyNm}"/></td>
            <td><c:out value="${result.userNm}"/></td>
            <td title="<c:out value='${result.emailAdres}'/>"><c:out value="${result.emailAdres}"/></td>
            <td title="<c:out value='${result.areaNo}'/>-<c:out value='${result.middleTelno}'/>-<c:out value='${result.endTelno}'/>">
              <c:out value="${result.areaNo}"/>)<c:out value="${result.middleTelno}"/>-<c:out value="${result.endTelno}"/>
            </td>
            <td title="<c:out value='${result.sbscrbDe}'/>">
              <c:out value="${fn:substring(result.sbscrbDe,0,10)}"/>
            </td>
            <td>
              <c:set var="sttusName" value="-" />
              <c:forEach var="code" items="${emplyrSttusCode_result}">
                <c:if test="${result.sttus == code.code}">
                  <c:set var="sttusName" value="${code.codeNm}" />
                </c:if>
              </c:forEach>
              <c:out value="${sttusName}" />
            </td>
        </tr>
        </c:forEach>
        </tbody>
        </table>
    </div>
	
	<!-- paging navigation -->
	<div class="pagination">
		<ul><ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnLinkPage"/></ul>
	</div>
	
	<input name="selectedId" type="hidden" />
	<input name="checkedIdForDel" type="hidden" />
	<input name="pageIndex" type="hidden" value="<c:out value='${userSearchVO.pageIndex}'/>"/>
</div>
</form>

</body>
</html>
