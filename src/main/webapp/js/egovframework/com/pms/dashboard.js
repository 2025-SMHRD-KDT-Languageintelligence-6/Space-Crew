/* =========================================================
   Space-PMS Dashboard.js (정리본)
   - 카드/섹션/위젯 표시 토글(보였다/안보였다) 통합
   - localStorage 저장/복원
   - 알림 패널 열기/닫기(open)
   - 알림 폴링(fetchLatestNotifications) + 카드 클릭 이동
   ========================================================= */

/* =====================
   0. 공통 유틸
===================== */
function $(sel) { return document.querySelector(sel); }
function $all(sel) { return document.querySelectorAll(sel); }

/* localStorage key prefix */
const VIEW_KEY_PREFIX = "view:";

/* =====================
   1. 기본 UI 제어
===================== */
function openConfig() {
  const modal = document.getElementById("config-modal");
  if (modal) modal.classList.remove("hidden");
  syncProjectControls();
}

function closeConfig() {
  const modal = document.getElementById("config-modal");
  if (modal) modal.classList.add("hidden");
}

/* 알림 패널 슬라이드 토글 */
function toggleNotifications() {
  const panel = document.getElementById("notification-panel");
  if (panel) panel.classList.toggle("open");
}

/* ==============================
   2. 표시 토글(보였다/안보였다)
   - 카드/섹션/위젯 공통
============================== */
function setViewVisible(targetId, isVisible) {
  const el = document.getElementById(targetId);
  if (!el) return;
  el.classList.toggle("hidden-element", !isVisible);
}

/**
 * 체크박스 onchange용 (customize.jsp에서 호출)
 * 예: onchange="toggleView('card-project', this)"
 */
function toggleView(targetId, checkbox) {
  const isVisible = !!checkbox.checked;
  setViewVisible(targetId, isVisible);
  localStorage.setItem(VIEW_KEY_PREFIX + targetId, isVisible ? "1" : "0");
}

/**
 * data-toggle-target 속성을 가진 체크박스들을 읽어서
 * localStorage 저장값으로 표시 상태 복원
 *
 * 체크박스 예:
 * <input type="checkbox" data-toggle-target="card-project" checked ...>
 */
function restoreViews() {
  const inputs = document.querySelectorAll("input[type='checkbox'][data-toggle-target]");
  inputs.forEach((input) => {
    const targetId = input.dataset.toggleTarget;
    if (!targetId) return;

    const saved = localStorage.getItem(VIEW_KEY_PREFIX + targetId);

    // 저장값 있으면 우선 적용
    if (saved === "0" || saved === "1") {
      input.checked = (saved === "1");
    }

    setViewVisible(targetId, input.checked);
  });
}

/* "설정 저장" 버튼용 (원하시면 토스트도 띄움) */
function saveConfig() {
  closeConfig();
  showTopNotification("설정이 실시간으로 대시보드에 반영되었습니다.");
}

/* =====================
   3. 토스트 알림
===================== */
function showTopNotification(message) {
  const toast = document.getElementById("toast");
  if (!toast) return;

  toast.innerText = "✅ " + message;
  toast.classList.remove("hidden");

  setTimeout(() => {
    toast.classList.add("hidden");
  }, 3000);
}

/* ==========================
   4. 알림 배지(숫자) 업데이트
   - 현재 DOM 구조에 맞춰 selector를 하나만 쓰는 편이 안전
   - 권장: 배지 span에 id="noti-badge" 부여
========================== */
function updateNotificationBadge(addCount) {
  const badge = document.getElementById("noti-badge") || $(".text-sm.font-black.text-blue-600");
  const notiBtn = document.getElementById("noti-btn");

  if (badge) {
    const currentCount = parseInt((badge.innerText || "0").replace(/,/g, ""), 10) || 0;
    const next = currentCount + (addCount || 0);
    badge.innerText = String(next);
  }

  // 숫자가 0보다 크면 알림 버튼의 점(있는 경우) 표시
  if (notiBtn) {
    const redDots = notiBtn.querySelectorAll("span");
    redDots.forEach(dot => dot.classList.remove("hidden"));
  }
}

