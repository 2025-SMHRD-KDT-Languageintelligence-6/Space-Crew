<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
    /* 알림창 전용 스타일 */
    #notification-panel {
        transition: transform 0.3s ease-in-out;
        transform: translateX(100%);
    }
    #notification-panel.open {
        transform: translateX(0);
    }
</style>

<div id="notification-panel" class="fixed top-0 right-0 h-full w-80 bg-white shadow-2xl z-[100] border-l border-slate-100 flex flex-col">
    <div class="p-8 border-b border-slate-100 flex justify-between items-center bg-slate-50">
        <h3 class="font-bold text-slate-800 tracking-tighter uppercase underline decoration-blue-500 decoration-2 underline-offset-4">Notification Center</h3>
        <button onclick="toggleNotifications()" class="text-slate-400 hover:text-red-500 transition-colors"><i class="fas fa-times text-lg"></i></button>
    </div>

    <div class="flex-1 overflow-y-auto p-5 space-y-4">
        <div class="p-4 bg-red-50 rounded-[1.5rem] border border-red-100 animate-fade-in">
            <p class="text-[10px] font-bold text-red-600 uppercase mb-2">High Risk</p>
            <p class="text-[11px] text-red-800 font-bold leading-relaxed">더미)지연 키워드 저번 주 보다 증가</p>
        </div>

        <div class="p-4 bg-blue-50 rounded-[1.5rem] border border-blue-100 animate-fade-in">
            <p class="text-[10px] font-bold text-blue-600 uppercase mb-2">AI 회의록</p>
            <p class="text-[11px] text-blue-800 font-medium leading-relaxed">더미) 2026/01/03 분석이 완료 되었습니다.</p>
        </div>

        </div>

    <div class="p-4 bg-slate-50 border-t border-slate-100 text-center">
        <button class="text-[10px] font-bold text-slate-400 hover:text-slate-600 uppercase tracking-widest">모든 알림 읽음 처리</button>
    </div>
</div>