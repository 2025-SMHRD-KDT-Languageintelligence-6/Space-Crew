<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>직원 상세 정보</title>
    <%-- 기존 공통 CSS --%>
    <link rel="stylesheet" href="<c:url value='/css/egovframework/com/com.css'/>">
	<style>
		.fc-event {
		    border: none !important;
		}
		.fc-event-title, 
		.fc-event-main,
		.fc-event-main-frame {
		    color: #ffffff !important;
		    font-weight: bold !important;
		}
		.fc-event:hover {
		    color: #ffffff !important;
		}
		.btn_s_blue { background: #5998eb !important; color: white !important; border: none !important; }
		.btn_s_red  { background: #f7928b !important; color: white !important; border: none !important; }
		.btn_s_gray { background: #666666 !important; color: white !important; border: none !important; }
		.btn_s_purple { background: #673AB7 !important; color: white !important; border: none !important; }
	</style>
	<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js'/>"></script>
	
	<script type="text/javascript">
	    function fn_egov_downFile(atchFileId, fileSn) {
	        window.open("<c:url value='/cmm/fms/FileDown.do'/>?atchFileId="+atchFileId+"&fileSn="+fileSn);
	    }
	    
	    function fn_egov_deleteFile(atchFileId, fileSn) {
	        if(confirm("삭제하시겠습니까?")) {
	        }
	    }
	</script>
</head>
<body>
    <div class="popup-header">
        <h2>📂 직원 정보 : ${userVO.userId}</h2>
    </div>

    <div class="main-info-container">
        <div class="info-table-wrapper">
            <table class="w3-table-all">
                <colgroup>
                    <col style="width:30%;">
                    <col style="width:70%;">
                </colgroup>
                <tr><th>이름</th><td>${userVO.userNm}</td></tr>
                <tr><th>부서</th><td>${userVO.deptNm}</td></tr>
                <tr><th>직무</th><td>${userVO.jobRole}</td></tr>
                <tr><th>직급</th><td>${userVO.positionNm}</td></tr>
                <tr><th>경력연수</th><td>${userVO.careerYears}</td></tr>
                <tr><th>전문분야</th><td>${userVO.jobField}</td></tr>
                <%-- <tr><th>가동률</th><td>${userVO.currentLoad}</td></tr> --%>
                <tr><th>입사일</th><td>${userVO.joinDt}</td></tr>
                <tr><th>재직</th><td>${userVO.useYn}</td></tr>
                <tr><th>보유스택</th><td>${userVO.skillDesc}</td></tr>
            </table>
        </div>
        <%-- <div class="info-photo-wrapper" style="text-align:center; padding:10px; border:1px solid #ddd; background:#fff;">
		    <c:choose>
		        <c:when test="${not empty userVO.atchFileId}">
		            <img src="<c:url value='/cmm/fms/getImage.do'/>?atchFileId=${userVO.atchFileId}&fileSn=0" 
		                 alt="직원 사진" 
		                 style="width:150px; height:180px; object-fit:cover; border:1px solid #ccc;">
		        </c:when>
		        <c:otherwise>
		            <img src="<c:url value='/images/egovframework/com/cmm/icon/no_image.gif'/>" 
		                 alt="사진 미등록" 
		                 style="width:150px; height:180px; opacity:0.5;">
		            <div class="no-photo-text" style="margin-top:5px; color:#999; font-size:12px;">사원 사진 미등록</div>
		        </c:otherwise>
		    </c:choose>
		</div> --%>
    </div>

    <div class="file-upload-wrapper" style="margin: 20px 0; padding: 15px; background: #f8f9fa; border: 1px dashed #ccc;">
	    <h4 style="font-size:15px;"><i class="fa fa-upload"></i> 파일 업로드</h4>
	    <div style="display: flex; gap: 10px; align-items: center;">
	        <input type="file" id="ajaxFileInput" name="file_1" multiple style="flex-grow: 1;" />
	        <button type="button" onclick="fn_file_ajax_upload();" class="btn_blue" style="padding: 5px 15px; white-space: nowrap; min-width: 45px;">업로드</button>
	    </div>
	    <small style="color: #666;">* 여러 파일을 한 번에 선택할 수 있습니다.</small>
	</div>
	
    <div id="file_list_area">
	    <c:import url="/cmm/fms/selectFileInfs.do" charEncoding="utf-8">
	        <c:param name="param_atchFileId" value="${userVO.atchFileId}" />
	        <c:param name="atchFileId" value="${userVO.atchFileId}" />
	    </c:import>
	</div>
	
    <div class="btn-close">
    	<button type="button" onclick="fn_go_update_page('${userVO.userId}');" class="btn_s_blue">수정</button>
        <button type="button" onclick="window.close();" class="btn_s_gray">닫기</button>
    </div>

    <div class="calendar-section">
        <h4><i class="fa fa-calendar"></i> 개인별 프로젝트 투입 일정</h4>
        <div id='userCalendar'></div>
    </div>



    <link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.css' rel='stylesheet' />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.js'></script>
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/locales-all.min.js'></script>
    <script>
       $(document).ready(function() {
           var calendarEl = document.getElementById('userCalendar');
           var userCalendar = new FullCalendar.Calendar(calendarEl, {
               initialView: 'dayGridMonth',
               locale: 'ko',
               height: 500,
               displayEventTime: false,
               headerToolbar: {
                   left: 'prev,next today',
                   center: 'title',
                   right: 'dayGridMonth,dayGridWeek'
               },
               events: function(info, successCallback, failureCallback) {
                   $.ajax({
                       url: "<c:url value='/pms/selectUserAssignListAjax.do'/>",
                       type: 'POST',
                       data: { "userId": "${userVO.userId}" },
                       success: function(data) {
                    	   if(data.list && data.list.length > 0) {
                    	        var firstItem = data.list[0];
                    	        console.log("=== [시작] ===");
                    	        for (var key in firstItem) {
                    	            console.log("Key: [" + key + "] / Value: " + firstItem[key]);
                    	        }
                    	        console.log("=== [종료] ===");
                    	    }
                    	   
                           var events = data.list.map(function(item) {
                               var colorList = ['#3498db', '#1abc9c', '#9b59b6', '#f1c40f', '#e67e22', '#34495e', '#27ae60'];
                               var eventColor = colorList[item.assignId % colorList.length];
                               
                               var pId = item.projId || item.PROJID || item.PROJ_ID;
                               
                               return {
                                   title: "[" + item.projNm + "] " + item.title + " (" + (item.inputRate * 100) + "%)",
                                   start: item.startDt,
                                   end: item.endDt + "T23:59:59",
                                   color: eventColor,
                                   borderColor: (item.inputRate >= 1.0) ? '#ff0000' : eventColor,
                                   borderWidth: (item.inputRate >= 1.0) ? '3px' : '1px',
                                   extendedProps: {
                                	   projId: pId
                                   }
                               };
                           });
                           successCallback(events);
                       }
                   });
               },
               eventClick: function(info) {
            	    var projId = info.event.extendedProps.projId;
            	    if (projId) {
            	        var url = "<c:url value='/pms/projectDetailPopup.do'/>?selectedId=" + projId;
            	        var name = "proj_pop_" + projId;
            	        var specs = "width=1100,height=900,resizable=yes,scrollbars=yes";
            	        
            	        window.open(url, name, specs);
            	    }
            	}
           });
           userCalendar.render();
       });
       
       function fn_go_update_page(id) {
   	    
   	    
	   	    if(!id || id === "") {
	   	        alert("ID 정보가 없어 수정 페이지로 이동할 수 없습니다.");
	   	        return;
	   	    }
	
	   	    if (!window.opener || window.opener.closed) {
	   	        alert("부모 창을 찾을 수 없습니다.");
	   	        return;
	   	    }
	   	    if (!confirm("수정 페이지로 이동하시겠습니까?\n(현재 팝업은 자동으로 닫힙니다)")) return;
	   	    
	   	    var updateUrl = "<c:url value='/pms/updateUserView.do'/>?selectedId=" + id;
	   	    
	   	    try {
	   	        window.opener.location.href = updateUrl;
	   	        
	   	        setTimeout(function() {
	   	            window.close();
	   	        }, 100);
	   	    } catch (e) {
	   	        window.opener.location = updateUrl;
	   	        window.close();
	   	    }
	   	}
       
       function fn_file_ajax_upload() {
    	    var fileInput = document.getElementById('ajaxFileInput');
    	    if (fileInput.files.length === 0) {
    	        alert("파일을 선택해주세요.");
    	        return;
    	    }
    	    var formData = new FormData();
    	    for (var i = 0; i < fileInput.files.length; i++) {
    	        formData.append("file_" + i, fileInput.files[i]);
    	    }
    	    formData.append("userId", "${userVO.userId}");
    	    formData.append("atchFileId", "${userVO.atchFileId}");

    	    $.ajax({
    	        url: "<c:url value='/pms/uploadFileAjax.do'/>",
    	        type: "POST",
    	        data: formData,
    	        processData: false,
    	        contentType: false,
    	        success: function(data) {
    	            if(data.status === "success") {
    	                alert("파일이 성공적으로 업로드되었습니다.");
    	                location.reload(); 
    	            } else {
    	                alert("오류 발생: " + data.message);
    	            }
    	        },
    	        error: function() { alert("서버 통신 오류가 발생했습니다."); }
    	    });
    	}
       
    </script>
</body>
</html>