/* ==========================
   5. 우측 알림 카드 추가
   - salesId 있으면 상세로 이동 가능
========================== */
function appendNotificationCard(message, salesId) {
  const panelBody = $("#notification-panel .overflow-y-auto");
  if (!panelBody) return;

  // "알림 없음" 같은 안내 문구가 있으면 초기화
  const emptyMsg = panelBody.querySelector(".text-slate-400");
  if (emptyMsg) panelBody.innerHTML = "";

  const card = document.createElement("div");
  card.className =
    "p-4 bg-orange-50 rounded-[1.5rem] border border-orange-100 animate-fade-in mb-4 " +
    (salesId ? "cursor-pointer hover:bg-orange-100 transition-all" : "");

  if (salesId) {
    card.onclick = function () {
      location.href = `/pms/salesDetail.do?salesId=${encodeURIComponent(salesId)}`;
    };
  }

  card.innerHTML = `
    <div class="flex justify-between items-start">
      <div>
        <p class="text-[10px] font-bold text-orange-600 uppercase mb-2">${salesId ? "New Sales Item" : "New Update"}</p>
        <p class="text-[11px] text-orange-800 font-bold leading-relaxed">${message}</p>
      </div>
      ${salesId ? `<i class="fas fa-chevron-right text-[10px] text-orange-300 mt-1"></i>` : ""}
    </div>
  `;

  panelBody.prepend(card);
}

/* ==========================
   6. 서버 통신(알림 폴링)
========================== */
async function fetchLatestNotifications() {
  try {
    const response = await fetch("/pms/api/latest-alerts.do", {
      method: "GET",
      headers: { "Accept": "application/json" }
    });

    if (!response.ok) return;

    const data = await response.json();

    if (data && data.hasChange) {
      showTopNotification(data.message || "새 알림이 도착했습니다.");
      appendNotificationCard(data.message || "새 알림", data.salesId);
      updateNotificationBadge(data.newCount || 1);
    }
  } catch (error) {
    console.warn("알림 데이터 로드 실패:", error);
  }
}

/* ==========================
   7. 읽음 처리(패널 비우기)
========================== */
function clearNotifications() {
  const panelBody = $("#notification-panel .overflow-y-auto");
  if (panelBody) {
    panelBody.innerHTML = `
      <div class="p-8 text-center">
        <p class="text-xs text-slate-400 font-medium">읽지 않은 알림이 없습니다.</p>
      </div>
    `;
  }

  // 배지 0 초기화
  const badge = document.getElementById("noti-badge") || $(".text-sm.font-black.text-blue-600");
  if (badge) badge.innerText = "0";

  // 버튼 점 숨기기
  const redDots = $all("#noti-btn span");
  redDots.forEach(dot => dot.classList.add("hidden"));

  console.log("모든 알림이 읽음 처리되었습니다.");
}

/* ==========================
   8. 초기화
========================== */
function initDashboard() {
  // (1) 저장된 표시 설정 복원
  restoreViews();

  // (2) 초기 알림 카운트가 있다면 활용 (전역 변수)
  if (typeof GLOBAL_NOTI_COUNT !== "undefined" && GLOBAL_NOTI_COUNT > 0) {
    console.log("읽지 않은 초기 알림:", GLOBAL_NOTI_COUNT);
  }

    syncProjectControls();
    renderProjects();

  // (3) 폴링 시작(10초)
  setInterval(fetchLatestNotifications, 10000);
}

window.addEventListener("DOMContentLoaded", initDashboard);

/* ==========================
   전역 노출 (JSP inline 호출용)
   - onchange="toggleView(...)" 같은 호출을 위해 필요
========================== */
window.openConfig = openConfig;
window.closeConfig = closeConfig;
window.saveConfig = saveConfig;
window.toggleNotifications = toggleNotifications;
window.toggleView = toggleView;
window.clearNotifications = clearNotifications;

