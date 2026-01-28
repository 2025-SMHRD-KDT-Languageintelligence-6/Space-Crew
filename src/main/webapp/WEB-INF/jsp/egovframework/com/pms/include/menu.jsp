<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%-- 사이드바 스타일 --%>
<link rel="stylesheet" href="<c:url value='/css/egovframework/com/menu_sidebar.css'/>">
<%-- 아이콘 라이브러리 --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<style>
/* [사이드바 자간 & 정렬 리셋] */
.sidebar, .sidebar * {
    /* 1. 자간을 강제로 0(표준)으로 고정 */
    letter-spacing: 0px !important; 
    
    /* 2. 테일윈드의 렌더링 방식 무력화 */
    text-rendering: auto !important;
    -webkit-font-smoothing: auto !important;
    
    /* 3. 줄 높이(Line-height)를 픽셀 단위로 강제 고정 */
    line-height: 1.2 !important; 
}

/* [부모 메뉴 정렬 정밀 교정] */
.sidebar ul.nav li a.parent-menu {
    display: flex !important;
    align-items: center !important; /* 세로 중앙 정렬 */
    height: 48px !important;        /* 높이를 픽셀로 박아버림 */
    padding: 0 16px !important;     /* 상하는 0, 좌우는 16px */
}

/* [아이콘과 텍스트 사이 간격 고정] */
.sidebar ul.nav li a i {
    width: 20px !important;         /* 아이콘 폭 고정 (정렬의 핵심!) */
    margin-right: 12px !important;  /* 아이콘과 글자 사이 간격 강제 지정 */
    text-align: center !important;
    display: inline-block !important;
}

/* [텍스트만 감싸는 span이 있다면] */
.parent-menu span {
    display: flex !important;
    align-items: center !important;
}

/* 1. 부모 항목 위치 기준점 */
.sidebar ul.nav li.has-sub {
    position: relative;
}

/* 2. 부모 메뉴: 기존 메뉴와 규격 100% 동기화 */
.sidebar ul.nav li a.parent-menu {
    display: flex !important;
    align-items: center !important;
    justify-content: space-between !important;
    padding: 12px 16px !important;
    height: 48px !important;
    color: #94a3b8 !important;
    font-size: 0.95rem !important;
    font-weight: 500 !important;
    text-decoration: none !important;
    border-radius: 10px;
    transition: all 0.25s ease;
}

/* 3. 플로팅 서브 메뉴 (공중 부양) */
.sub-nav-floating {
    display: none; /* 기본은 숨김 */
    position: absolute;
    left: 215px;      /* 사이드바와 25px 겹쳐서 마우스 이동 통로 확보 */
    top: 0;
    width: 170px;
    background: #0f172a !important; /* 사이드바 배경색과 일치 */
    border-radius: 0 12px 12px 0;
    box-shadow: 10px 5px 20px rgba(0,0,0,0.4);
    padding: 8px 0 !important;
    list-style: none !important;
    z-index: 10000;
    border: 1px solid rgba(255, 255, 255, 0.1);
}

/* 4. 마우스 호버 시 반응 */
.has-sub:hover a.parent-menu {
    background: rgba(255, 255, 255, 0.08);
    color: #ffffff !important;
    transform: translateX(5px);
}

/* ★ 핵심: 호버 시 서브메뉴 노출 ★ */
.has-sub:hover .sub-nav-floating {
    display: block !important;
}

/* 5. 서브 메뉴 내부 항목 */
.sub-nav-floating li a {
    display: flex !important;
    align-items: center;
    padding: 10px 16px !important;
    color: #94a3b8 !important;
    font-size: 0.85rem !important;
    text-decoration: none !important;
}

/* 회의록 센터 글씨 위치 교정 */
.sidebar ul.nav li a.parent-menu {
    display: flex !important;
    align-items: center !important; /* 세로 중앙 정렬 강제 */
    height: 48px !important;        /* 높이 고정 */
    line-height: normal !important; /* 테일윈드 줄간격 무력화 */
    padding: 0 16px !important;     /* 상하 패딩을 없애고 center로 정렬 */
}

/* 내부 span도 flex로 묶어서 아이콘과 글자 수평 유지 */
.sidebar ul.nav li a.parent-menu span {
    display: flex !important;
    align-items: center !important;
}


/* [핵심] 부모가 active라고 해서 서브메뉴 전체에 배경색이 들어가는 걸 방지 */
.sidebar ul.nav li.has-sub.active .sub-nav-floating li a {
    background-color: transparent !important; /* 배경색 전염 차단 */
    color: #94a3b8 !important;              /* 일단 기본 비활성 색상으로 고정 */
}

