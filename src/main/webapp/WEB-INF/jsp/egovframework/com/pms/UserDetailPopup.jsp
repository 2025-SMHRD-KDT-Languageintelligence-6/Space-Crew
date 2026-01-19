<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html>
<head>
    <title>직원 상세 정보</title>
    <link rel="stylesheet" href="<c:url value='/css/egovframework/com/com.css'/>">
    <style>
        body { padding: 20px; font-family: 'Malgun Gothic'; }
        .popup-header { border-bottom: 2px solid #333; padding-bottom: 10px; margin-bottom: 20px; }
        .btn-close { margin-top: 20px; text-align: center; }
    </style>
</head>
<body>
    <div class="popup-header">
        <h2>📂 직원 정보 : ${userVO.userId}</h2>
    </div>

    <table class="w3-table-all">
        <colgroup>
            <col style="width:30%;">
            <col style="width:70%;">
        </colgroup>
        <tr>
            <th>이름</th>
            <td>${userVO.userNm}</td>
        </tr>
        <tr>
            <th>부서</th>
            <td>${userVO.deptNm}</td>
        </tr>
        <tr>
            <th>직무</th>
            <td>${userVO.jobRole}</td>
        </tr>
        <tr>
            <th>직급</th>
            <td>${userVO.positionNm}</td>
        </tr>
        <tr>
            <th>경력연수</th>
            <td>${userVO.careerYears}</td>
        </tr>
        <tr>
            <th>전문분야</th>
            <td>${userVO.jobField}</td>
        </tr>
        <tr>
            <th>업무부하량</th>
            <td>${userVO.currentLoad}</td>
        </tr>
        <tr>
            <th>입사일</th>
            <td>${userVO.joinDt}</td>
        </tr>
        <tr>
            <th>재직</th>
            <td>${userVO.useYn}</td>
        </tr>
        <tr>
            <th>보유스택</th>
            <td>${userVO.techDesc}</td>
        </tr>
        </table>
	
    <div class="btn-close">
        <button type="button" onclick="window.close();" class="btn_s">닫기</button>
    </div>

	<div class="calendar-section" style="margin-top:30px; padding:15px; background:#f9f9f9; border-radius:8px;">
	    <h4 style="margin-bottom:15px;"><i class="fa fa-calendar"></i> 개인별 프로젝트 투입 일정</h4>
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
		                    var events = data.list.map(function(item) {
		                        var colorList = ['#3498db', '#1abc9c', '#9b59b6', '#f1c40f', '#e67e22', '#34495e', '#27ae60'];
		                        var colorIdx = item.assignId % colorList.length;
		                        var eventColor = colorList[colorIdx];
		                        var borderCol = (item.inputRate >= 1.0) ? '#ff0000' : eventColor;

		                        return {
		                            title: "[" + item.projNm + "] " + item.title + " (" + (item.inputRate * 100) + "%)",
		                            start: item.startDate,
		                            end: item.endDate + "T23:59:59",
		                            color: eventColor,
		                            borderColor: borderCol,
		                            borderWidth: (item.inputRate >= 1.0) ? '3px' : '1px',
		                            extendedProps: {
		                                assignId: item.assignId
		                            }
		                        };
		                    });
		                    successCallback(events);
		                }
		            });
		        }
		    });
		    
		    userCalendar.render();
		});
	</script>
</body>
</html>