/* ==========================
   Project Analysis (더미)
========================== */
const DUMMY_PROJECTS = [
  { id: 101, name: "Space-PMS 고도화", owner: "이수진", progress: 72, status: "진행중", due: "2026-03-15" },
  { id: 102, name: "전남 테크노파크 유지보수", owner: "박현우", progress: 45, status: "진행중", due: "2026-02-28" },
  { id: 103, name: "AI 회의록 고도화", owner: "정종혁", progress: 88, status: "리뷰중", due: "2026-02-20" },
  { id: 104, name: "영업 대시보드 리뉴얼", owner: "염해명", progress: 33, status: "기획", due: "2026-03-05" },
  { id: 105, name: "계약 OCR 파이프라인", owner: "신창용", progress: 60, status: "진행중", due: "2026-03-10" },
  { id: 106, name: "알림 센터 개선", owner: "박현우", progress: 25, status: "백로그", due: "2026-03-25" },
];

let projectViewMode = localStorage.getItem("proj:viewMode") || "one"; // one | many
let projectLimit = parseInt(localStorage.getItem("proj:limit") || "3", 10);

function setProjectViewMode(mode) {
  projectViewMode = (mode === "many") ? "many" : "one";
  localStorage.setItem("proj:viewMode", projectViewMode);
  renderProjects();
}

function setProjectLimit(limit) {
  const n = parseInt(limit, 10);
  projectLimit = Number.isFinite(n) ? Math.max(1, Math.min(6, n)) : 3;
  localStorage.setItem("proj:limit", String(projectLimit));
  renderProjects();
}

function renderProjects() {
  const listEl = document.getElementById("proj-list");
  const avgEl = document.getElementById("proj-avg");

  if (!listEl) return;

  // 평균(더미)
  if (avgEl) {
    const avg = Math.round(DUMMY_PROJECTS.reduce((a, p) => a + p.progress, 0) / DUMMY_PROJECTS.length);
    avgEl.innerText = avg + "%";
  }

  // 모드에 따른 대상 리스트
  const visibleCount = (projectViewMode === "one") ? 1 : projectLimit;
  const items = DUMMY_PROJECTS.slice(0, visibleCount);



  // 렌더
  listEl.innerHTML = items.map(p => `
    <div class="p-3 rounded-2xl border border-slate-200 bg-white hover:bg-slate-50 transition">
      <div style="display:flex; align-items:flex-start; justify-content:space-between; gap:12px;">
        <div>
          <div style="font-weight:800; font-size:13px; color:#0f172a;">${escapeHtml(p.name)}</div>
          <div style="margin-top:4px; font-size:11px; color:#64748b;">
            담당: ${escapeHtml(p.owner)} · 상태: ${escapeHtml(p.status)} · 마감: ${escapeHtml(p.due)}
          </div>
        </div>
        <div style="font-weight:900; font-size:12px; color:#2563eb;">${p.progress}%</div>
      </div>

      <div style="margin-top:10px; height:8px; background:#e2e8f0; border-radius:999px; overflow:hidden;">
        <div style="height:100%; width:${p.progress}%; background:#2563eb;"></div>
      </div>
    </div>

  `).join("");
    // 모달 컨트롤 UI 동기화
    syncProjectControls();
}

// XSS 방지용 최소 escape
function escapeHtml(str) {
  return String(str)
    .replaceAll("&", "&amp;")
    .replaceAll("<", "&lt;")
    .replaceAll(">", "&gt;")
    .replaceAll('"', "&quot;")
    .replaceAll("'", "&#039;");
}



/* 전역 노출 (JSP inline onchange에서 호출) */
window.setProjectViewMode = setProjectViewMode;
window.setProjectLimit = setProjectLimit;

function syncProjectControls() {
  // (1) 모달 라디오 동기화
  const modalRadios = document.querySelectorAll("input[name='projViewModeModal']");
  modalRadios.forEach(r => (r.checked = (r.value === projectViewMode)));

  // (2) 모달 select 동기화
  const limitModal = document.getElementById("proj-limit-modal");
  if (limitModal) {
    limitModal.value = String(projectLimit);
    limitModal.disabled = (projectViewMode === "one");
    limitModal.style.opacity = (projectViewMode === "one") ? "0.5" : "1";
    limitModal.style.cursor = (projectViewMode === "one") ? "not-allowed" : "pointer";
  }
}
