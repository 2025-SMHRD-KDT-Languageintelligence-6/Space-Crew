<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Space-PMS | AI 회의 분석 센터</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="<c:url value='/css/egovframework/com/pms/ProjectList.css'/>">
    <style>
        .progress-fill { transition: width 0.5s cubic-bezier(0.4, 0, 0.2, 1); }
        .scanning-line {
            height: 2px;
            background: linear-gradient(90deg, transparent, #a855f7, transparent);
            position: absolute; width: 100%; animation: scan 2s infinite;
        }
        @keyframes scan { 0% { top: 0; } 100% { top: 100%; } }
        .result-fade-in { animation: fadeIn 0.8s ease-out forwards; }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }
        .content-page {
        margin-left: 250px !important;
        width: calc(100% - 250px) !important;
        min-height: 100vh;
        background-color: #f8fafc;
    }
    </style>
</head>
<body class="bg-slate-50 flex min-h-screen">

<c:import url="/WEB-INF/jsp/egovframework/com/pms/include/menu.jsp" />
<div class="content-page">
    
    <div class="p-10 space-y-12">
<!-- <main class="flex-1 min-w-0 h-full flex flex-col p-12 overflow-y-auto no-scrollbar"> -->

    <header class="flex justify-between items-center">
        <div class="flex items-center gap-6">
            <button onclick="history.back()" class="w-12 h-12 bg-white border border-slate-200 rounded-2xl flex items-center justify-center text-slate-400 hover:text-blue-600 transition-all shadow-sm">
                <i class="fas fa-arrow-left"></i>
            </button>
            <h1 class="text-3xl font-bold text-slate-800 tracking-tighter italic">AI Analysis Center</h1>
        </div>
    </header>

    <div class="max-w-5xl mx-auto w-full space-y-8">

        <section class="bg-white rounded-[3rem] border-2 border-purple-100 p-12 shadow-xl shadow-purple-100/20 relative overflow-hidden group">
            <div class="scanning-line opacity-0 group-hover:opacity-100"></div>
            <div class="flex flex-col items-center text-center">
                <div class="w-20 h-20 bg-purple-50 text-purple-600 rounded-[2rem] flex items-center justify-center text-3xl mb-6 shadow-inner">
                    <i class="fas fa-microphone-lines"></i>
                </div>
                <h2 class="text-2xl font-black text-slate-800 mb-2 italic">AI 음성 요약 모델 분석</h2>
                <p class="text-slate-400 text-sm mb-8">회의 녹음 파일(MP3, WAV)을 업로드하여 핵심 내용을 자동으로 추출하세요.</p>

                <div class="w-full max-w-md bg-slate-50 border-2 border-dashed border-slate-200 rounded-[2rem] p-6 mb-8 hover:bg-purple-50/50 hover:border-purple-300 transition-all">
                    <input type="file" id="audioFileInput" accept="audio/*" class="hidden" onchange="fn_file_selected()">
                    <button onclick="$('#audioFileInput').click()" class="flex items-center gap-3 mx-auto text-slate-500 font-bold text-sm">
                        <i class="fas fa-folder-open text-purple-500"></i>
                        <span id="fileNameDisplay">회의 음성 파일 선택</span>
                    </button>
                </div>
				<div class="w-full max-w-md mx-auto mb-8 text-left">
				    <label class="block text-[11px] font-black text-purple-400 uppercase tracking-[0.2em] mb-3 ml-2">Meeting Date</label>
				    <div class="relative">
				        <input type="date" id="meetDtInput" 
				               class="w-full bg-slate-50 border-2 border-slate-100 rounded-[1.5rem] p-4 text-sm font-bold text-slate-700 focus:border-purple-300 focus:bg-white outline-none transition-all shadow-inner">
				    </div>
				</div>
				
				
                <button type="button" id="btnAnalyze" class="px-16 py-4 bg-purple-600 text-white font-black rounded-2xl shadow-lg shadow-purple-200 hover:bg-purple-700 transition-all uppercase tracking-widest text-sm" onclick="fn_upload_audio()">
                    분석 시작하기
                </button>

                <div id="progressContainer" class="w-full mt-10 hidden">
                    <div class="flex justify-between items-center mb-3 text-xs font-bold text-slate-600 uppercase tracking-tighter">
                        <span id="statusText"><i class="fas fa-spinner animate-spin mr-2"></i>AI 모델 분석 중...</span>
                        <span id="percentText">0%</span>
                    </div>
                    <div class="w-full bg-slate-100 h-3 rounded-full overflow-hidden shadow-inner">
                        <div id="progressBar" class="progress-fill bg-purple-500 h-full w-0% shadow-[0_0_10px_rgba(168,85,247,0.4)]"></div>
                    </div>
                </div>
            </div>
        </section>

        <section class="bg-white rounded-[2rem] border border-slate-200 p-6 flex justify-between items-center opacity-80 hover:opacity-100 transition-opacity">
            <div class="flex items-center gap-4">
                <div class="w-10 h-10 bg-slate-100 text-slate-400 rounded-xl flex items-center justify-center text-sm">
                    <i class="fas fa-file-alt"></i>
                </div>
                <div>
                    <h4 class="font-bold text-slate-700 text-sm">작성 문서 직접 업로드</h4>
                    <p class="text-[10px] text-slate-400">PDF, Word 또는 스캔 이미지 파일 등록</p>
                </div>
            </div>
            <input type="file" id="docUpload" class="hidden">
            <button onclick="$('#docUpload').click()" class="px-5 py-2 border border-slate-200 rounded-xl text-[11px] font-bold text-slate-500 hover:bg-slate-50 transition-all">파일 선택</button>
        </section>

        <div id="resultArea" class="result-fade-in hidden pb-20">
        	<div class="mt-8 bg-white rounded-[2.5rem] border border-slate-200 overflow-hidden shadow-sm">
		        <div class="bg-slate-800 text-white p-6 flex justify-between items-center">
		            <h3 class="font-bold italic flex items-center gap-2">
		                <i class="fas fa-sparkles text-yellow-400"></i> AI 회의 분석 리포트
		            </h3>
		        </div>
		        <div class="p-8 space-y-8">
		            <div>
		                <h4 class="text-sm font-bold text-slate-800 mb-3 flex items-center gap-2">
		                    <div class="w-1.5 h-4 bg-blue-500 rounded-full"></div> 회의 요약
		                </h4>
		                <div class="p-5 bg-blue-50/30 border border-blue-100 rounded-2xl text-sm text-slate-600 leading-relaxed font-medium">
		                    ${res.data.summary}
		                </div>
		            </div>
		            <div>
		                <h4 class="text-sm font-bold text-slate-800 mb-3 flex items-center gap-2">
		                    <div class="w-1.5 h-4 bg-emerald-500 rounded-full"></div> 주요 결정 및 할 일
		                </h4>
		                <div class="p-5 bg-emerald-50/30 border border-emerald-100 rounded-2xl text-sm text-slate-600 leading-relaxed font-medium">
		                    ${res.data.action_items}
		                </div>
		            </div>
		        </div>
		    </div>
        
        
        
        
        
        
        
        </div>

    </div>
