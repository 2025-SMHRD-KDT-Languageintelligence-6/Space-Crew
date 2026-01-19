<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Space-PMS | 지능형 통합 대시보드</title>

    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <link rel="stylesheet" href="<c:url value='/css/egovframework/com/pms/dashboard.css'/>">
</head>
<body class="bg-slate-50 flex">

    <c:import url="/WEB-INF/jsp/egovframework/com/pms/include/menu.jsp" />

    <main class="flex-1 p-8">
        <header class="flex justify-between items-end mb-10">
            <div>
                <h1 class="text-3xl font-bold text-slate-800 mb-2 tracking-tighter">🚀 Space-PMS Dashboard</h1>
                <p class="text-slate-500 text-sm">AI 기반 분석 데이터와 프로젝트 현황을 한눈에 관리하세요.</p>
            </div>

            <div class="flex items-center space-x-5">
                <div class="flex items-center space-x-3 bg-white px-5 py-2.5 rounded-full shadow-sm border border-slate-100">
                    <span class="text-xs text-slate-500 font-bold uppercase tracking-widest">
                        <jsp:useBean id="today" class="java.util.Date" />
                        <fmt:formatDate value="${today}" pattern="yyyy. MM. dd" /> 기준
                    </span>
                    <div class="w-px h-3 bg-slate-300"></div>
                    <button onclick="openConfig()" class="text-slate-400 hover:text-blue-600 transition-all group" title="Dashboard Settings">
                        <i class="fas fa-cog text-lg group-hover:rotate-90 transition-transform"></i>
                    </button>
                </div>

                <button onclick="toggleNotifications()" class="relative group focus:outline-none">
                    <div class="w-11 h-11 bg-blue-600 rounded-full flex items-center justify-center text-white font-bold shadow-xl ring-4 ring-white group-hover:scale-105 transition-transform active:scale-95">O</div>
                    <span class="absolute -top-1 -right-1 w-3.5 h-3.5 bg-red-500 rounded-full border-2 border-white animate-pulse"></span>
                </button>
            </div>
        </header>

        <section class="mb-12">
            <div class="flex items-center mb-6">
                <div class="w-1.5 h-6 bg-blue-600 rounded-full mr-3"></div>
                <h2 class="text-xl font-bold text-slate-800">지능형 프로세스 모니터링</h2>
            </div>
            <div class="grid grid-cols-1 xl:grid-cols-3 gap-6">

                <div id="w-sales" class="bg-white rounded-[2rem] shadow-sm border border-slate-200 overflow-hidden transition-all">
                    <div class="p-5 border-b border-slate-50 flex justify-between items-center bg-orange-50/30">
                        <h3 class="font-bold text-slate-700 text-sm italic"><i class="fas fa-bullseye text-orange-500 mr-2"></i>Sales Intelligence</h3>
                        <span class="text-[10px] font-bold text-orange-500 bg-orange-100 px-2 py-0.5 rounded-full">LIVE</span>
                    </div>
                    <div class="p-6 space-y-5">
                        <div id="w-sales-item1">
                            <div class="flex justify-between mb-2 text-xs font-bold text-slate-600"><span>AI 통합 플랫폼 구축</span><span class="text-orange-600">45%</span></div>
                            <div class="w-full bg-slate-100 rounded-full h-2"><div class="bg-orange-400 h-2 rounded-full w-[45%] shadow-sm"></div></div>
                        </div>
                    </div>
                </div>

                <div id="w-contract" class="bg-white rounded-[2rem] shadow-sm border border-slate-200 overflow-hidden">
                    <div class="p-5 border-b border-slate-50 bg-emerald-50/30 font-bold text-slate-700 text-sm italic">
                        <i class="fas fa-file-contract text-emerald-500 mr-2"></i>Contract Status
                    </div>
                    <div class="p-6">
                        <div class="p-4 bg-emerald-50 rounded-2xl border border-emerald-100">
                            <p class="text-xs font-bold text-emerald-800">체결 완료 안내</p>
                            <p id="w-contract-detail" class="text-[11px] text-emerald-600 mt-1 italic font-medium">법무팀 최종 날인 프로세스 진행 중</p>
                        </div>
                    </div>
                </div>

                <div id="w-project" class="bg-white rounded-[2rem] shadow-sm border border-slate-200 overflow-hidden">
                    <div class="p-5 border-b border-slate-50 bg-blue-50/30 font-bold text-slate-700 text-sm italic text-blue-600">
                        <i class="fas fa-tasks mr-2"></i>Project Analysis
                    </div>
                    <div class="p-6">
                        <div class="flex justify-between mb-3 text-xs font-bold"><span>Next ERP 개발</span><span class="text-blue-600">72%</span></div>
                        <div class="w-full bg-slate-100 h-2 rounded-full mb-4"><div class="bg-blue-600 h-2 rounded-full w-[72%]"></div></div>
                        <div id="w-project-risk" class="bg-red-50 p-3 rounded-2xl border border-red-100 flex items-center text-red-600 font-bold text-[10px] animate-pulse">
                            <i class="fas fa-exclamation-triangle mr-2"></i> RISK 감지: 일정 지연 주의
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="grid grid-cols-2 md:grid-cols-3 xl:grid-cols-6 gap-4">
            <a href="#" id="m-1" class="bg-white p-6 rounded-3xl border border-slate-200 shadow-sm card-hover text-center">
                <div class="w-12 h-12 bg-indigo-50 text-indigo-500 rounded-2xl flex items-center justify-center mx-auto mb-3 text-xl"><i class="fas fa-address-card"></i></div>
                <h4 class="font-bold text-slate-700 text-xs">고객 관리</h4>
            </a>
            <a href="#" id="m-4" class="bg-white p-6 rounded-3xl border border-slate-200 shadow-sm card-hover text-center relative">
                <div class="w-12 h-12 bg-blue-50 text-blue-600 rounded-2xl flex items-center justify-center mx-auto mb-3 text-xl"><i class="fas fa-project-diagram"></i></div>
                <h4 class="font-bold text-slate-700 text-xs">프로젝트</h4>
                <span class="absolute top-3 right-3 bg-blue-600 text-white text-[10px] font-bold px-2 py-0.5 rounded-full">${projectCount}</span>
            </a>
            <a href="#" id="m-5" class="bg-white p-6 rounded-3xl border border-slate-200 shadow-sm card-hover text-center relative">
                <div class="w-12 h-12 bg-rose-50 text-rose-500 rounded-2xl flex items-center justify-center mx-auto mb-3 text-xl"><i class="fas fa-file-invoice-dollar"></i></div>
                <h4 class="font-bold text-rose-500 text-xs">청구/정산</h4>
                <span class="absolute top-3 right-3 bg-rose-500 text-white text-[10px] font-bold px-2 py-0.5 rounded-full">${billingCount}</span>
            </a>
            </section>
    </main>

    <div id="notification-panel" class="fixed top-0 right-0 h-full w-80 bg-white shadow-2xl z-[100] border-l border-slate-100 flex flex-col">
        <div class="p-8 border-b border-slate-100 flex justify-between items-center bg-slate-50">
            <h3 class="font-bold text-slate-800 tracking-tighter uppercase underline decoration-blue-500 decoration-2 underline-offset-4">Notification Center</h3>
            <button onclick="toggleNotifications()" class="text-slate-400 hover:text-red-500 transition-colors"><i class="fas fa-times text-lg"></i></button>
        </div>
        <div class="flex-1 overflow-y-auto p-5 space-y-4">
            <div class="p-4 bg-red-50 rounded-[1.5rem] border border-red-100">
                <p class="text-[10px] font-bold text-red-600 uppercase mb-2">High Risk</p>
                <p class="text-[11px] text-red-800 font-bold leading-relaxed">Next ERP 프로젝트가 목표 대비 12.5% 지연되었습니다. 담당자 인력 보강이 필요합니다.</p>
            </div>
            <div class="p-4 bg-blue-50 rounded-[1.5rem] border border-blue-100">
                <p class="text-[10px] font-bold text-blue-600 uppercase mb-2">AI Summary</p>
                <p class="text-[11px] text-blue-800 font-medium leading-relaxed">금일 오전 주간 회의의 핵심 요약 보고서가 생성되었습니다. (GPT-4o 분석)</p>
            </div>
        </div>
    </div>

    <div id="config-modal" class="hidden fixed inset-0 z-50 modal-overlay flex items-center justify-center p-4">
        <div class="bg-white w-full max-w-xl rounded-[3rem] shadow-2xl overflow-hidden animate-in fade-in zoom-in duration-300">
            <div class="p-8 border-b border-slate-100 bg-slate-50/50 flex justify-between items-center text-slate-800">
                <h3 class="text-2xl font-bold tracking-tight">대시보드 상세 설정</h3>
                <button onclick="closeConfig()" class="w-10 h-10 bg-white rounded-full flex items-center justify-center shadow-sm border border-slate-200 hover:text-red-500 transition-colors"><i class="fas fa-times"></i></button>
            </div>
            <div class="p-10 space-y-8 max-h-[50vh] overflow-y-auto">
                <div class="flex items-center justify-between pb-4 border-b border-slate-100">
                    <span class="font-bold text-slate-700 italic">영업 현황 위젯 노출</span>
                    <label class="switch"><input type="checkbox" checked onchange="updateView('w-sales', this)"><span class="slider"></span></label>
                </div>
                <div class="flex items-center justify-between pb-4 border-b border-slate-100">
                    <span class="font-bold text-red-600 italic">리스크 알림 문구 활성화</span>
                    <label class="switch"><input type="checkbox" checked onchange="updateView('w-project-risk', this)"><span class="slider"></span></label>
                </div>
            </div>
            <div class="p-10 bg-slate-50 border-t border-slate-100">
                <button onclick="saveAndToast()" class="w-full bg-blue-600 text-white font-bold py-5 rounded-[2rem] shadow-xl hover:bg-blue-700 transition-all uppercase tracking-widest">Save Settings</button>
            </div>
        </div>
    </div>

    <div id="toast" class="hidden fixed bottom-10 left-1/2 -translate-x-1/2 bg-slate-900 text-white px-8 py-3 rounded-full text-xs font-bold shadow-2xl z-[200]">
        ✅ 대시보드 커스텀 설정이 즉시 반영되었습니다.
    </div>

    <script>
        function openConfig() { document.getElementById('config-modal').classList.remove('hidden'); }
        function closeConfig() { document.getElementById('config-modal').classList.add('hidden'); }
        function toggleNotifications() { document.getElementById('notification-panel').classList.toggle('open'); }
        function updateView(id, checkbox) {
            const target = document.getElementById(id);
            checkbox.checked ? target.classList.remove('hidden-element') : target.classList.add('hidden-element');
        }
        function saveAndToast() {
            closeConfig();
            const toast = document.getElementById('toast');
            toast.classList.remove('hidden');
            setTimeout(() => { toast.classList.add('hidden'); }, 3000);
        }
    </script>
</body>

</html>