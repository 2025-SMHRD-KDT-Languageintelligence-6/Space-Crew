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
    </style>
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
            <td></td>
        </tr>
        <tr>
            <th>난이도</th>
            <td>${projectVO.complexityScore}</td>
        </tr>
        <tr>
            <th>요구 기술 사항</th>
            <td>${projectVO.reqSkills}</td>
        </tr>
        </table>
    <div id='calendar-container' style="margin-top:30px; border:1px solid #ddd; padding:10px; background:#fff;">
	    <div id='calendar'></div>
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
	    <table style="width:100%;">
	        <tr>
	            <th>성명</th>
	            <td>
	                <input type="text" id="assignUserNm" readonly style="width:100px;">
	                <input type="hidden" id="assignUserId"> <button type="button" onclick="fn_open_user_search();">찾기</button>
	            </td>
	        </tr>
	        <tr>
	            <th>업무명</th>
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
	            <td><input type="number" id="assignInputRate" step="0.1" min="0.1" max="1.0" value="1.0"> M/M</td>
	        </tr>
	    </table>
	    
	    <div style="text-align:right; margin-top:15px;">
	        <button type="button" class="btn_s" onclick="fn_save_assign();">저장</button>
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
    <div class="btn-close">
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
            projectId: "${projectVO.projId}",
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
	    $("#assignUserId").val(userId);
	    $("#assignUserNm").val(userNm);
	    $('#userSearchModal').hide();
	}
	
	function fn_load_assign_list() {
	    $.ajax({
	        url: "<c:url value='/pms/selectProjectAssignListAjax.do'/>",
	        type: "GET",
	        data: { projectId: "${projectVO.projId}" },
	        dataType: "json",
	        success: function(data) {
	            var html = "";
	            if(data.list && data.list.length > 0) {
	                $.each(data.list, function(idx, item) {
	                    html += "<tr>";
	                    html += "  <td>" + item.userNm + "</td>";
	                    html += "  <td>" + item.assignTitle + "</td>";
	                    html += "  <td>" + item.startDate + " ~ " + item.endDate + "</td>";
	                    html += "  <td>" + item.inputRate + "</td>";
	                    html += "  <td><button type='button' class='btn_red' onclick='fn_delete_assign(" + item.assignId + ")'>삭제</button></td>";
	                    html += "</tr>";
	                });
	            } else {
	                html = "<tr><td colspan='5'>배정된 인력이 없습니다.</td></tr>";
	            }
	            $("#assignListBody").html(html);
	            if(calendar) {
	                calendar.refetchEvents();
	            }
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
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: 'dayGridMonth'
            },
            events: function(info, successCallback, failureCallback) {
                $.ajax({
                    url: "<c:url value='/pms/selectProjectAssignListAjax.do'/>",
                    type: "GET",
                    data: { projectId: "${projectVO.projId}" },
                    dataType: "json",
                    success: function(data) {
                        var events = [];
                        if(data.list) {
                            $.each(data.list, function(idx, item) {
                                events.push({
                                    id: item.assignId,
                                    title: item.userNm + " (" + (item.inputRate * 100).toFixed(0) + "%)",
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
	
	
	</script>
</body>
</html>