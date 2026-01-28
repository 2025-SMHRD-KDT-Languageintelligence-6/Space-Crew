<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Space-PMS | 회의록 관리 센터</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="<c:url value='/css/egovframework/com/pms/ProjectList.css'/>">
</head>
<body class="bg-slate-50">

<c:import url="/WEB-INF/jsp/egovframework/com/pms/include/menu.jsp" />

<div class="content-page">
    
    <div class="p-10 space-y-12">
        
        <header class="flex justify-between items-center">
            <div>
                <h1 class="text-3xl font-bold text-slate-800 tracking-tighter">📂 회의록 아카이브</h1>
                <p class="text-slate-500 text-sm mt-1">일간/주간 정기 회의록을 업로드하고 관리하세요.</p>
            </div>
        </header>
		<input type="file" id="hiddenFileItem" style="display:none;" onchange="fn_start_upload(this)">
        <section>
            <div class="flex items-center gap-3 mb-6">
                <div class="w-1.5 h-6 bg-orange-500 rounded-full"></div>
                <h2 class="text-xl font-bold text-slate-800 italic">Daily Meeting (17:00 PM)</h2>
            </div>

            <div class="grid grid-cols-7 gap-4 bg-white p-8 rounded-[2.5rem] shadow-sm border border-slate-200">
			    <c:set var="days" value="${fn:split('SUN,MON,TUE,WED,THU,FRI,SAT', ',')}" />
			    <c:forEach var="dayName" items="${days}">
			        <div class="text-center text-[10px] font-black text-slate-300 mb-4">${dayName}</div>
			    </c:forEach>
			
			    <c:forEach var="item" items="${weekDays}">
				    <div class="aspect-square border ${item.isToday ? 'border-blue-500 shadow-lg shadow-blue-50' : 'border-slate-100'} rounded-3xl p-4 flex flex-col justify-between hover:shadow-md transition-all group">
				        <span class="text-sm font-bold ${item.isToday ? 'text-blue-600' : 'text-slate-400'} group-hover:text-blue-600">
				            ${item.dayNum}
				            <c:if test="${item.isToday}"><span class="text-[8px] ml-1 opacity-70">(Today)</span></c:if>
				        </span>
				        
				        <div class="flex flex-col gap-1">
				            <c:choose>
				                <c:when test="${not empty item.atchFileId}">
				                    <div class="bg-emerald-50 py-2 rounded-xl border border-emerald-100 text-center mb-1">
				                        <i class="fas fa-check text-emerald-500 text-[10px]"></i>
				                    </div>
				                    <button onclick="fn_go_detail('${item.meetId}')" 
				                            class="w-full py-1.5 text-[10px] font-bold text-slate-400 hover:text-blue-600 border border-slate-100 rounded-lg transition-all">
				                        수정/보기
				                    </button>
				                </c:when>
				                <c:otherwise>
				                    <button onclick="fn_go_analysis_with_date('${item.fullDate}', this)" 
				                            class="w-full aspect-square flex flex-col items-center justify-center bg-slate-50 border-2 border-dashed border-slate-200 rounded-2xl hover:bg-blue-50 hover:border-blue-300 transition-all group/btn">
				                        <i class="fas fa-plus text-slate-300 group-hover/btn:text-blue-400"></i>
				                        <span class="text-[9px] font-bold text-slate-400 mt-2 tracking-tighter">업로드</span>
				                    </button>
				                </c:otherwise>
				            </c:choose>
				        </div>
				    </div>
				</c:forEach>
			</div>
        </section>

        <section class="pb-20">
		    <div class="flex items-center gap-3 mb-6">
		        <div class="w-1.5 h-6 bg-blue-600 rounded-full"></div>
		        <h2 class="text-xl font-bold text-slate-800 italic">Weekly Meeting</h2>
		    </div>
		
		    <div class="space-y-4">
		        <c:forEach var="week" items="${weeklyList}">
		            <div class="bg-white rounded-[2rem] p-8 border border-slate-200 shadow-sm flex items-center justify-between ${week.isCurrent ? '' : 'opacity-80'}">
		                <div class="flex items-center gap-8">
		                    <div class="${week.isCurrent ? 'bg-blue-50 text-blue-600' : 'bg-slate-100 text-slate-400'} w-16 h-16 rounded-3xl flex items-center justify-center text-2xl font-black">
		                        ${week.weekNum}
		                    </div>
		                    <h3 class="font-bold ${week.isCurrent ? 'text-slate-800' : 'text-slate-600'} text-lg">${week.weekLabel} 주간 회의록</h3>
		                </div>
		
		                <div class="flex gap-3">
						    <c:choose>
						        <c:when test="${not empty week.meetId}">
						            <button onclick="fn_go_detail('${week.meetId}')" 
						                    class="bg-white border border-slate-200 text-slate-500 px-8 py-3.5 rounded-2xl text-xs font-bold hover:bg-slate-50 transition-all">
						                상세보기
						            </button>
						            <button class="bg-slate-200 text-slate-500 px-10 py-3.5 rounded-2xl text-xs font-bold transition-all">
						                업로드 완료
						            </button>
						        </c:when>
						        <c:otherwise>
						            <button class="bg-white border border-slate-200 text-slate-300 px-8 py-3.5 rounded-2xl text-xs font-bold cursor-not-allowed">
						                수정불가
						            </button>
						            <button onclick="fn_go_weekly_analysis('${week.representativeDate}', this)" 
						                    class="bg-blue-600 text-white px-10 py-3.5 rounded-2xl text-xs font-bold shadow-lg shadow-blue-100 hover:bg-blue-700 transition-all">
						                업로드
						            </button>
						        </c:otherwise>
						    </c:choose>
						</div>
		            </div>
		        </c:forEach>
		    </div>
		</section>
   	</div>
