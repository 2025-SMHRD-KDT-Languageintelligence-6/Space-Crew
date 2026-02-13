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

	.req-item { background: #f9f9f9; padding: 15px; border: 1px solid #ddd; margin-bottom: 10px; border-radius: 4px; position: relative; }
    .req-header { display: flex; justify-content: space-between; margin-bottom: 8px; font-size: 13px; color: #555; font-weight: bold; }
    .slider-container { padding: 20px; background: #f1f3f5; border-radius: 8px; text-align: center; margin-bottom: 20px; border: 1px solid #e9ecef; }
    input[type=range] { width: 90%; margin: 15px 0; cursor: pointer; }
    .range-labels { display: flex; justify-content: space-between; font-size: 12px; color: #666; padding: 0 10px; }
    .score-txt { font-weight: bold; color: #2196F3; font-size: 1.1em; }
    .badge-ai { background-color: #673AB7; color: white; padding: 4px 8px; border-radius: 12px; font-size: 12px; font-weight: normal; }
	.btn_s_blue { background: #5998eb !important; color: white !important; border: none !important; }
	.btn_s_red  { background: #f7928b !important; color: white !important; border: none !important; }
	.btn_s_gray { background: #666666 !important; color: white !important; border: none !important; }
	.btn_s_purple { background: #673AB7 !important; color: white !important; border: none !important; }
	.tab-container { display: flex; gap: 5px; margin-bottom: -2px; border-bottom: 1px solid #ddd; }
	.tab-btn { 
	    padding: 12px 25px; cursor: pointer; background: #f8f9fa; border: 1px solid #ddd; 
	    border-radius: 8px 8px 0 0; font-weight: bold; color: #666; transition: all 0.3s;
	}
	.tab-btn.active { 
	    background: #fff; border-bottom: 2px solid #fff; color: #2196F3; 
	    border-top: 3px solid #2196F3; box-shadow: 0 -2px 5px rgba(0,0,0,0.05);
	}
	.tab-content { display: none; padding: 20px; background: #fff; border: 1px solid #ddd; border-top: none; border-radius: 0 0 8px 8px; }
	.tab-content.active { display: block; }
    
    @keyframes highlightFade {
	    from { background-color: #fff9c4; }
	    to { background-color: transparent; }
	}
	.new-row-highlight {
	    animation: highlightFade 3s ease-in-out forwards;
	}
    .file-popover {
    display: none; position: absolute; background: white; border: 1px solid #ccc;
    box-shadow: 0 4px 10px rgba(0,0,0,0.2); border-radius: 8px; padding: 10px;
    z-index: 9999; min-width: 200px;
	}
	.file-popover-close { float: right; cursor: pointer; color: #999; font-weight: bold; }
	    
    </style>
    <script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js'/>"></script>

	<script type="text/javascript">
	function fn_egov_downFile(atchFileId, fileSn) {
	    var downUrl = "<c:url value='/cmm/fms/FileDown.do'/>?atchFileId=" + atchFileId + "&fileSn=" + fileSn;
	    
	    var $iframe = $("#hiddenDownFrame");
	    if ($iframe.length === 0) {
	        $iframe = $("<iframe id='hiddenDownFrame' style='display:none;'></iframe>").appendTo("body");
	    }
	    
	    $iframe.attr("src", downUrl);
	}

	    function fn_egov_deleteFile(atchFileId, fileSn) {
	        if(confirm("삭제하시겠습니까?")) {
	        }
	    }
	</script>
</head>
<body>
    <div class="popup-header">
        <h2>📂 프로젝트명 : ${projectVO.projNm}</h2>
    </div>
	
	<div class="tab-container">
	    <div class="tab-btn active" onclick="fn_change_tab(0)">기본정보</div>
	    <div class="tab-btn" onclick="fn_change_tab(1)">세부 업무 목록</div>
	    <div class="tab-btn" onclick="fn_change_tab(2)">프로젝트 일정</div>
	</div>
	
	<div id="tab0" class="tab-content active">
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
		    <th>계약명</th>
		    <td>
		        ${projectVO.contNm} <br>
		        <span style="font-size:12px; color:#666;">(계약기간: ${projectVO.contStartDt} ~ ${projectVO.contEndDt})</span>
		    </td>
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
            <th>프로젝트 참여자</th>
            <td style="font-size: 0.95em; color: #555;">
		        <c:choose>
		            <c:when test="${not empty projectVO.participantNames}">
		                ${projectVO.participantNames}
		            </c:when>
		            <c:otherwise>
		                <span style="color: #ccc;">현재 배정된 인원이 없습니다.</span>
		            </c:otherwise>
		        </c:choose>
		    </td>
        </tr>
        	<th>기간경과율</th>
        	<td>
		        <div style="width:100%; background:#eee; height:24px; border-radius:12px; overflow:hidden; position:relative;">
		            <div id="elapsedProgressBar"
		                 style="width: <c:out value='${projectVO.progressRate}'/>%;
		                        background:#2196F3; height:100%; position:absolute; top:0; left:0; transition:width 0.5s; z-index:2;">
		            </div>

		            <span id="elapsedProgressText"
		                  style="position:absolute; width:100%; text-align:center; top:0; line-height:24px; font-size:12px; font-weight:bold; color:#000; z-index:3;">
		                <c:out value="${projectVO.progressRate}"/>%
		            </span>
		        </div>
		        <div style="margin-top:5px; font-size:11px; color:#666; display:flex; justify-content:space-between;">
		            <span>시작: ${projectVO.startDt}</span>
		            <span>종료: ${projectVO.endDt}</span>
		        </div>
		    </td>
	    </tr>
        <tr>
            <th>업무진행률</th>
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
        	<th>특이사항</th>
        	<td>${projectVO.projRemark}</td>
        </tr>
       	</table>

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
	        <c:param name="param_atchFileId" value="${projectVO.atchFileId}" />
	        <c:param name="atchFileId" value="${projectVO.atchFileId}" />
	    </c:import>
	</div>
	</div>

	<div id="tab1" class="tab-content">
	<div class="assign-section" style="margin-top:30px;">
	    <h3>세부 업무 목록</h3>
	    <div class="search-bar" style="background:#f8f9fa; padding:15px; margin-bottom:15px; border-radius:8px; border:1px solid #ddd; display:flex; gap:10px;">
		    <input type="text" id="searchUserNm" placeholder="성명" style="width:100px;">
		    <input type="text" id="searchAssignTitle" placeholder="업무 내용" style="flex-grow:1;">
		    <select id="searchConfirmYn" style="width:100px;">
		        <option value="">전체상태</option>
		        <option value="N">진행</option>
		        <option value="R">확인필요</option>
		        <option value="Y">완료</option>
		    </select>
		    <button type="button" class="btn_s_blue" onclick="fn_load_assign_list();">검색</button>
		</div>
	    <table class="table" id="assignTable">
	        <thead>
	            <tr>
	                <th>성명</th>
	                <th>업무</th>
	                <th>투입기간</th>
	                <th>투입률(M/M)</th>
	                <th>상태</th>
	                <th>첨부</th>
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
	            <th>세부 업무명</th>
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
	        <tr>
			    <th>진행 상태</th>
			    <td>
			        <select id="assignConfirmYn" style="width:100%; height:28px;">
			            <option value="N">🔵 진행 (Work in Progress)</option>
			            <option value="R">🟣 확인필요 (Review Required)</option>
			            <option value="Y">⚪ 완료 (Completed)</option>
			        </select>
			    </td>
			</tr>
	        <tr>
	            <th>요구 기술<br>및 상세내용</th>
	            <td>
	                <textarea id="assignReqSkills" rows="3" 
	                          style="width:100%; border:1px solid #ccc; padding:5px; resize:vertical; font-size:12px;" 
	                          placeholder="AI 추천을 위해 필요한 기술 스택을 입력하세요 (예: Java, React, Python)"></textarea>
	            </td>
	        </tr>
	        <tr>
			    <th>메모</th>
			    <td>
			        <textarea id="assignRemark" rows="3" 
			                  style="width:100%; border:1px solid #ccc; padding:5px; resize:vertical; font-size:12px;" 
			                  placeholder="메모를 입력하세요"></textarea>
			    </td>
			</tr>
			<tr>
			    <th>첨부파일</th>
			    <td>
			        <input type="file" id="assignFile" name="assignFile" style="width:70%;">
			        <div id="fileListArea" style="font-size:12px; color:#666; margin-top:5px;">
			            <c:if test="${not empty assignVO.atchFileId}">
			                <span>등록된 파일 있음</span>
			            </c:if>
			        </div>
			        <input type="hidden" id="assignAtchFileId" name="assignAtchFileId" value="${assignVO.atchFileId}">
			    </td>
			</tr>
	    </table>
	    <div style="margin-top:20px; border-top:1px solid #ddd; padding-top:10px;">
	        <div style="display:flex; justify-content:space-between; align-items:center;">
	            <strong>투입 인원 목록</strong>
	            <button type="button" class="btn_s" onclick="fn_open_user_search();">인원 추가</button>
	            <button type="button" class="btn_s" style="background:#673AB7; color:white;" onclick="fn_open_ai_popup_integrated();">🤖 AI 추천</button>
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
	        <button type="button" class="btn_s" onclick="fn_save_task_with_file();">저장</button>
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
	</div>


	<div id="tab2" class="tab-content">
	<div id='calendar-container' style="margin-top:30px; border:1px solid #ddd; padding:10px; background:#fff;">
	    <div id='calendar'></div>
	</div>
	</div>

    <div class="btn-close">
    	<button type="button" onclick="fn_go_update_page('${projectVO.projId}');" class="btn_s_blue">수정</button>
        <button type="button" onclick="window.close();" class="btn_s_gray">닫기</button>
    </div>

    <div id="aiMatchModal" style="display:none; position:fixed; top:50%; left:50%; transform:translate(-50%, -50%); width:850px; background:#fff; border:2px solid #333; padding:25px; z-index:9999; box-shadow: 0 0 20px rgba(0,0,0,0.5); max-height:90vh; overflow-y:auto; border-radius: 8px;">
            <div style="display:flex; justify-content:space-between; margin-bottom:20px; border-bottom:1px solid #eee; padding-bottom:10px;">
                <h3 style="margin:0; font-size:18px;">🤖 AI 인력 추천 결과</h3>
                <button type="button" 
				        onclick="$('#aiMatchModal').hide();" 
				        style="border:none; background:none; font-size:28px; cursor:pointer; color:#333; font-weight:bold; line-height:1;"
				        onmouseover="this.style.color='#f44336';" 
				        onmouseout="this.style.color='#333';">
				    &times;
				</button>
            </div>

            <input type="hidden" id="currentReqId"> <div class="slider-container">
                <label style="font-size:14px;"><strong>⚖️ 가중치 설정 (AI 매칭률 : 경력 점수)</strong></label>
                <input type="range" id="weightSlider" min="10" max="90" step="20" value="70" oninput="fn_update_slider_ui(this.value)" onchange="fn_run_ai_match()">
                <div class="range-labels">
                    <span>10:90 (경력중시)</span>
                    <span>30:70</span>
                    <span>50:50</span>
                    <span>70:30</span>
                    <span>90:10 (매칭중시)</span>
                </div>
                <p style="margin-top:15px; font-size:14px; margin-bottom:0;">
                    현재 설정 👉 매칭률 <span id="val-ai" class="score-txt">70</span>% : 경력 <span id="val-career" class="score-txt">30</span>%
                </p>
            </div>

            <table class="w3-table-all" style="font-size:13px; text-align:center;">
                <colgroup>
                    <col style="width:8%;">
                    <col style="width:25%;">
                    <col style="width:10%;">
                    <col style="width:10%;">
                    <col style="width:10%;">
                    <col style="width:10%;">
                    <col style="width:12%;">
                </colgroup>
                <thead>
                    <tr style="background:#f1f3f5;">
                        <th>순위</th>
                        <th>직원명 (연차)</th>
                        <th>가동률</th>
                        <th>매칭률</th>
                        <th>경력점수</th>
                        <th>종합점수</th>
                        <th>선택</th>
                    </tr>
                </thead>
                <tbody id="aiResultBody">
                    <tr><td colspan="7" style="padding:20px;">데이터를 불러오는 중...</td></tr>
                </tbody>
            </table>
            <div style="text-align:center; margin-top:25px; border-top:1px solid #eee; padding-top:15px;">
                <button type="button" 
                        onclick="$('#aiMatchModal').hide();" 
                        class="btn_s_gray" 
                        style="width:120px; height:35px; font-weight:bold; cursor:pointer;">
                    창 닫기
                </button>
            </div>
        </div>
		
		<div id="filePopover" class="file-popover">
		    <span class="file-popover-close" onclick="$('#filePopover').hide();">&times;</span>
		    <div id="popoverContent" style="margin-top:15px; font-size:12px;"></div>
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
	    $("#assignStartDate").val("");
	    $("#assignEndDate").val("");
	    $("#assignReqSkills").val("");
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
	                    //html += "    <button type='button' class='btn_s' onclick=\"fn_select_this_user('" + user.empId + "', '" + user.userNm + "')\">선택</button>";
	                    var targetId = user.empId || user.userId;
	                    html += " <button type='button' class='btn_s' onclick=\"fn_select_this_user('" + targetId + "', '" + user.userNm + "')\">선택</button>";
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
	    html += "  <td><input type='number' class='selectedInputRate' step='0.1' min='0.1' max='1.0' value='1.0' " +
	    		"      style='width:60px;' " +
	    		"      oninput=\"if(this.value < 0) this.value = Math.abs(this.value); if(this.value == '0') this.value = '0.1';\" " +
        		"      onchange='fn_calculate_total_mm()' onkeyup='fn_calculate_total_mm()'> MM</td>";
	    html += "  <td><button type='button' onclick=\"$(this).closest('tr').remove(); fn_calculate_total_mm();\">X</button></td>";
	    html += "</tr>";

	    $("#selectedUserListBody").append(html);
	    $('#userSearchModal').hide();

	    fn_calculate_total_mm();
	}


	function fn_save_task_group() {
		var targetGroupId = $("#taskGroupId").val();
		var startDate = $("#assignStartDate").val();
	    var endDate = $("#assignEndDate").val();
		
	    if(!$("#assignTitle").val()) { alert("프로젝트명을 입력하세요."); return; }
	    if(!startDate || !endDate) { alert("기간을 입력하세요."); return; }
	    
	    if(startDate > endDate) {
	        alert("종료일은 시작일보다 빠를 수 없습니다.");
	        $("#assignEndDate").focus();
	        return;
	    }
	    
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
	        startDt: $("#assignStartDate").val(),
	        endDt: $("#assignEndDate").val(),
	        taskGroupId: $("#taskGroupId").val(),
	        reqSkills: $("#assignReqSkills").val(),
	        confirmYn: $("#assignConfirmYn").val(),
	        assignRemark: $("#assignRemark").val(),
	        atchFileId: $("#assignAtchFileId").val(),
	        assignList: assignList
	    };

	    $.ajax({
	        url: "<c:url value='/pms/saveProjectTaskGroupAjax.do'/>",
	        type: "POST",
	        contentType: "application/json; charset=UTF-8",
	        data: JSON.stringify(sendData),
	        success: function(data) {
	            if(data.status === "SUCCESS") {
	            	if(targetGroupId) {
	                    sessionStorage.setItem("lastSavedGroupId", targetGroupId);
	                }
	            	alert("성공적으로 저장되었습니다.");
	                $('#assignModal').hide();
	                var currentUrl = location.href.split('#')[0];
	                location.href = currentUrl + "#tab1";
	                location.reload();
	            } else {
	                alert("오류 발생: " + data.message);
	            }
	        }
	    });
	}
	
	var currentConfirmYn = 'N';
	
	function fn_edit_task_group(taskGroupId) {
	    $.ajax({
	        url: "<c:url value='/pms/selectTaskGroupDetailAjax.do'/>",
	        data: { "taskGroupId": taskGroupId },
	        success: function(data) {
	            $("#taskGroupId").val(taskGroupId);
	            $("#assignTitle").val(data.info.assignTitle);
	            $("#assignStartDate").val(data.info.startDt);
	            $("#assignEndDate").val(data.info.endDt);
	            $("#assignReqSkills").val(data.info.reqSkills || "");
	            $("#assignConfirmYn").val(data.info.confirmYn || 'N');
	            $("#assignRemark").val(data.info.assignRemark || "");
	            var fileId = data.info.atchFileId;
	            $("#assignAtchFileId").val(fileId || "");
	            
	            if(fileId) {
	                fn_load_task_files(fileId);
	            } else {
	                $("#fileListArea").html("<span style='color:#ccc;'>첨부된 파일 없음</span>");
	            }
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
	    
		var searchUserNm = $("#searchUserNm").val();
	    var searchAssignTitle = $("#searchAssignTitle").val();
	    var searchConfirmYn = $("#searchConfirmYn").val();
		
		$.ajax({
	        url: "<c:url value='/pms/selectProjectAssignListAjax.do'/>",
	        type: "GET",
	        data: { 
	            projId: "${projectVO.projId}",
	            searchUserNm: $("#searchUserNm").val(),
	            searchAssignTitle: $("#searchAssignTitle").val(),
	            searchConfirmYn: $("#searchConfirmYn").val()
	        },
	        dataType: "json",
	        success: function(data) {
	        	var html = "";
	        	var highlightId = sessionStorage.getItem("lastSavedGroupId");
	        	
	            var totalActualEffort = 0;
	            var totalPlanEffort = 0;

	            var targetStr = "${projectVO.estEffort}".replace(/[^0-9.]/g, "");
	            var target = parseFloat(targetStr) || 0;

	            if(data.list && data.list.length > 0) {
	                $.each(data.list, function(idx, item) {
	                	var highlightClass = (item.taskGroupId === highlightId) ? "class='new-row-highlight'" : "";
	                    var fullValue = parseFloat(item.inputRate || 0);
	                    totalPlanEffort += fullValue;
	                    var isConfirmed = (item.confirmYn && item.confirmYn.trim().toUpperCase() === 'Y');
	                    if (item.confirmYn === 'Y') {
	                        totalActualEffort += fullValue;
	                    }
	                    var fileHtml = "";
	                    if(item.atchFileId) {
	                    	fileHtml = " <span onclick=\"fn_open_file_popover(event, '" + item.atchFileId + "')\" " +
	                        "       style='cursor:pointer; color:#2196F3; font-weight:bold;'>📎</span>";
	    	        	}
	                    html += "<tr " + highlightClass + ">";
	                    html += "  <td>" + item.userNm + "</td>";
	                    html += "  <td>" + item.assignTitle + "</td>";
	                    html += "  <td>" + item.startDt + " ~ " + item.endDt + "</td>";
	                    html += "  <td><strong>" + fullValue.toFixed(1) + " MM</strong></td>";
	                    html += "  <td style='text-align:center;'>";
	                    html += "    <select class='status-select' onchange=\"fn_change_status_ajax('" + item.taskGroupId + "', this.value)\" style='padding:2px; border-radius:4px; font-weight:bold; " + fn_get_status_style(item.confirmYn) + "'>";
	                    html += "      <option value='N' " + (item.confirmYn === 'N' ? 'selected' : '') + ">진행</option>";
	                    html += "      <option value='R' " + (item.confirmYn === 'R' ? 'selected' : '') + ">확인필요</option>";
	                    html += "      <option value='Y' " + (item.confirmYn === 'Y' ? 'selected' : '') + ">완료</option>";
	                    html += "    </select>";
	                    html += "</td>";
	                    html += "  <td style='text-align:center;'>" + fileHtml + "</td>";
	                    html += "  <td>";
	                    html += "    <button type='button' class='btn_blue' onclick=\"fn_edit_task_group('" + item.taskGroupId + "')\">수정</button>";
	                    html += "    <button type='button' class='btn_s_red' onclick=\"fn_delete_task_group('" + item.taskGroupId + "')\">삭제</button>";
	                    html += "  </td>";
	                    html += "</tr>";
	                });
	                if(highlightId) sessionStorage.removeItem("lastSavedGroupId");
	            } else {
	                html = "<tr><td colspan='7'>배정된 인력이 없습니다.</td></tr>";
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
	
	function fn_open_file_popover(e, atchFileId) {
	    if(!atchFileId) return;
	    if (e.stopPropagation) e.stopPropagation();

	    var rect = e.target.getBoundingClientRect();
	    $("#filePopover").css({
	        top: (window.pageYOffset + rect.bottom + 5) + "px",
	        left: (window.pageXOffset + rect.left - 100) + "px"
	    }).show();

	    $("#popoverContent").html("파일을 확인 중입니다");

	    $.ajax({
	        url: "<c:url value='/cmm/fms/selectFileInfs.do'/>",
	        data: { "param_atchFileId": atchFileId },
	        dataType: "html", 
	        success: function(html) {
	            $("#popoverContent").html(html);
	        },
	        error: function() {
	            $("#popoverContent").html("파일 목록을 불러오지 못했습니다.");
	        }
	    });
	}

	var calendar = null;

    $(document).ready(function() {
    // [Step 4-1] 초기 요구사항 로드
            /* var initialSkill = "${fn:escapeXml(projectVO.reqSkills)}";
            if(initialSkill && initialSkill.trim().length > 0) {
                fn_add_req_row(initialSkill);
            } else {
                fn_add_req_row(""); // 없으면 빈 칸 1개 생성
            } */
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
                                    start: item.startDt,
                                    end: item.endDt + "T23:59:59",
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
	    var msg = status === 'Y' ? "완료처리 하시겠습니까?" : "완료처리를 취소하시겠습니까?";
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
	
	$(document).ready(function() {
		if(location.hash === "#tab1") {
	        fn_change_tab(1);
	    }
	    $("#assignStartDate").on("change", function() {
	        var startVal = $(this).val();
	        if (startVal) {
	            $("#assignEndDate").attr("min", startVal);
	        }
	    });

	    $("#assignEndDate").on("change", function() {
	        var endVal = $(this).val();
	        if (endVal) {
	            $("#assignStartDate").attr("max", endVal);
	        }
	    });
	    $(document).on("click", function(e) {
	        if (!$(e.target).closest("#filePopover, span[onclick*='fn_open_file_popover']").length) {
	            $("#filePopover").hide();
	        }
	    });
	    $("#searchUserNm, #searchAssignTitle").on("keypress", function(e) {
	        if(e.keyCode == 13) {
	            fn_load_assign_list();
	        }
	    });
	    fn_load_assign_list();
	});
	
	function fn_change_tab(idx) {
	    $(".tab-btn").removeClass("active");
	    $(".tab-content").removeClass("active");

	    $(".tab-btn").eq(idx).addClass("active");
	    $("#tab" + idx).addClass("active");

	    if(idx === 2 && calendar) {
	        setTimeout(function() {
	            calendar.render();
	            calendar.updateSize();
	        }, 10);
	    }
	}
	
	
/* [Step 4-2] AI 매칭 시스템 로직 (수정 완료) */
    var g_projId = "${projectVO.projId}";

    // 1. [통합 팝업 열기] : 인력 배정 모달에서 '🤖 AI 추천' 버튼 클릭 시 실행
    function fn_open_ai_popup_integrated() {
        var assignTitle = $("#assignTitle").val();     // 업무명
        var reqText = $("#assignReqSkills").val();     // 요구 기술 (textarea)

        if(!assignTitle) { alert("업무 명칭을 입력해주세요."); $("#assignTitle").focus(); return; }
        if(!reqText) { alert("요구 기술 및 상세내용을 입력해주세요."); $("#assignReqSkills").focus(); return; }

        $('#aiMatchModal').show();
        
        fn_run_ai_match();
    }

    // 2. [AI 매칭 실행] : Python 서버(8000번)로 직접 요청
    function fn_run_ai_match() {
        var weight = $("#weightSlider").val();       // 가중치 값
        var reqText = $("#assignReqSkills").val();
        
        $("#aiResultBody").html('<tr><td colspan="7">...분석 중...</td></tr>');

        var param = {
            "req_skills": reqText,
            "ai_weight": parseInt(weight)
        };

        // [Python] FastAPI 서버 호출
        $.ajax({
            // url: "http://127.0.0.1:8000/api/match",
            url: "<c:url value='/pms/proxyAiMatch.do'/>",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(param),
            success: function(data) {
                var html = "";
                if(data && data.length > 0) {
                    $.each(data, function(i, item) {
                        // 가동률 색상 처리 (0%는 녹색, 사용중은 빨간색)
                        var utilText = item.utilization > 0 ? "<span style='color:#f44336; font-weight:bold;'>" + (item.utilization * 100).toFixed(0) + "%</span>" : "<span style='color:#4CAF50; font-weight:bold;'>대기(0%)</span>";

                        // 설명이 너무 길면 자르기
                        var desc = item.desc ? item.desc : "설명 없음";
                        if(desc.length > 25) desc = desc.substring(0, 25) + "...";

                        html += "<tr onmouseover=\"this.style.background='#f0f8ff'\" onmouseout=\"this.style.background='white'\">";
                        html += "  <td style='font-weight:bold; color:#333;'>" + item.rank + "</td>";
                        html += "  <td style='text-align:left; padding-left:10px;'>";
                        html += "      <strong>" + item.name + "</strong> <span style='font-size:11px; color:#666;'>(" + item.career_years + "년차)</span><br>";
                        html += "      <span style='font-size:11px; color:#888;'>" + desc + "</span>";
                        html += "  </td>";
                        html += "  <td>" + utilText + "</td>";
                        html += "  <td style='color:#673AB7; font-weight:bold;'>" + item.ai_score + "</td>";
                        html += "  <td style='color:#555;'>" + item.career_score + "</td>";
                        html += "  <td style='color:#2196F3; font-weight:bold; font-size:1.1em;'>" + item.total_score + "</td>";
                        html += "  <td>";
                        // [선택] 버튼: 누르면 인원 목록에 추가됨
                        html += " <button type='button' class='btn_s_blue' onclick=\"fn_confirm_assign_to_list('" + item.userId + "', '" + item.name + "')\">선택</button>";
                        // html += " <button type='button' class='btn_s_blue' onclick=\"fn_confirm_assign_to_list('" + (item.emp_id || item.userId) + "','" + item.name + "')\">선택</button>";
                        html += "  </td>";
                        html += "</tr>";
                    });
                } else {
                    html = "<tr><td colspan='7' style='padding:20px;'>조건에 맞는 추천 인력이 없습니다.</td></tr>";
                }
                $("#aiResultBody").html(html);
            },
            error: function(xhr, status, error) {
                $("#aiResultBody").html('<tr><td colspan="7" style="padding:20px; color:red; font-weight:bold;">❌ AI 서버(Python) 연결 실패<br><span style="font-size:12px; color:#555;">(main.py가 켜져 있는지, 주소가 127.0.0.1:8000 인지 확인해주세요)</span></td></tr>');
            }
        });
    }

    // 3. [슬라이더 UI 변경]
    function fn_update_slider_ui(val) {
        $("#val-ai").text(val);
        $("#val-career").text(100 - val);
    }

    // 4. [인원 선택] : AI 결과에서 '선택' 버튼 클릭 시 호출
    function fn_confirm_assign_to_list(userId, empName) {
    	console.log("AI 추천 데이터 (userId):", userId);
        // 이미 목록에 있는지 체크
        if($("#user_row_" + userId).length > 0) {
            alert(empName + " 님은 이미 투입 목록에 있습니다.");
            return;
        }

        // 기존에 있던 인원 추가 함수(fn_select_this_user)를 재사용하여 목록에 넣음
        fn_select_this_user(userId, empName);

        // 팝업 닫기
        $('#aiMatchModal').hide();
    }
	
    $(document).keydown(function(e) {
        if (e.keyCode == 27) {
            $('#aiMatchModal').hide();
            $('#userSearchModal').hide();
            $('#assignModal').hide();
        }
    });
    
    function fn_get_status_style(status) {
        if (status === 'Y') return "background-color:#666666; color:white;";
        if (status === 'R') return "background-color:#673AB7; color:white;";
        return "background-color:#5998eb; color:white;";
    }
    
    function fn_change_status_ajax(tGroupId, nextStatus) {
        $.ajax({
            url: "<c:url value='/pms/updateTaskGroupConfirmAjax.do'/>",
            type: "POST",
            data: { "taskGroupId": tGroupId, "confirmYn": nextStatus },
            success: function(data) {
                fn_load_assign_list();
            },
            error: function() {
                alert("상태 변경 중 오류가 발생했습니다.");
            }
        });
    }
    
    function fn_save_task_with_file() {
    	var fileCheck = $("#assignFile")[0].files[0];
        
        if (fileCheck) {
            var formData = new FormData();
            formData.append("file_0", fileCheck);
            formData.append("atchFileId", $("#assignAtchFileId").val() || "");
            //formData.append("projId", "${projectVO.projId}");

            $.ajax({
                url: "<c:url value='/pms/uploadFileAjax.do'/>",
                type: "POST",
                data: formData,
                processData: false,
                contentType: false,
                success: function(data) {
                    if(data.status === "success") {
                        $("#assignAtchFileId").val(data.atchFileId);
                        console.log("새 영수증 수거 완료: " + data.atchFileId);
                        fn_save_task_group();
                    } else {
                        alert("파일 업로드 실패: " + data.message);
                    }
                }
            });
        } else {
            fn_save_task_group();
        }
    }
    
    function fn_load_task_files(atchFileId) {
        var $area = $("#fileListArea");
        
        if(!atchFileId) {
            $area.html("<span style='color:#ccc;'>첨부된 파일 없음</span>");
            return;
        }

        var html = "<div style='padding:10px; background:#f8f9fa; border:1px solid #e9ecef; border-radius:4px;'>";
        html += "  <p style='margin:0; color:#2196F3; font-weight:bold;'>📎 등록된 파일이 있습니다.</p>";
        html += "  <p style='margin:5px 0 0; font-size:11px; color:#666;'>상세 파일명 및 다운로드는<br><b>'세부 업무 목록' 표</b>에서 확인 가능합니다.</p>";
        html += "</div>";
        
        $area.html(html);
    }
    
    function fn_egov_downFile(atchFileId, fileSn) {
        var downUrl = "<c:url value='/cmm/fms/FileDown.do'/>?atchFileId=" + atchFileId + "&fileSn=" + fileSn;
        
        var $iframe = $("#hiddenDownFrame");
        if ($iframe.length === 0) {
            $iframe = $("<iframe id='hiddenDownFrame' name='hiddenDownFrame' style='display:none;'></iframe>").appendTo("body");
        }

        var $form = $("<form>", {
            "action": "<c:url value='/cmm/fms/FileDown.do'/>",
            "method": "post",
            "target": "hiddenDownFrame"
        }).appendTo("body");

        $form.append($("<input>", { "type": "hidden", "name": "atchFileId", "value": atchFileId }));
        $form.append($("<input>", { "type": "hidden", "name": "fileSn", "value": fileSn }));

        $form.submit();
        $form.remove();
    }
	</script>
</body>
</html>