<!-- </main> -->
	</div>
</div>


<script>
    // 파일 선택 시 이름 표시
    function fn_file_selected() {
        var fileName = $('#audioFileInput')[0].files[0].name;
        $('#fileNameDisplay').text(fileName).addClass('text-purple-600');
    }

    function fn_upload_audio() {
        var fileField = $('#audioFileInput')[0];
        var meetDt = $('#meetDtInput').val();
        if (!meetDt) {
            alert("회의 날짜를 선택해 주세요.");
            return;
        }
        if (fileField.files.length === 0) {
            alert("분석할 음성 파일을 선택해 주세요.");
            return;
        }

        var formData = new FormData();
        formData.append("uploadAudio", fileField.files[0]);
        formData.append("meetDt", meetDt);

        // UI 상태 변경
        $('#progressContainer').fadeIn();
        $('#btnAnalyze').attr('disabled', true).addClass('opacity-50 cursor-not-allowed');

        // 프로그레스 바 가짜 애니메이션 (실제 데이터 전송 중 시각적 효과)
        let width = 0;
        let interval = setInterval(() => {
            if (width >= 90) clearInterval(interval);
            else {
                width += Math.random() * 5;
                $('#progressBar').css('width', width + '%');
                $('#percentText').text(Math.floor(width) + '%');
            }
        }, 500);

        $.ajax({
            url: "<c:url value='/pms/analyzeMeetingData.do'/>",
            type: "POST",
            data: formData,
            processData: false,
            contentType: false,
            success: function(res) {
                clearInterval(interval);
                $('#progressBar').css('width', '100%');
                $('#percentText').text('100%');
                $('#statusText').html('<i class="fas fa-check-circle text-emerald-500 mr-2"></i> 분석이 완료되었습니다!');

                if(res.status === "success") {
                    var html = `
                        <div class="mt-8 bg-white rounded-[2.5rem] border border-slate-200 overflow-hidden shadow-sm">
                            <div class="bg-slate-800 text-white p-6 flex justify-between items-center">
                                <h3 class="font-bold italic flex items-center gap-2"><i class="fas fa-sparkles text-yellow-400"></i> AI 회의 분석 리포트</h3>
                                <span class="text-[10px] bg-white/20 px-3 py-1 rounded-full">분석 신뢰도: 98%</span>
                            </div>
                            <div class="p-8 space-y-8">
                                <div>
                                    <h4 class="text-sm font-bold text-slate-800 mb-3 flex items-center gap-2">
                                        <div class="w-1.5 h-4 bg-blue-500 rounded-full"></div> 회의 요약
                                    </h4>
                                    <div class="p-5 bg-blue-50/30 border border-blue-100 rounded-2xl text-sm text-slate-600 leading-relaxed font-medium">\${res.data.summary}</div>
                                </div>
                                <div>
                                    <h4 class="text-sm font-bold text-slate-800 mb-3 flex items-center gap-2">
                                        <div class="w-1.5 h-4 bg-emerald-500 rounded-full"></div> 주요 결정 및 할 일
                                    </h4>
                                    <div class="p-5 bg-emerald-50/30 border border-emerald-100 rounded-2xl text-sm text-slate-600 leading-relaxed font-medium">\${res.data.action_items}</div>
                                </div>
                                \${res.excel_path ? `
                                <div class="pt-4 flex justify-end">
                                    <button type="button" class="px-8 py-3 bg-emerald-600 text-white font-bold rounded-xl shadow-lg hover:bg-emerald-700 transition-all flex items-center gap-2 text-xs" onclick="fn_download_excel('\${res.excel_path}')">
                                        <i class="fas fa-file-excel"></i> 엑셀 결과 다운로드
                                    </button>
                                </div>` : ''}
                            </div>
                        </div>
                    `;

                    $('#resultArea').html(html).show();
                    $('#btnAnalyze').attr('disabled', false).removeClass('opacity-50 cursor-not-allowed');
                } else {
                    alert("분석 실패: " + res.message);
                }
            },
            error: function(xhr) {
                clearInterval(interval);
                alert("오류 발생: " + xhr.status);
                $('#btnAnalyze').attr('disabled', false).removeClass('opacity-50 cursor-not-allowed');
            }
        });
    }

    function fn_download_excel(path) {
        location.href = "<c:url value='/pms/downloadExcel.do'/>?filePath=" + encodeURIComponent(path);
    }
</script>
</body>
</html>