</div>
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script>
	    function fn_start_upload(input) {
	        if(input.files && input.files[0]) {
	            var formData = new FormData();
	            formData.append("uploadAudio", input.files[0]);
	            formData.append("meetDt", window.selectedMeetDt);
	
	            $.ajax({
	                url: "${pageContext.request.contextPath}/pms/analyzeMeetingData.do",
	                type: "POST",
	                data: formData,
	                processData: false,
	                contentType: false,
	                success: function(res) {
	                    if(res.status == "success") {
	                        alert("업로드 및 분석 완료!");
	                        location.reload(); 
	                    } else {
	                        alert("실패: " + res.message);
	                    }
	                }
	            });
	        }
	    }
	
	    function fn_go_analysis_with_date(date, btn) {
	        document.getElementById('hiddenFileItem').click();
	        if(date && date.length === 8) {
	            var formattedDate = date.substring(0,4) + "-" + date.substring(4,6) + "-" + date.substring(6,8);
	            window.selectedMeetDt = formattedDate; 
	        } else {
	            window.selectedMeetDt = date; 
	        }
	        window.currentClickedBox = $(btn).closest('.aspect-square');
	    }
	    
	    function fn_go_weekly_analysis(repDate, btn) {
	        if(!repDate || repDate.includes('주차')) {
	            alert("날짜 형식이 올바르지 않습니다. 컨트롤러를 확인하세요!");
	            return;
	        }
	        document.getElementById('hiddenFileItem').click();
	        window.selectedMeetDt = repDate;
	        window.currentClickedBox = $(btn).closest('.bg-white');
	    }
	    
	    function fn_go_detail(meetId) {
	        if(!meetId || meetId === 'null' || meetId === '') {
	            alert("회의록 ID가 없습니다. 새로고침 후 다시 시도해주세요!");
	            return;
	        }
	        location.href = "${pageContext.request.contextPath}/pms/meetingDetail.do?meetId=" + meetId;
	    }
	</script>
</body>
</html>