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

    <style>
        /* 애니메이션 및 공통 스타일 */
        @keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
        .animate-fade-in { animation: fadeIn 0.5s ease-out forwards; }
        .card-hover:hover { transform: translateY(-5px); transition: all 0.3s ease; box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.1); }
        .modal-overlay { background-color: rgba(15, 23, 42, 0.6); backdrop-filter: blur(4px); }
        .hidden-element { display: none !important; }

        /* 스위치 스타일 */
        .switch { position: relative; display: inline-block; width: 44px; height: 24px; }
        .switch input { opacity: 0; width: 0; height: 0; }
        .slider { position: absolute; cursor: pointer; top: 0; left: 0; right: 0; bottom: 0; background-color: #cbd5e1; transition: .4s; border-radius: 24px; }
        .slider:before { position: absolute; content: ""; height: 18px; width: 18px; left: 3px; bottom: 3px; background-color: white; transition: .4s; border-radius: 50%; }
        input:checked + .slider { background-color: #2563eb; }
        input:checked + .slider:before { transform: translateX(20px); }
    </style>
</head>
<body class="bg-slate-50 flex min-h-screen">

    <c:import url="/WEB-INF/jsp/egovframework/com/pms/include/menu.jsp" />

    <main class="flex-1 p-8 pl-[260px] animate-fade-in">
        <header class="flex justify-between items-end mb-10">
            <div>
                <h1 class="text-3xl font-bold text-slate-800 mb-2 tracking-tighter">🚀 Space-PMS Dashboard</h1>
                <p class="text-slate-500 text-sm italic font-medium text-blue-600/70">AI기반 지능형 프로젝트 관리 시스템</p>
            </div>

            <div class="flex items-center space-x-5">
                <div class="flex items-center space-x-3 bg-white px-5 py-2.5 rounded-full shadow-sm border border-slate-100">
                    <span class="text-[11px] text-slate-500 font-bold uppercase tracking-widest">
                        <jsp:useBean id="today" class="java.util.Date" />
                        <fmt:formatDate value="${today}" pattern="yyyy. MM. dd" /> 기준
                    </span>
                    <div class="w-px h-3 bg-slate-200"></div>
                    <button onclick="openConfig()" class="text-slate-400 hover:text-blue-600 transition-all group" title="설정">
                        <i class="fas fa-cog text-lg group-hover:rotate-90 transition-transform"></i>
                    </button>
                </div>

                <button onclick="toggleNotifications()" class="relative group focus:outline-none">
                    <div class="w-11 h-11 bg-blue-600 rounded-full flex items-center justify-center text-white font-bold shadow-xl ring-4 ring-white group-hover:scale-105 transition-transform active:scale-95">
                        <i class="fas fa-bell"></i>
                    </div>
                    <span class="absolute -top-1 -right-1 w-3.5 h-3.5 bg-red-500 rounded-full border-2 border-white animate-pulse"></span>
                </button>
            </div>
        </header>

        <section class="mb-12">
            <div class="flex items-center mb-6">
                <div class="w-1.5 h-6 bg-blue-600 rounded-full mr-3 shadow-[0_0_10px_rgba(37,99,235,0.5)]"></div>
                <h2 class="text-xl font-bold text-slate-800">지능형 프로세스 모니터링</h2>
            </div>

            <div class="grid grid-cols-1 xl:grid-cols-3 gap-6">
                <div id="w-sales" class="bg-white rounded-[2rem] shadow-sm border border-slate-200 overflow-hidden transition-all card-hover">
                    <div class="p-5 border-b border-slate-50 flex justify-between items-center bg-orange-50/30">
                        <h3 class="font-bold text-slate-700 text-sm italic"><i class="fas fa-bullseye text-orange-500 mr-2"></i>Sales Intelligence</h3>
                        <span class="text-[10px] font-bold text-orange-500 bg-orange-100 px-2 py-0.5 rounded-full">LIVE</span>
                    </div>
                    <div class="p-6 space-y-5">
                        <div>
                            <div class="flex justify-between mb-2 text-xs font-bold text-slate-600">
                                <span>AI 통합 플랫폼 수주 확률</span>
                                <span class="text-orange-600">85%</span>
                            </div>
                            <div class="w-full bg-slate-100 rounded-full h-2">
                                <div class="bg-orange-400 h-2 rounded-full w-[85%] shadow-sm transition-all duration-1000"></div>
                            </div>
                        </div>
                    </div>
                </div>

                <div id="w-contract" class="bg-white rounded-[2rem] shadow-sm border border-slate-200 overflow-hidden card-hover">
                    <div class="p-5 border-b border-slate-50 bg-emerald-50/30 font-bold text-slate-700 text-sm italic">
                        <i class="fas fa-file-contract text-emerald-500 mr-2"></i>Contract Status
                    </div>
                    <div class="p-6">
                        <div class="p-4 bg-emerald-50 rounded-2xl border border-emerald-100">
                            <p class="text-xs font-bold text-emerald-800">최근 체결 완료</p>
                            <p id="w-contract-detail" class="text-[11px] text-emerald-600 mt-1 italic font-medium">전남 테크노파크 유지보수 계약</p>
                        </div>
                    </div>
                </div>

                <div id="w-project" class="bg-white rounded-[2rem] shadow-sm border border-slate-200 overflow-hidden card-hover">
                    <div class="p-5 border-b border-slate-50 bg-blue-50/30 font-bold text-slate-700 text-sm italic text-blue-600">
                        <i class="fas fa-tasks mr-2"></i>Project Analysis
                    </div>
                    <div class="p-6">
                        <div class="flex justify-between mb-3 text-xs font-bold"><span>Space-PMS 고도화</span><span class="text-blue-600">72%</span></div>
                        <div class="w-full bg-slate-100 h-2 rounded-full mb-4">
                            <div class="bg-blue-600 h-2 rounded-full w-[72%] transition-all duration-1000"></div>
                        </div>
                        <div id="w-project-risk" class="bg-red-50 p-3 rounded-2xl border border-red-100 flex items-center text-red-600 font-bold text-[10px] animate-pulse">
                            <i class="fas fa-exclamation-triangle mr-2"></i> RISK 감지: 인력 투입 최적화 필요
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="grid grid-cols-2 md:grid-cols-3 xl:grid-cols-6 gap-4">
            <a href="<c:url value='/pms/customerList.do'/>" class="bg-white p-6 rounded-3xl border border-slate-200 shadow-sm card-hover text-center">
                <div class="w-12 h-12 bg-indigo-50 text-indigo-500 rounded-2xl flex items-center justify-center mx-auto mb-3 text-xl"><i class="fas fa-address-card"></i></div>
                <h4 class="font-bold text-slate-700 text-xs">고객 관리</h4>
            </a>
            <a href="<c:url value='/pms/projectList.do'/>" class="bg-white p-6 rounded-3xl border border-slate-200 shadow-sm card-hover text-center relative">
                <div class="w-12 h-12 bg-blue-50 text-blue-600 rounded-2xl flex items-center justify-center mx-auto mb-3 text-xl"><i class="fas fa-project-diagram"></i></div>
                <h4 class="font-bold text-slate-700 text-xs">프로젝트</h4>
                <c:if test="${projectCount > 0}"><span class="absolute top-3 right-3 bg-blue-600 text-white text-[10px] font-bold px-2 py-0.5 rounded-full">${projectCount}</span></c:if>
            </a>
            <a href="<c:url value='/pms/billingList.do'/>" class="bg-white p-6 rounded-3xl border border-slate-200 shadow-sm card-hover text-center relative">
                <div class="w-12 h-12 bg-rose-50 text-rose-500 rounded-2xl flex items-center justify-center mx-auto mb-3 text-xl"><i class="fas fa-file-invoice-dollar"></i></div>
                <h4 class="font-bold text-rose-500 text-xs">청구/정산</h4>
                <c:if test="${billingCount > 0}"><span class="absolute top-3 right-3 bg-rose-500 text-white text-[10px] font-bold px-2 py-0.5 rounded-full">${billingCount}</span></c:if>
            </a>
            <a href="<c:url value='/pms/meetingList.do'/>" class="bg-slate-800 p-6 rounded-3xl border border-slate-700 shadow-lg card-hover text-center group">
                <div class="w-12 h-12 bg-blue-500/20 text-blue-400 rounded-2xl flex items-center justify-center mx-auto mb-3 text-xl group-hover:scale-110 transition-transform">🎙️</div>
                <h4 class="font-bold text-white text-xs">AI 회의록 분석</h4>
            </a>
            <a href="<c:url value='/pms/userList.do'/>" class="bg-white p-6 rounded-3xl border border-slate-200 shadow-sm card-hover text-center">
                <div class="w-12 h-12 bg-slate-50 text-slate-500 rounded-2xl flex items-center justify-center mx-auto mb-3 text-xl"><i class="fas fa-user-tie"></i></div>
                <h4 class="font-bold text-slate-700 text-xs">운영직 관리</h4>
            </a>
        </section>
    </main>

    <c:import url="/WEB-INF/jsp/egovframework/com/pms/include/notification.jsp" />

    <div id="config-modal" class="hidden fixed inset-0 z-[110] modal-overlay flex items-center justify-center p-4">
        <div class="bg-white w-full max-w-xl rounded-[3rem] shadow-2xl overflow-hidden">
            <div class="p-8 border-b border-slate-100 bg-slate-50/50 flex justify-between items-center text-slate-800">
                <h3 class="text-2xl font-bold tracking-tight">대시보드 커스터마이징</h3>
                <button onclick="closeConfig()" class="w-10 h-10 bg-white rounded-full flex items-center justify-center shadow-sm border border-slate-200 hover:text-red-500 transition-colors"><i class="fas fa-times"></i></button>
            </div>
            <div class="p-10 space-y-8">
                <div class="flex items-center justify-between pb-4 border-b border-slate-100">
                    <span class="font-bold text-slate-700 italic">영업 인텔리전스 위젯 활성화</span>
                    <label class="switch"><input type="checkbox" checked onchange="updateView('w-sales', this)"><span class="slider"></span></label>
                </div>
                <div class="flex items-center justify-between pb-4 border-b border-slate-100">
                    <span class="font-bold text-red-600 italic">리스크 감지 알림 표시</span>
                    <label class="switch"><input type="checkbox" checked onchange="updateView('w-project-risk', this)"><span class="slider"></span></label>
                </div>
            </div>
            <div class="p-10 bg-slate-50 border-t border-slate-100">
                <button onclick="saveAndToast()" class="w-full bg-blue-600 text-white font-bold py-5 rounded-[2rem] shadow-xl hover:bg-blue-700 transition-all uppercase tracking-widest">설정 저장 및 적용</button>
            </div>
        </div>
    </div>

    <div id="toast" class="hidden fixed bottom-10 left-1/2 -translate-x-1/2 bg-slate-900 text-white px-8 py-3 rounded-full text-xs font-bold shadow-2xl z-[200] animate-fade-in">
        ✅ 설정이 실시간으로 대시보드에 반영되었습니다.
    </div>

    <script>
        function openConfig() { document.getElementById('config-modal').classList.remove('hidden'); }
        function closeConfig() { document.getElementById('config-modal').classList.add('hidden'); }

        // 알림창 토글 (notification.jsp 내의 패널을 제어)
        function toggleNotifications() {
            const panel = document.getElementById('notification-panel');
            if(panel) panel.classList.toggle('open');
        }

        function updateView(id, checkbox) {
            const target = document.getElementById(id);
            if(target) {
                checkbox.checked ? target.classList.remove('hidden-element') : target.classList.add('hidden-element');
            }
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