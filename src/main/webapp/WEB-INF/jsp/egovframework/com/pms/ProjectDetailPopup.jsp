<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>
<html>
<head>
    <title>업무 상세 정보</title>
    <link rel="stylesheet" href="<c:url value='/css/egovframework/com/com.css'/>">
    <style>
        body { padding: 20px; font-family: 'Malgun Gothic'; }
        .popup-header { border-bottom: 2px solid #333; padding-bottom: 10px; margin-bottom: 20px; }
        .btn-close { margin-top: 20px; text-align: center; }
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
        <h2>📂 업무 정보 : ${projectVO.projNm}</h2>
    </div>

    <table class="w3-table-all">
        <colgroup>
            <col style="width:30%;">
            <col style="width:70%;">
        </colgroup>
        <tr>
            <th>고객사명</th>
            <td>${projectVO.custNm}</td>
        </tr>
        <tr>
            <th>영업건명</th>
            <td>${projectVO.salesTitle}</td>
        </tr>
        <tr>
            <th>영업담당자</th>
            <td>${projectVO.salesUserNm}</td>
        </tr>
        <tr>
            <th>계약명</th>
            <td>${projectVO.contNm}</td>
        </tr>
        <tr>
            <th>계약담당자</th>
            <td>${projectVO.picUserNm}</td>
        </tr>
        <tr>
            <th>업무 유형</th>
            <td>${projectVO.projType}</td>
        </tr>
        <tr>
            <th>상태</th>
            <td>${projectVO.status}</td>
        </tr>
        <tr>
            <th>주담당자</th>
            <td>${projectVO.mainMgrNm}</td>
        </tr>
        <tr>
            <th>부담당자</th>
            <td>${projectVO.subMgrNm}</td>
        </tr>
        <tr>
            <th>시작일</th>
            <td>${projectVO.startDt}</td>
        </tr>
        <tr>
            <th>종료일</th>
            <td>${projectVO.endDt}</td>
        </tr>
        <tr>
            <th>진행률</th>
            <td>
		        <div style="width:100%; background:#eee; height:24px; border-radius:12px; overflow:hidden; position:relative;">
				    <div id="planProgressBar" style="width:0%; background:rgba(76, 175, 80, 0.3); height:100%; position:absolute; top:0; left:0; transition:width 0.5s;"></div>
				    
				    <div id="mainProgressBar" style="width:0%; background:#4CAF50; height:100%; position:absolute; top:0; left:0; transition:width 0.5s; z-index:2;"></div>
				    
				    <span id="mainProgressText" style="position:absolute; width:100%; text-align:center; top:0; line-height:24px; font-size:12px; font-weight:bold; color:#000; z-index:3;">0%</span>
				</div>
				<div style="margin-top:5px; font-size:11px; color:#666; display:flex; justify-content:space-between;">
				    <span>현재 : <span id="currentTotalEffort">0</span> MM</span>
				    <span>예약 : <span id="planTotalEffort">0</span> MM / 목표 : ${projectVO.estEffort} MM</span>
				</div>
		    </td>
        </tr>
        <tr>
            <th>요구 기술 사항</th>
            <td>
                <textarea id="reqSkills" name="reqSkills" rows="3" style="width: 80%;" placeholder="예: 트래픽 처리에 능숙한 자바 개발자">${projectVO.reqSkills}</textarea>

                <button type="button" class="btn btn-primary" onclick="openAIRecommendationPopup()">
                    AI 인력 추천
                </button>
            </td>
        </tr>
        </table>
    
    <div class="file-upload-wrapper" style="margin: 20px 0; padding: 15px; background: #f8f9fa; border: 1px dashed #ccc;">
	    <h4 style="font-size:15px;"><i class="fa fa-upload"></i> 파일 즉시 업로드</h4>
	    <div style="display: flex; gap: 10px; align-items: center;">
	        <input type="file" id="ajaxFileInput" name="file_1" multiple style="flex-grow: 1;" />
	        <button type="button" onclick="fn_file_ajax_upload();" class="btn_blue" style="padding: 5px 15px;">업로드</button>
	    </div>
	    <small style="color: #666;">* 여러 파일을 한 번에 선택할 수 있습니다.</small>
	</div>
	
    <div id="file_list_area">
	    <c:import url="/cmm/fms/selectFileInfs.do" charEncoding="utf-8">
	        <c:param name="param_atchFileId" value="${projectVO.atchFileId}" />
	        <c:param name="atchFileId" value="${projectVO.atchFileId}" />
	    </c:import>
	</div>
    
    
    
	<div class="assign-section" style="margin-top:30px;">
	    <h3>투입 인력 현황</h3>
	    <table class="table" id="assignTable">
	        <thead>
	            <tr>
	                <th>성명</th>
	                <th>업무</th>
	                <th>투입기간</th>
	                <th>투입률(M/M)</th>
	                <th>확인</th>
	                <th>관리</th>
	            </tr>
	        </thead>
	        <tbody id="assignListBody">
	            </tbody>
	    </table>
	    <button type="button" class="btn btn-blue" onclick="fn_open_assign_popup();">인력 배정 추가</button>
	</div>
    
    <div id="assignModal" style="display:none; position:fixed; top:50%; left:50%; transform:translate(-50%, -50%); width:400px; background:#fff; border:1px solid #000; padding:20px; z-index:1000; box-shadow: 5px 5px 15px rgba(0,0,0,0.3);">
	    <h3>인력 배정 등록</h3>
	    <input type="hidden" id="taskGroupId">
	    <table style="width:100%;">
	        <tr>
	            <th>프로젝트명</th>
	            <td><input type="text" id="assignTitle" style="width:100%;"></td>
	        </tr>
	        <tr>
	            <th>시작일</th>
	            <td><input type="date" id="assignStartDate"></td>
	        </tr>
	        <tr>
	            <th>종료일</th>
	            <td><input type="date" id="assignEndDate"></td>
	        </tr>
	        <tr>
	            <th>투입률</th>
	            <td>
	    	        <span id="totalInputRateDisplay" style="font-weight:bold; color:#2196F3; font-size:1.1em;">0.00</span> 
      				<input type="hidden" id="totalInputRate" value="0">M/M
   				</td>
	        </tr>
	    </table>
	    <div style="margin-top:20px; border-top:1px solid #ddd; padding-top:10px;">
	        <div style="display:flex; justify-content:space-between; align-items:center;">
	            <strong>투입 인원 목록</strong>
	            <button type="button" class="btn_s" onclick="fn_open_user_search();">인원 추가</button>
	        </div>
	        <table style="width:100%; margin-top:10px;" id="selectedUserTable">
	            <thead>
	                <tr style="background:#f9f9f9;">
	                    <th>성명</th>
	                    <th>투입률(MM)</th>
	                    <th>삭제</th>
	                </tr>
	            </thead>
	            <tbody id="selectedUserListBody">
	                </tbody>
	        </table>
	    </div>
	    <div style="text-align:right; margin-top:15px;">
	        <button type="button" class="btn_s" onclick="fn_save_task_group();">저장</button>
	        <button type="button" class="btn_s" onclick="$('#assignModal').hide();">취소</button>
	    </div>
	</div>
	
	
    <div id="userSearchModal" style="display:none; position:fixed; top:50%; left:50%; transform:translate(-50%, -50%); width:500px; background:#fff; border:2px solid #333; padding:20px; z-index:2000; box-shadow: 0 0 20px rgba(0,0,0,0.5);">
	    <div style="display:flex; justify-content:space-between; margin-bottom:15px;">
	        <h3 style="margin:0;">👥 직원 검색</h3>
	        <button type="button" onclick="$('#userSearchModal').hide();" style="cursor:pointer;">X</button>
	    </div>
	    
	    <div style="margin-bottom:15px; background:#f4f4f4; padding:10px; text-align:center;">
	        <input type="text" id="popSearchNm" placeholder="직원 성명을 입력하세요" style="width:200px; padding:5px;" onkeypress="if(event.keyCode==13) fn_pop_search_user();">
	        <button type="button" class="btn_s" onclick="fn_pop_search_user();">검색</button>
	    </div>
	
	    <div style="max-height:300px; overflow-y:auto;">
	        <table class="w3-table-all" style="width:100%; font-size:13px;">
	            <thead>
	                <tr style="background:#eee;">
	                    <th>부서</th>
	                    <th>직급</th>
	                    <th>성명</th>
	                    <th>선택</th>
	                </tr>
	            </thead>
	            <tbody id="userSearchResultBody">
	                <tr><td colspan="4" style="text-align:center;">검색어를 입력하고 검색 버튼을 누르세요.</td></tr>
	            </tbody>
	        </table>
	    </div>
	</div>
	
	<div id='calendar-container' style="margin-top:30px; border:1px solid #ddd; padding:10px; background:#fff;">
	    <div id='calendar'></div>
	</div>
	
	
    <div class="btn-close">
    	<button type="button" onclick="fn_go_update_page('${projectVO.projId}');" class="btn_blue">수정</button>
        <button type="button" onclick="window.close();" class="btn_s">닫기</button>
    </div>
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js'></script>
	<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/locales/ko.global.min.js"></script>
    
    <script type="text/javascript">
    function fn_save_assign() {
    	if(!$("#assignStartDate").val() || !$("#assignEndDate").val()){
            alert("시작일과 종료일을 입력해주세요.");
            return;
        }
        var assignData = {
            projId: "${projectVO.projId}",
            userId: $("#assignUserId").val(),
            assignTitle: $("#assignTitle").val(),
            startDate: $("#assignStartDate").val(),
            endDate: $("#assignEndDate").val(),
            inputRate: $("#assignInputRate").val(),
            forceSave: "N"
        };

        fn_ajax_save(assignData);
    }

    function fn_ajax_save(assignData) {
        $.ajax({
            url: "<c:url value='/pms/saveProjectAssignAjax.do'/>",
            type: "POST",
            data: assignData,
            success: function(data) {
                if(data.status === "SUCCESS") {
                    alert(data.message);
                    $('#assignModal').hide();
                    fn_load_assign_list();
                } else if(data.status === "OVERLOAD") {
                    if(confirm(data.message + "\n그래도 강제로 배정하시겠습니까?")) {
                        assignData.forceSave = "Y";
                        fn_ajax_save(assignData);
                    }
                } else {
                    alert("오류가 발생했습니다.");
                }
            }
        });
    }
	
	function fn_open_assign_popup() {
		$("#taskGroupId").val("");
	    $("#assignTitle").val("");
	    $("#selectedUserListBody").empty();
	    $("#totalInputRateDisplay").text("0.0");
	    $('#assignModal').show();
	}
	
	function fn_pop_search_user() {
	    var searchNm = $("#popSearchNm").val();
	    if(!searchNm) { alert("검색어를 입력하세요."); return; }

	    $.ajax({
	        url: "<c:url value='/pms/searchUserAjax.do'/>",
	        data: { "searchNm": searchNm },
	        success: function(data) {
	            var html = "";
	            if(data.userList && data.userList.length > 0) {
	                $.each(data.userList, function(idx, user) {
	                    var rawLoad = parseFloat(user.currentLoad) || 0;
	                    var rate = (rawLoad * 100).toFixed(0);
	                    var barColor = rate >= 100 ? "#f44336" : (rate >= 80 ? "#ff9800" : "#4CAF50");
	                    
	                    html += "<tr>";
	                    html += "  <td>" + (user.deptNm || '-') + "</td>";
	                    html += "  <td>" + (user.positionNm || '-') + "</td>";
	                    html += "  <td>";
	                    html += "    <strong>" + user.userNm + "</strong><br>";
	                    html += "    <div style='width:80px; background:#eee; height:10px; border-radius:10px; overflow:hidden; display:inline-block; vertical-align:middle; margin-right:5px;'>";
	                    html += "      <div style='width:" + (rate > 100 ? 100 : rate) + "%; background:" + barColor + "; height:100%;'></div>";
	                    html += "    </div>";
	                    html += "    <span style='color:" + barColor + "; font-size:11px; font-weight:bold;'>" + rate + "%</span>";
	                    html += "  </td>";
	                    html += "  <td style='text-align:center;'>";
	                    html += "    <button type='button' class='btn_s' onclick=\"fn_select_this_user('" + user.userId + "', '" + user.userNm + "')\">선택</button>";
	                    html += "  </td>";
	                    html += "</tr>";
	                });
	            } else {
	                html = "<tr><td colspan='4' style='text-align:center;'>검색 결과가 없습니다.</td></tr>";
	            }
	            $("#userSearchResultBody").html(html);
	        }
	    });
	}
	
	function fn_open_user_search() {
	    $('#popSearchNm').val('');
	    $('#userSearchResultBody').html('<tr><td colspan="4" style="text-align:center;">검색어를 입력하세요.</td></tr>');
	    $('#userSearchModal').show();
	    $('#popSearchNm').focus();
	}
	
	function fn_select_this_user(userId, userNm) {
		if($("#user_row_" + userId).length > 0) {
	        alert("이미 목록에 추가된 인원입니다.");
	        return;
	    }

	    var html = "<tr id='user_row_" + userId + "'>";
	    html += "  <td>" + userNm + "<input type='hidden' class='selectedUserId' value='" + userId + "'></td>";
	    html += "  <td><input type='number' class='selectedInputRate' step='0.1' min='0.1' max='1.0' value='1.0' style='width:60px;' onchange='fn_calculate_total_mm()' onkeyup='fn_calculate_total_mm()'> MM</td>";
	    html += "  <td><button type='button' onclick=\"$(this).closest('tr').remove(); fn_calculate_total_mm();\">X</button></td>";
	    html += "</tr>";

	    $("#selectedUserListBody").append(html);
	    $('#userSearchModal').hide();
	    
	    fn_calculate_total_mm();
	}
	
	
	function fn_save_task_group() {
	    if(!$("#assignTitle").val()) { alert("프로젝트명을 입력하세요."); return; }
	    if(!$("#assignStartDate").val() || !$("#assignEndDate").val()) { alert("기간을 입력하세요."); return; }
	    if($("#selectedUserListBody tr").length === 0) { alert("투입 인원을 최소 1명 이상 선택하세요."); return; }

	    var assignList = [];
	    $("#selectedUserListBody tr").each(function() {
	        assignList.push({
	            userId: $(this).find(".selectedUserId").val(),
	            inputRate: $(this).find(".selectedInputRate").val()
	        });
	    });

	    var sendData = {
	        projId: "${projectVO.projId}",
	        assignTitle: $("#assignTitle").val(),
	        startDate: $("#assignStartDate").val(),
	        endDate: $("#assignEndDate").val(),
	        taskGroupId: $("#taskGroupId").val(),
	        assignList: assignList
	    };

	    $.ajax({
	        url: "<c:url value='/pms/saveProjectTaskGroupAjax.do'/>",
	        type: "POST",
	        contentType: "application/json; charset=UTF-8",
	        data: JSON.stringify(sendData),
	        success: function(data) {
	            if(data.status === "SUCCESS") {
	                alert("성공적으로 저장되었습니다.");
	                $('#assignModal').hide();
	                location.reload();
	            } else {
	                alert("오류 발생: " + data.message);
	            }
	        }
	    });
	}
	
	function fn_edit_task_group(taskGroupId) {
	    $.ajax({
	        url: "<c:url value='/pms/selectTaskGroupDetailAjax.do'/>",
	        data: { "taskGroupId": taskGroupId },
	        success: function(data) {
	            $("#taskGroupId").val(taskGroupId);
	            $("#assignTitle").val(data.info.assignTitle);
	            $("#assignStartDate").val(data.info.startDate);
	            $("#assignEndDate").val(data.info.endDate);
	            
	            $("#selectedUserListBody").empty();
	            $.each(data.memberList, function(idx, mem) {
	                var html = "<tr id='user_row_" + mem.userId + "'>";
	                html += "  <td>" + mem.userNm + "<input type='hidden' class='selectedUserId' value='" + mem.userId + "'></td>";
	                html += "  <td><input type='number' class='selectedInputRate' step='0.1' value='" + mem.inputRate + "' style='width:60px;'> MM</td>";
	                html += "  <td><button type='button' onclick=\"$(this).closest('tr').remove();\">X</button></td>";
	                html += "</tr>";
	                $("#selectedUserListBody").append(html);
	            });
	            fn_calculate_total_mm();
	            $('#assignModal').show();
	        }
	    });
	}
	
	function fn_delete_task_group(taskGroupId) {
	    if(!confirm("해당 업무와 투입 인원 전체를 삭제하시겠습니까?")) return;
	    
	    $.ajax({
	        url: "<c:url value='/pms/deleteProjectTaskGroupAjax.do'/>",
	        type: "POST",
	        data: { taskGroupId: taskGroupId },
	        success: function(data) {
	            alert("삭제되었습니다.");
	            fn_load_assign_list();
	        }
	    });
	}
	
	function fn_calculate_total_mm() {
	    var total = 0;
	    $(".selectedInputRate").each(function() {
	        var val = parseFloat($(this).val());
	        if (!isNaN(val)) {
	            total += val;
	        }
	    });

	    var formattedTotal = total.toFixed(1);
	    $("#totalInputRateDisplay").text(formattedTotal);
	    $("#totalInputRate").val(formattedTotal);
	    
	    if (total > 1.0) {
	        $("#totalInputRateDisplay").css("color", "#f44336");
	    } else {
	        $("#totalInputRateDisplay").css("color", "#2196F3");
	    }
	}
	
	function fn_load_assign_list() {
	    $.ajax({
	        url: "<c:url value='/pms/selectProjectAssignListAjax.do'/>",
	        type: "GET",
	        data: { projId: "${projectVO.projId}" },
	        dataType: "json",
	        success: function(data) {
	        	var html = "";
	            var totalActualEffort = 0;
	            var totalPlanEffort = 0;
	            
	            var targetStr = "${projectVO.estEffort}".replace(/[^0-9.]/g, ""); 
	            var target = parseFloat(targetStr) || 0;
	            
	            if(data.list && data.list.length > 0) {
	                $.each(data.list, function(idx, item) {
	                    var fullValue = parseFloat(item.inputRate || 0);
	                    totalPlanEffort += fullValue;
	                    var isConfirmed = (item.confirmYn && item.confirmYn.trim().toUpperCase() === 'Y');
	                    if (item.confirmYn === 'Y') {
	                        totalActualEffort += fullValue;
	                    }

	                    html += "<tr>";
	                    html += "  <td>" + item.userNm + "</td>";
	                    html += "  <td>" + item.assignTitle + "</td>";
	                    html += "  <td>" + item.startDate + " ~ " + item.endDate + "</td>";
	                    html += "  <td><strong>" + fullValue.toFixed(1) + " MM</strong></td>";
	                    
	                    html += "  <td style='text-align:center;'>";
	                    
	                    if (item.confirmYn === 'Y') {
	                        html += "  <span class='badge-green'>완료</span>";
	                        html += "  <button type='button' class='btn_s' onclick=\"fn_toggle_confirm('" + item.taskGroupId + "', 'N')\">취소</button>";
	                    } else {
	                        html += "  <button type='button' class='btn_blue' onclick=\"fn_toggle_confirm('" + item.taskGroupId + "', 'Y')\">확인</button>";
	                    }
	                    
	                    html += "</td>";
	                    
	                    html += "  <td>";
	                    html += "    <button type='button' class='btn_s' onclick=\"fn_edit_task_group('" + item.taskGroupId + "')\">수정</button>";
	                    html += "    <button type='button' class='btn_red' onclick=\"fn_delete_task_group('" + item.taskGroupId + "')\">삭제</button>";
	                    html += "  </td>";
	                    html += "</tr>";
	                });
	            } else {
	                html = "<tr><td colspan='6'>배정된 인력이 없습니다.</td></tr>";
	            }
	            
	            $("#assignListBody").html(html);
	            
	            var actualPercent = target > 0 ? ((totalActualEffort / target) * 100).toFixed(1) : 0;
	            var planPercent = target > 0 ? ((totalPlanEffort / target) * 100).toFixed(1) : 0;
	            
	            $("#mainProgressBar").css("width", (actualPercent > 100 ? 100 : actualPercent) + "%");
	            $("#planProgressBar").css("width", (planPercent > 100 ? 100 : planPercent) + "%");
	            $("#mainProgressText").text(actualPercent + "%");
	            
	            $("#currentTotalEffort").text(totalActualEffort.toFixed(1));
	            $("#planTotalEffort").text(totalPlanEffort.toFixed(1));
	            
	            if(parseFloat(planPercent) > 100) {
	                $("#planProgressBar").css("background", "rgba(244, 67, 54, 0.5)");
	            } else {
	                $("#planProgressBar").css("background", "rgba(76, 175, 80, 0.3)");
	            }
	            
	            if(calendar) {calendar.refetchEvents();}
	        }
	    });
	}

	var calendar = null;

    $(document).ready(function() {
        fn_load_assign_list();

        var calendarEl = document.getElementById('calendar');
        calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            locale: 'ko',
            height: 500,
            displayEventTime: false,
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: 'dayGridMonth'
            },
            events: function(info, successCallback, failureCallback) {
                $.ajax({
                    url: "<c:url value='/pms/selectProjectAssignListAjax.do'/>",
                    type: "GET",
                    data: { projId: "${projectVO.projId}" },
                    dataType: "json",
                    success: function(data) {
                        var events = [];
                        if(data.list) {
                            $.each(data.list, function(idx, item) {
                                events.push({
                                    id: item.assignId,
                                    title: item.assignTitle + " [" + item.userNm + "]",
                                    start: item.startDate,
                                    end: item.endDate + "T23:59:59", 
                                    color: (item.inputRate >= 1.0 ? '#f44336' : '#3788d8')
                                });
                            });
                        }
                        successCallback(events);
                    }
                });
            }
        });
        
        calendar.render();
    });
	
    function fn_delete_task_group(taskGroupId) {
        if(!confirm("해당 업무와 투입 인원 전체를 삭제하시겠습니까?")) return;
        
        $.ajax({
            url: "<c:url value='/pms/deleteProjectTaskGroupAjax.do'/>", 
            type: "POST",
            data: { "taskGroupId": taskGroupId },
            success: function(data) {
                alert("삭제되었습니다.");
                fn_load_assign_list();
            }
        });
    }
    
	function fn_delete_assign(assignId) {
	    if(!confirm("정말 삭제하시겠습니까?")) return;
	    
	    $.ajax({
	        url: "<c:url value='/pms/deleteProjectAssignAjax.do'/>",
	        type: "POST",
	        data: { assignId: assignId },
	        success: function(data) {
	            alert("삭제되었습니다.");
	            fn_load_assign_list();
	        }
	    });
	}
	
	function fn_egov_user_callback(userId, userNm) {
	    $("#assignUserId").val(userId);
	    $("#assignUserNm").val(userNm);
	}
	
	function fn_toggle_confirm(tGroupId, status) {
	    var msg = status === 'Y' ? "해당 인력의 업무 완료를 확인하시겠습니까?" : "확인을 취소하시겠습니까?";
	    if(!confirm(msg)) return;

	    $.ajax({
	        url: "<c:url value='/pms/updateAssignConfirmAjax.do'/>",
	        type: "POST",
	        data: { "taskGroupId": tGroupId, "confirmYn": status },
	        success: function(data) {
	            fn_load_assign_list();
	        }
	    });
	}
	
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


	    var updateUrl = "<c:url value='/pms/updateProjectView.do'/>?selectedId=" + id;

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
	    formData.append("projId", "${projectVO.projId}");
	    formData.append("atchFileId", "${projectVO.atchFileId}");

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