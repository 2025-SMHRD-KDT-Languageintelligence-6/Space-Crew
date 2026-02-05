/* --- [1. 기본 UI 제어 함수] --- */
function openConfig() {
    document.getElementById('config-modal').classList.remove('hidden');
}

function closeConfig() {
    document.getElementById('config-modal').classList.add('hidden');
}

function toggleNotifications() {
    const panel = document.getElementById('notification-panel');
    if(panel) {
        panel.classList.toggle('open');
    }
}

function updateView(id, checkbox) {
    const target = document.getElementById(id);
    if(target) {
        checkbox.checked ? target.classList.remove('hidden-element') : target.classList.add('hidden-element');
    }
}

/* --- [2. 알림 표시 및 업데이트 로직] --- */

// 상단 토스트 알림
function showTopNotification(message) {
    const toast = document.getElementById('toast');
    if (toast) {
        toast.innerText = "✅ " + message;
        toast.classList.remove('hidden');
        setTimeout(() => { toast.classList.add('hidden'); }, 3000);
    }
}

// 헤더의 파란색 숫자 배지 업데이트
function updateNotificationBadge(addCount) {
    const badge = document.querySelector('.text-sm.font-black.text-blue-600');
    const notiBtn = document.getElementById('noti-btn');

    if (badge) {
        let currentCount = parseInt(badge.innerText.replace(/,/g, '')) || 0;
        badge.innerText = currentCount + addCount;

        // 숫자가 0보다 크면 알림 버튼의 빨간 점(ping) 보이기
        if (notiBtn) {
            const redDots = notiBtn.querySelectorAll('span');
            redDots.forEach(dot => dot.classList.remove('hidden'));
        }
    }
}


// 우측 알림창에 카드 추가
function appendNotificationCard(message) {
    const panelBody = document.querySelector('#notification-panel .overflow-y-auto');
    if (!panelBody) return;

    // "알림이 없습니다" 문구가 있다면 제거
    if (panelBody.querySelector('.text-slate-400')) {
        panelBody.innerHTML = '';
    }

    const newCard = document.createElement('div');
    newCard.className = "p-4 bg-orange-50 rounded-[1.5rem] border border-orange-100 animate-fade-in mb-4";
    newCard.innerHTML = `
        <p class="text-[10px] font-bold text-orange-600 uppercase mb-2">New Update</p>
        <p class="text-[11px] text-orange-800 font-bold leading-relaxed">${message}</p>
    `;

    panelBody.prepend(newCard);
}

/* --- [3. 서버 통신 로직] --- */

/* 수정된 fetch 함수 */
async function fetchLatestNotifications() {
    try {
        const response = await fetch('/pms/api/latest-alerts.do');
        const data = await response.json();

        if (data.hasChange) {
            showTopNotification(data.message);
            // salesId를 함께 전달합니다.
            appendNotificationCard(data.message, data.salesId);
            updateNotificationBadge(data.newCount || 1);
        }
    } catch (error) {
        console.warn("알림 데이터 로드 실패:", error);
    }
}

/* 수정된 카드 생성 함수 */
function appendNotificationCard(message, salesId) {
    const panelBody = document.querySelector('#notification-panel .overflow-y-auto');
    if (!panelBody) return;

    if (panelBody.querySelector('.text-slate-400')) {
        panelBody.innerHTML = '';
    }

    const newCard = document.createElement('div');
    // 클릭 커서 모양(cursor-pointer)과 호버 효과 추가
    newCard.className = "p-4 bg-orange-50 rounded-[1.5rem] border border-orange-100 animate-fade-in mb-4 cursor-pointer hover:bg-orange-100 transition-all";

    // 클릭 시 상세 페이지로 이동하는 이벤트 리스너 추가
    newCard.onclick = function() {
        location.href = `/pms/salesDetail.do?salesId=${salesId}`;
    };

    newCard.innerHTML = `
        <div class="flex justify-between items-start">
            <div>
                <p class="text-[10px] font-bold text-orange-600 uppercase mb-2">New Sales Item</p>
                <p class="text-[11px] text-orange-800 font-bold leading-relaxed">${message}</p>
            </div>
            <i class="fas fa-chevron-right text-[10px] text-orange-300 mt-1"></i>
        </div>
    `;

    panelBody.prepend(newCard);
}

/* --- [4. 초기화 및 읽음 처리 로직] --- */

function clearNotifications() {
    // 1. 우측 패널 카드 삭제
    const panelBody = document.querySelector('#notification-panel .overflow-y-auto');
    if (panelBody) {
        panelBody.innerHTML = `
            <div class="p-8 text-center">
                <p class="text-xs text-slate-400 font-medium">읽지 않은 알림이 없습니다.</p>
            </div>
        `;
    }

    // 2. 헤더 숫자 0으로 초기화
    const badge = document.querySelector('.text-sm.font-black.text-blue-600');
    if (badge) badge.innerText = "0";

    // 3. 알림 버튼의 빨간 점 숨기기
    const redDots = document.querySelectorAll('#noti-btn span');
    redDots.forEach(dot => dot.classList.add('hidden'));

    console.log("모든 알림이 읽음 처리되었습니다.");
}

function saveAndToast() {
    closeConfig();
    showTopNotification("설정이 실시간으로 대시보드에 반영되었습니다.");
}

/* --- [5. 페이지 로드 시 실행] --- */
window.onload = function() {
    // 초기 알림 체크 (JSP 전역 변수 활용)
    if (typeof GLOBAL_NOTI_COUNT !== 'undefined' && GLOBAL_NOTI_COUNT > 0) {
        console.log("읽지 않은 초기 알림:", GLOBAL_NOTI_COUNT);
    }

    // 10초마다 서버 확인 (테스트를 위해 10초로 설정하신 것을 유지했습니다)
    setInterval(fetchLatestNotifications, 10000);
};


/* =====================
   대시보드 설정 모달
===================== */

function openConfig() {
  document.getElementById('config-modal').classList.remove('hidden');
}

function closeConfig() {
  document.getElementById('config-modal').classList.add('hidden');
}

/* 카드 ON/OFF */
function toggleCard(cardId, checkbox) {
  const card = document.getElementById(cardId);
  if (!card) return;

  card.style.display = checkbox.checked ? '' : 'none';
  localStorage.setItem(cardId, checkbox.checked ? '1' : '0');
}

/* 저장 후 닫기 */
function saveConfig() {
  closeConfig();
}

/* 페이지 로드시 설정 복원 */
window.addEventListener('DOMContentLoaded', () => {
  document.querySelectorAll('.config-item input').forEach(input => {
    const cardId = input.getAttribute('onchange')
      .match(/'(.+?)'/)[1];

    const saved = localStorage.getItem(cardId);
    if (saved === '0') {
      input.checked = false;
      const card = document.getElementById(cardId);
      if (card) card.style.display = 'none';
    }
  });
});