/* [개별 강조] JS에서 'sub-active' 클래스를 붙여줄 녀석만 하얗게! */
.sidebar ul.nav li.has-sub.active .sub-nav-floating li a.sub-active {
    color: #ffffff !important;
    font-weight: 700 !important;
}

/* 서브메뉴 호버는 유지 */
.sub-nav-floating li a:hover {
    background: rgba(255, 255, 255, 0.08) !important;
    color: #ffffff !important;
}
</style>
<div class="sidebar">
    <div class="logo">
        <a href="<c:url value='/pms/main.do'/>">🚀 Space PMS</a>
    </div>
    <ul class="nav">
        <li><a href="<c:url value='/pms/customerList.do'/>"><i class="fas fa-address-card mr-3"></i> 고객 관리</a></li>
        <li><a href="<c:url value='/pms/salesList.do'/>"><i class="fas fa-chart-line mr-3"></i> 영업 관리</a></li>
        <li><a href="<c:url value='/pms/contractList.do'/>"><i class="fas fa-file-signature mr-3"></i> 계약 관리</a></li>
        <li><a href="<c:url value='/pms/projectList.do'/>"><i class="fas fa-project-diagram mr-3"></i> 업무 관리</a></li>
        <li><a href="<c:url value='/pms/billingList.do'/>"><i class="fas fa-file-invoice-dollar mr-3"></i> 청구/정산 관리</a></li>
        <li><a href="<c:url value='/pms/userList.do'/>"><i class="fas fa-user-tie mr-3"></i> 직원 관리</a></li>
        <%-- <li><a href="<c:url value='/pms/meetingList.do'/>"><i class="fas fa-magic mr-3"></i> 회의록 관리</a></li>
        <li><a href="<c:url value='/pms/updateMeetingView.do'/>"><i class="fas fa-magic mr-3"></i> 회의록 분석</a></li> --%>
        <li class="has-sub">
		    <a href="javascript:void(0);" class="parent-menu">
		        <span><i class="fas fa-file-alt mr-3" style="width:20px; text-align:center;"></i> 회의록 관리</span>
		        <i class="fas fa-chevron-right sub-arrow" style="font-size:0.7em; opacity:0.5;"></i>
		    </a>
		    <ul class="sub-nav-floating">
		        <li><a href="<c:url value='/pms/meetingList.do'/>"><i class="fas fa-list-ul mr-2"></i> 회의록 아카이브</a></li>
		        <li><a href="<c:url value='/pms/updateMeetingView.do'/>"><i class="fas fa-magic mr-2"></i> AI 회의 분석</a></li>
		    </ul>
		</li>
    </ul>
    <div class="current-time-box" style="text-align: center; margin: auto 15px 20px 15px; background: rgba(0,0,0,0.2); padding: 15px; border-radius: 10px; color: #fff;">
	    <div id="sidebarDate" style="font-size: 1em; opacity: 0.8; margin-bottom: 5px;">0000-00-00</div>
	    
	    <!-- <i class="far fa-clock"></i>  -->
	    <span id="sidebarClock" style="display: block; font-size: 0.8em; margin-top: 5px;">00:00</span>
	</div>
    <a href="<c:url value='/uat/uia/actionLogout.do'/>" class="logout-btn">로그아웃</a>
</div>

<script type="text/javascript">
	document.addEventListener("DOMContentLoaded", function() {
	    const currentPath = window.location.href;
	    const menuLinks = document.querySelectorAll('.sidebar ul.nav li a');
	
	    menuLinks.forEach(link => {
	        const href = link.getAttribute('href');
	        
	        if (href && href !== "javascript:void(0);" && currentPath.includes(href)) {
	            const subNav = link.closest('.sub-nav-floating');
	            
	            if (subNav) {
	                const parentLi = subNav.closest('.has-sub');
	                if (parentLi) {
	                    parentLi.classList.add('active');
	                }
	                
	                link.classList.add('sub-active');
	            } else {
	                link.parentElement.classList.add('active');
	            }
	        }
	    });
	});
    
	    function updateSidebarClock() {
	        const now = new Date();
	        const week = ['일', '월', '화', '수', '목', '금', '토'];
	        const dayOfWeek = week[now.getDay()];
	        const hours = String(now.getHours()).padStart(2, '0');
	        const minutes = String(now.getMinutes()).padStart(2, '0');
	        const year = now.getFullYear();
	        const month = String(now.getMonth() + 1).padStart(2, '0');
	        const day = String(now.getDate()).padStart(2, '0');
	        document.getElementById('sidebarDate').innerText = year + "-" + month + "-" + day + " (" + dayOfWeek + ")";
	        document.getElementById('sidebarClock').innerText = hours + ":" + minutes;
	    }
	    updateSidebarClock();
	    setInterval(updateSidebarClock, 60000); 

</script>