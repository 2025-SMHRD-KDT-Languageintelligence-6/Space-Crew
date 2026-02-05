<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 대시보드 커스터마이징 모달 (Tailwind only) -->
<div id="config-modal" class="hidden fixed inset-0 z-[2000]">
  <!-- overlay -->
  <div class="absolute inset-0 bg-slate-900/60 backdrop-blur-sm" onclick="closeConfig()"></div>

  <!-- modal -->
  <div class="relative mx-auto mt-[10vh] w-[92vw] max-w-2xl rounded-3xl bg-white shadow-2xl border border-slate-200 overflow-hidden">
    <!-- header -->
    <div class="flex items-center justify-between px-6 py-5 bg-slate-50 border-b border-slate-100">
      <div>
        <h3 class="text-base font-extrabold tracking-tight text-slate-800">대시보드 카드 설정</h3>
        <p class="text-xs text-slate-500 font-medium mt-1">체크를 해제하면 대시보드에서 숨겨집니다. 설정은 자동 저장됩니다.</p>
      </div>

      <button type="button"
              onclick="closeConfig()"
              class="w-10 h-10 rounded-full bg-white border border-slate-200 shadow-sm flex items-center justify-center text-slate-500 hover:text-red-500 hover:border-red-200 transition">
        <i class="fa-solid fa-xmark"></i>
      </button>
    </div>

    <!-- body -->
    <div class="px-6 py-6">
      <!-- 3열 그리드 -->
      <div class="grid grid-cols-1 md:grid-cols-3 gap-3">

        <!-- ===== Space Work Scanner ===== -->
        <!-- Widgets 보기 설정 (Sales / Contract / Project) -->
        <div class="md:col-span-3 grid grid-cols-1 md:grid-cols-3 gap-3">

          <!-- Sales 보기 설정 -->
          <div class="p-4 rounded-2xl border border-slate-200 bg-slate-50">
            <p class="text-xs text-slate-600 font-extrabold">
              <i class="fa-solid fa-chart-line"></i> Sales 보기 설정
            </p>

            <div class="mt-3 flex items-center gap-4">
              <label class="flex items-center gap-2 text-[12px] font-extrabold text-slate-700">
                <input type="radio" name="salesViewModeModal" value="one" onchange="setSalesViewMode('one')" class="w-4 h-4 accent-blue-600">
                1개만
              </label>
              <label class="flex items-center gap-2 text-[12px] font-extrabold text-slate-700">
                <input type="radio" name="salesViewModeModal" value="many" onchange="setSalesViewMode('many')" class="w-4 h-4 accent-blue-600">
                여러개
              </label>
            </div>

            <select id="sales-limit-modal" onchange="setSalesLimit(this.value)"
                    class="mt-3 w-full text-[12px] font-extrabold border border-slate-200 rounded-xl px-3 py-2 text-slate-900 bg-white">
              <option value="1">1개</option><option value="2">2개</option><option value="3">3개</option>
              <option value="4">4개</option><option value="5">5개</option><option value="6">6개</option>
            </select>
            <p class="text-[11px] text-slate-400 font-semibold mt-2">* 1개만 선택 시 비활성화</p>
          </div>

          <!-- Contract 보기 설정 -->
          <div class="p-4 rounded-2xl border border-slate-200 bg-slate-50">
            <p class="text-xs text-slate-600 font-extrabold">
              <i class="fa-solid fa-file-signature"></i> Contract 보기 설정
            </p>

            <div class="mt-3 flex items-center gap-4">
              <label class="flex items-center gap-2 text-[12px] font-extrabold text-slate-700">
                <input type="radio" name="contractViewModeModal" value="one" onchange="setContractViewMode('one')" class="w-4 h-4 accent-blue-600">
                1개만
              </label>
              <label class="flex items-center gap-2 text-[12px] font-extrabold text-slate-700">
                <input type="radio" name="contractViewModeModal" value="many" onchange="setContractViewMode('many')" class="w-4 h-4 accent-blue-600">
                여러개
              </label>
            </div>

            <select id="contract-limit-modal" onchange="setContractLimit(this.value)"
                    class="mt-3 w-full text-[12px] font-extrabold border border-slate-200 rounded-xl px-3 py-2 text-slate-900 bg-white">
              <option value="1">1개</option><option value="2">2개</option><option value="3">3개</option>
              <option value="4">4개</option><option value="5">5개</option><option value="6">6개</option>
            </select>
            <p class="text-[11px] text-slate-400 font-semibold mt-2">* 1개만 선택 시 비활성화</p>
          </div>

          <!-- Project 보기 설정 -->
          <div class="p-4 rounded-2xl border border-slate-200 bg-slate-50">
            <p class="text-xs text-slate-600 font-extrabold">
              <i class="fa-solid fa-diagram-project"></i> Project 보기 설정
            </p>

            <div class="mt-3 flex items-center gap-4">
              <label class="flex items-center gap-2 text-[12px] font-extrabold text-slate-700">
                <input type="radio" name="projViewModeModal" value="one" onchange="setProjectViewMode('one')" class="w-4 h-4 accent-blue-600">
                1개만
              </label>
              <label class="flex items-center gap-2 text-[12px] font-extrabold text-slate-700">
                <input type="radio" name="projViewModeModal" value="many" onchange="setProjectViewMode('many')" class="w-4 h-4 accent-blue-600">
                여러개
              </label>
            </div>

            <select id="proj-limit-modal" onchange="setProjectLimit(this.value)"
                    class="mt-3 w-full text-[12px] font-extrabold border border-slate-200 rounded-xl px-3 py-2 text-slate-900 bg-white">
              <option value="1">1개</option><option value="2">2개</option><option value="3">3개</option>
              <option value="4">4개</option><option value="5">5개</option><option value="6">6개</option>
            </select>
            <p class="text-[11px] text-slate-400 font-semibold mt-2">* 1개만 선택 시 비활성화</p>
          </div>

        </div>


        <!-- Divider -->
        <div class="md:col-span-3">
          <div class="h-px bg-slate-200 my-2"></div>
        </div>

        <!-- ===== Quick menu ===== -->
        <div class="md:col-span-3 flex items-center justify-between pt-1">
          <p class="text-xs text-slate-500 font-extrabold tracking-wide">
            <i class="fa-solid fa-bolt"></i> Quick menu
          </p>
          <span class="text-[11px] text-slate-400 font-semibold">Bottom Cards</span>
        </div>

        <!-- 고객 관리 -->
        <label class="flex items-center gap-2 p-3 rounded-2xl border border-slate-200 bg-white hover:bg-slate-50 cursor-pointer">
          <input type="checkbox" checked data-toggle-target="card-customer"
                 onchange="toggleView('card-customer', this)"
                 class="w-4 h-4 accent-blue-600">
          <span class="text-sm font-extrabold text-slate-700">고객 관리</span>
        </label>

        <!-- 영업 관리 -->
        <label class="flex items-center gap-2 p-3 rounded-2xl border border-slate-200 bg-white hover:bg-slate-50 cursor-pointer">
          <input type="checkbox" checked data-toggle-target="card-sales"
                 onchange="toggleView('card-sales', this)"
                 class="w-4 h-4 accent-blue-600">
          <span class="text-sm font-extrabold text-slate-700">영업 관리</span>
        </label>

        <!-- 계약 관리 -->
        <label class="flex items-center gap-2 p-3 rounded-2xl border border-slate-200 bg-white hover:bg-slate-50 cursor-pointer">
          <input type="checkbox" checked data-toggle-target="card-contract"
                 onchange="toggleView('card-contract', this)"
                 class="w-4 h-4 accent-blue-600">
          <span class="text-sm font-extrabold text-slate-700">계약 관리</span>
        </label>

        <!-- 프로젝트 -->
        <label class="flex items-center gap-2 p-3 rounded-2xl border border-slate-200 bg-white hover:bg-slate-50 cursor-pointer">
          <input type="checkbox" checked data-toggle-target="card-project"
                 onchange="toggleView('card-project', this)"
                 class="w-4 h-4 accent-blue-600">
          <span class="text-sm font-extrabold text-slate-700">프로젝트</span>
        </label>

        <!-- 청구/정산 -->
        <label class="flex items-center gap-2 p-3 rounded-2xl border border-slate-200 bg-white hover:bg-slate-50 cursor-pointer">
          <input type="checkbox" checked data-toggle-target="card-billing"
                 onchange="toggleView('card-billing', this)"
                 class="w-4 h-4 accent-blue-600">
          <span class="text-sm font-extrabold text-slate-700">청구/정산</span>
        </label>

        <!-- 직원 관리 -->
        <label class="flex items-center gap-2 p-3 rounded-2xl border border-slate-200 bg-white hover:bg-slate-50 cursor-pointer">
          <input type="checkbox" checked data-toggle-target="card-user"
                 onchange="toggleView('card-user', this)"
                 class="w-4 h-4 accent-blue-600">
          <span class="text-sm font-extrabold text-slate-700">직원 관리</span>
        </label>

        <!-- AI 회의록 (전체 폭 추천) -->
        <label class="md:col-span-3 flex items-center gap-2 p-3 rounded-2xl border border-slate-200 bg-white hover:bg-slate-50 cursor-pointer">
          <input type="checkbox" checked data-toggle-target="card-meeting"
                 onchange="toggleView('card-meeting', this)"
                 class="w-4 h-4 accent-blue-600">
          <span class="text-sm font-extrabold text-slate-700">AI 회의록</span>
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

        <!-- 설정은 브라우저에 저장되며( localStorage ), 같은 PC/브라우저에서 유지됩니다. -->

    </div>
  </div>
</div>
