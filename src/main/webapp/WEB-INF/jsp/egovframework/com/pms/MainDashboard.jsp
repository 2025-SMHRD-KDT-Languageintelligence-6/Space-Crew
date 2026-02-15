<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Space-PMS | 지능형 통합 대시보드</title>

<script src="https://cdn.tailwindcss.com"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

<link rel="stylesheet"
	href="<c:url value='/css/egovframework/com/dashboard.css'/>">
</head>


<body>
	<c:import url="/WEB-INF/jsp/egovframework/com/pms/include/menu.jsp" />

	<div class="content-page animate-fade-in">

		<!-- 헤더(기존 header 클래스 기반) -->
		<div class="header">
			<div class="header-title">
				<h1>🚀 Space-PMS Dashboard</h1>
				<p>AI기반 지능형 프로젝트 관리 시스템</p>
			</div>


			<div class="header-actions">
				<!-- 알림바(기능 유지: CSS로만 꾸미게 됨) -->
				<div class="noti-bar">
					<div class="noti-meta">
						<span class="noti-label">미확인 알림</span> <span class="noti-divider"></span>
						<span id="noti-badge" class="noti-count"> <c:out
								value="${notificationCount != null ? notificationCount : 0}" />
						</span>
					</div>

					<button id="noti-btn" data-count="${notificationCount}"
						onclick="toggleNotifications()" class="noti-btn" type="button">
						<i class="fa-solid fa-bell"></i>
						<c:if test="${notificationCount > 0}">
							<span class="noti-dot"></span>
						</c:if>
					</button>

					<button type="button" class="config-btn" onclick="openConfig()"
						title="대시보드 설정">
						<i class="fa-solid fa-gear"></i>
					</button>

				</div>
			</div>
		</div>

		<!-- 상단 위젯(기존 CSS에 없으므로, 최소구성으로만 유지) -->
		<div class="section-title">
			<span class="section-bar"></span>
			<h2>
				<i class="fa-solid fa-satellite-dish"></i> Space Work Scanner
			</h2>
		</div>
		<section id="sec-process" class="section">


			<div class="widget-grid">

				<!-- Sales Intelligence -->
				<div id="w-sales" class="widget card-hover">
					<div class="widget-head">
						<h3>Sales Intelligence</h3>
					</div>
					<div class="widget-body">
						<%-- <div class="row">
		        <span id="top-sales-nm">
		            <c:choose>
		                <c:when test="${not empty favSalesList}">
		                    <c:out value="${favSalesList[0].salesTitle}" />
		                </c:when>
		                <c:otherwise>영업 기회를 선택하세요</c:otherwise>
		            </c:choose>
		        </span>
		        <span class="accent" id="top-sales-win">
		            <c:out value="${not empty favSalesList ? favSalesList[0].probability : 0}" />%
		        </span>
		    </div>
		    <div class="progress">
		        <div class="progress-bar" id="top-sales-bar" style="width:${not empty favSalesList ? favSalesList[0].probability : 0}%"></div>
		    </div> --%>
						<div id="sales-list" class="space-y-2 mt-3"></div>
					</div>

					<!-- 더미 리스트 렌더 영역 -->

				</div>

				<!-- Contract Status -->
				<div id="w-contract" class="widget card-hover">
					<div class="widget-head">
						<h3>Contract Status</h3>
					</div>
					<div class="widget-body">
						<div id="contract-list" class="space-y-2 mt-3"></div>
						<%-- <p class="muted">최근 즐겨찾기 계약</p>
		    <p id="top-contract-summary" class="accent">
		        <c:choose>
		            <c:when test="${not empty favContractList}">
		                <c:out value="${favContractList[0].contStatus}" /> · <c:out value="${favContractList[0].contNm}" />
		            </c:when>
		            <c:otherwise>진행 중인 계약이 없습니다.</c:otherwise>
		        </c:choose>
		    </p> --%>
					</div>
				</div>

				<!-- Project Analysis -->
				<div id="w-project" class="widget card-hover">
					<div class="widget-head"
						style="display: flex; align-items: center; justify-content: space-between; gap: 12px;">
						<h3>Project Analysis</h3>
					</div>

					<div class="widget-body">
						<div id="proj-list" class="space-y-2 mt-3"></div>
						<%-- <div class="row" style="margin-bottom:10px;">
		        <span>평균 기간 경과율</span>
		        <span class="accent" id="proj-avg">
		            <c:if test="${not empty favProjectList}">
		                <c:out value="${favProjectList[0].progressRate}" />%
		            </c:if>
		            <c:if test="${empty favProjectList}">0%</c:if>
		        </span>
		    </div> --%>
					</div>
				</div>

			</div>
		</section>

		<!-- 하단 메뉴 카드 -->
		<div class="section-title">
			<span class="section-bar"></span>
			<h2>
				<i class="fa-solid fa-bolt"></i> Quick menu
			</h2>
		</div>

		<div class="dashboard-grid">
			<a id="card-customer" href="<c:url value='/pms/customerList.do'/>"
				class="card card-hover">
				<h3>
					<i class="fa-solid fa-address-card"></i> 고객 관리
				</h3>
				<p>고객사 정보 및 담당자 관리</p>
			</a> <a id="card-sales" href="<c:url value='/pms/salesList.do'/>"
				class="card card-hover">
				<h3>
					<i class="fa-solid fa-chart-line"></i> 영업 관리
				</h3>
				<p>영업 기회 및 수주 확률 관리</p>
			</a> <a id="card-contract" href="<c:url value='/pms/contractList.do'/>"
				class="card card-hover">
				<h3>
					<i class="fa-solid fa-file-signature"></i> 계약 관리
				</h3>
				<p>체결된 계약서 및 조건 관리</p>
			</a> <a id="card-project" href="<c:url value='/pms/projectList.do'/>"
				class="card card-hover">
				<h3>
					<i class="fa-solid fa-diagram-project"></i> 프로젝트 관리
				</h3>
				<p>수행 중인 프로젝트 현황</p> <span class="stat">${projectCount}건</span>
			</a> <a id="card-billing" href="<c:url value='/pms/billingList.do'/>"
				class="card card-hover">
				<h3>
					<i class="fa-solid fa-file-invoice-dollar"></i> 청구/정산
				</h3>
				<p>세금계산서 발행 및 입금 확인</p> <span class="stat">${billingCount}건</span>
			</a> <a id="card-user" href="<c:url value='/pms/userList.do'/>"
				class="card card-hover">
				<h3>
					<i class="fa-solid fa-user-tie"></i> 직원 관리
				</h3>
				<p>내부 인력 및 조직 관리</p>
			</a> <a id="card-meeting" href="<c:url value='/pms/meetingList.do'/>"
				class="card card-hover">
				<h3>
					<i class="fa-solid fa-microphone"></i> AI 회의록
				</h3>
				<p>회의록 분석</p>
			</a>

		</div>
	</div>

	<c:import
		url="/WEB-INF/jsp/egovframework/com/pms/include/notification.jsp" />
	<c:import url="/WEB-INF/jsp/egovframework/com/pms/customize.jsp" />

	<script src="<c:url value='/js/egovframework/com/pms/dashboard.js'/>"></script>
	<script>
	    console.log("리스크 알림 데이터 존재 여부: ${not empty riskAlertList}");
	</script>
	<script>

    const REAL_FAV_SALES = [
        <c:forEach var="s" items="${favSalesList}" varStatus="status">
        { 
        	salesId: "${s.salesId}",
        	title: "${s.salesTitle}", 
            status: "${s.status}", 
            due: "${s.expectedDt}",
            win: "${s.probability != null ? s.probability : 0}"
        }${!status.last ? ',' : ''}
        </c:forEach>
    ];
    
    const REAL_FAV_CONTRACTS = [
        <c:forEach var="c" items="${favContractList}" varStatus="status">
        { 
        	contId: "${c.contId}",
        	contNm: "${c.contNm}", 
            status: "${c.contStatus}", 
            amt: "<fmt:formatNumber value='${c.contAmt}' type='number'/>",
            date: "${c.endDt}" 
        }${!status.last ? ',' : ''}
        </c:forEach>
    ];
    
    const REAL_FAV_PROJECTS = [
        <c:forEach var="p" items="${favProjectList}" varStatus="status">
        { 
            projId: "${p.projId}",
        	projNm: "${p.projNm}", 
            status: "${p.status}", 
            pRate: "${p.progressRate != null ? p.progressRate : 0}", 
            actualRate: "${not empty p.actualProgressRate ? p.actualProgressRate : 0}",
            start: "${p.startDt}", 
            end: "${p.endDt}" 
        }${!status.last ? ',' : ''}
        </c:forEach>
    ];
    
    function renderSalesReal() {
        var listEl = document.getElementById("sales-list");
        var topNm = document.getElementById("top-sales-nm");
        var topWin = document.getElementById("top-sales-win");
        var topBar = document.getElementById("top-sales-bar");
        if (!listEl) return;

        if (REAL_FAV_SALES.length > 0) {
            if(topNm) topNm.innerText = REAL_FAV_SALES[0].title;
            if(topWin) topWin.innerText = REAL_FAV_SALES[0].win + "%";
            if(topBar) topBar.style.width = REAL_FAV_SALES[0].win + "%";

            var html = "";
            for(var i=0; i<REAL_FAV_SALES.length; i++) {
                var s = REAL_FAV_SALES[i];
                html += '<div class="p-3 rounded-2xl border border-slate-200 bg-white mb-2 cursor-pointer hover:bg-blue-50 transition" ' +
    					'     onclick="window.open(\'/pms/salesDetailPopup.do?selectedId=' + s.salesId + '\', \'sales_pop_' + s.salesId + '\', \'width=700,height=800,resizable=yes,scrollbars=yes\')">';
                html += '  <div class="flex justify-between items-start">';
                html += '    <div class="font-bold text-[13px] text-slate-900">' + s.title + '</div>';
                html += '    <div class="text-[11px] font-black text-blue-600">예상 수주 확률 : ' + s.win + '%</div>';
                html += '  </div>';
                html += '  <div class="text-[11px] text-slate-500 mt-1">';
                html += '    상태: <span class="text-orange-600 font-bold">' + s.status + '</span> · 마감: ' + s.due;
                html += '  </div>';
                html += '</div>';
            }
            listEl.innerHTML = html;
        } else {
            listEl.innerHTML = '<p class="text-[11px] text-slate-400 p-3 text-center">즐겨찾기한 영업 건이 없습니다.</p>';
        }
    }
    
    function renderContractsReal() {
        var listEl = document.getElementById("contract-list");
        var summary = document.getElementById("top-contract-summary");
        if (!listEl) return;

        if (REAL_FAV_CONTRACTS.length > 0) {
            if(summary) summary.innerText = REAL_FAV_CONTRACTS[0].status + " · " + REAL_FAV_CONTRACTS[0].name;

            var html = "";
            for(var i=0; i<REAL_FAV_CONTRACTS.length; i++) {
                var c = REAL_FAV_CONTRACTS[i];
                html += '<div class="p-3 rounded-2xl border border-slate-200 bg-white mb-2 cursor-pointer hover:bg-blue-50 transition" ' +
    					'     onclick="window.open(\'/pms/contractDetailPopup.do?selectedId=' + c.contId + '\', \'cont_pop_' + c.contId + '\', \'width=700,height=800,resizable=yes,scrollbars=yes\')">';
                html += '  <div class="font-bold text-[13px] text-slate-900">' + c.contNm + '</div>';
                html += '  <div class="text-[11px] text-slate-500 mt-1">';
                html += '    상태: <span class="text-green-600 font-bold">' + c.status + '</span> · 금액: ' + c.amt + '원 · 마감일: ' + c.date;
                html += '  </div>';
                html += '</div>';
            }
            listEl.innerHTML = html;
        } else {
            listEl.innerHTML = '<p class="text-[11px] text-slate-400 p-3 text-center">즐겨찾기한 계약 건이 없습니다.</p>';
        }
    }
    
    function renderProjectsReal() {
        var listEl = document.getElementById("proj-list");
        if (!listEl) return;
        if (REAL_FAV_PROJECTS.length > 0) {
            var html = "";
            REAL_FAV_PROJECTS.forEach(p => {
            	const periodRate = parseFloat(p.pRate) || 0;
                const progressRate = parseFloat(p.actualRate) || 0;
                const diff = periodRate - progressRate;

                let barColor = "bg-green-500";
                let statusText = "text-green-600";

                if (diff >= 30) {
                    barColor = "bg-red-500 animate-pulse";
                    statusText = "text-red-600 font-black";
                } else if (diff >= 10) {
                    barColor = "bg-amber-500";
                    statusText = "text-amber-600 font-bold";
                }
                
            	html += '<div class="p-3 rounded-2xl border border-slate-200 bg-white mb-2 cursor-pointer hover:bg-blue-50 transition" ' +
            			'     onclick="window.open(\'/pms/projectDetailPopup.do?selectedId=' + p.projId + '\', \'proj_pop_' + p.projId + '\', \'width=700,height=900,resizable=yes,scrollbars=yes\')">';
                html += '  <div class="flex justify-between items-center mb-1">';
                html += '    <div class="font-bold text-[13px]">' + p.projNm + '</div>';
                html += '    <div class="text-[11px] ' + statusText + '">진행 ' + progressRate + '%</div>';
                html += '  </div>';
				html += '  <div class="text-[10px] text-slate-400">기간 경과: ' + periodRate + '% | ' + p.start + ' ~ ' + p.end + '</div>';
                html += '  <div class="mt-2 h-1.5 w-full bg-slate-100 rounded-full overflow-hidden">';
                
                html += '    <div class="h-full ' + barColor + '" style="width: ' + progressRate + '%"></div>';
                html += '  </div>';
                html += '</div>';
            });
            listEl.innerHTML = html;
        }else {
            listEl.innerHTML = '<p class="text-[11px] text-slate-400 p-3 text-center">즐겨찾기한 업무 건이 없습니다.</p>';
        }
    }
     

    window.addEventListener("DOMContentLoaded", function() {
        renderSalesReal();
        renderContractsReal();
        renderProjectsReal();
    });
    
    
</script>
</body>
</html>
