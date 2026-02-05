<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 대시보드 커스터마이징 모달 (Tailwind only) -->
<div id="config-modal" class="hidden fixed inset-0 z-[2000]">
  <!-- overlay -->
  <div class="absolute inset-0 bg-slate-900/60 backdrop-blur-sm" onclick="closeConfig()"></div>

  <!-- modal -->
  <div class="relative mx-auto mt-[12vh] w-[92vw] max-w-md rounded-3xl bg-white shadow-2xl border border-slate-200 overflow-hidden">
    <!-- header -->
    <div class="flex items-center justify-between px-6 py-5 bg-slate-50 border-b border-slate-100">
      <h3 class="text-base font-extrabold tracking-tight text-slate-800">대시보드 카드 설정</h3>
      <button type="button"
              onclick="closeConfig()"
              class="w-10 h-10 rounded-full bg-white border border-slate-200 shadow-sm flex items-center justify-center text-slate-500 hover:text-red-500 hover:border-red-200 transition">
        <i class="fa-solid fa-xmark"></i>
      </button>
    </div>

    <!-- body -->
    <div class="px-6 py-6 space-y-3">
      <p class="text-xs text-slate-500 font-medium">
        표시할 카드를 선택하세요. (즉시 반영)
      </p>

      <div class="grid grid-cols-2 gap-3 pt-2">

        <label class="flex items-center gap-2 p-3 rounded-2xl border border-slate-200 bg-white hover:bg-slate-50 cursor-pointer">
          <input type="checkbox" checked onchange="toggleCard('card-customer', this)"
                 class="w-4 h-4 accent-blue-600">
          <span class="text-sm font-bold text-slate-700">고객 관리</span>
        </label>

        <label class="flex items-center gap-2 p-3 rounded-2xl border border-slate-200 bg-white hover:bg-slate-50 cursor-pointer">
          <input type="checkbox" checked onchange="toggleCard('card-sales', this)"
                 class="w-4 h-4 accent-blue-600">
          <span class="text-sm font-bold text-slate-700">영업 관리</span>
        </label>

        <label class="flex items-center gap-2 p-3 rounded-2xl border border-slate-200 bg-white hover:bg-slate-50 cursor-pointer">
          <input type="checkbox" checked onchange="toggleCard('card-contract', this)"
                 class="w-4 h-4 accent-blue-600">
          <span class="text-sm font-bold text-slate-700">계약 관리</span>
        </label>

        <label class="flex items-center gap-2 p-3 rounded-2xl border border-slate-200 bg-white hover:bg-slate-50 cursor-pointer">
          <input type="checkbox" checked onchange="toggleCard('card-project', this)"
                 class="w-4 h-4 accent-blue-600">
          <span class="text-sm font-bold text-slate-700">프로젝트</span>
        </label>

        <label class="flex items-center gap-2 p-3 rounded-2xl border border-slate-200 bg-white hover:bg-slate-50 cursor-pointer">
          <input type="checkbox" checked onchange="toggleCard('card-billing', this)"
                 class="w-4 h-4 accent-blue-600">
          <span class="text-sm font-bold text-slate-700">청구/정산</span>
        </label>

        <label class="flex items-center gap-2 p-3 rounded-2xl border border-slate-200 bg-white hover:bg-slate-50 cursor-pointer">
          <input type="checkbox" checked onchange="toggleCard('card-user', this)"
                 class="w-4 h-4 accent-blue-600">
          <span class="text-sm font-bold text-slate-700">직원 관리</span>
        </label>

        <label class="flex items-center gap-2 p-3 rounded-2xl border border-slate-200 bg-white hover:bg-slate-50 cursor-pointer col-span-2">
          <input type="checkbox" checked onchange="toggleCard('card-meeting', this)"
                 class="w-4 h-4 accent-blue-600">
          <span class="text-sm font-bold text-slate-700">AI 회의록</span>
        </label>

      </div>
    </div>

    <!-- footer -->
    <div class="px-6 py-5 bg-slate-50 border-t border-slate-100">
      <button type="button"
              onclick="saveConfig()"
              class="w-full rounded-2xl bg-blue-600 text-white font-extrabold py-4 shadow-xl hover:bg-blue-700 transition tracking-wide">
        설정 저장
      </button>
    </div>
  </div>
</div>
