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

    <link rel="stylesheet" href="<c:url value='/css/egovframework/com/dashboard.css'/>">
</head>

<body>
<c:import url="/WEB-INF/jsp/egovframework/com/pms/include/menu.jsp" />

<div class="content-page animate-fade-in">

    <!-- 헤더(기존 header 클래스 기반) -->
    <div class="header">
        <div>
            <h1>🚀 Space-PMS Dashboard</h1>
            <p>AI기반 지능형 프로젝트 관리 시스템</p>
        </div>

        <!-- 알림바(기능 유지: CSS로만 꾸미게 됨) -->
        <div class="noti-bar">
            <div class="noti-meta">
                <span class="noti-label">미확인 알림</span>
                <span class="noti-divider"></span>
                <span class="noti-count">
                    <c:out value="${notificationCount != null ? notificationCount : 0}" />
                </span>
            </div>

            <button id="noti-btn" data-count="${notificationCount}" onclick="toggleNotifications()" class="noti-btn" type="button">
              <i class="fa-solid fa-bell"></i>
              <c:if test="${notificationCount > 0}">
                <span class="noti-dot"></span>
              </c:if>
            </button>

        </div>
    </div>

    <!-- 상단 위젯(기존 CSS에 없으므로, 최소구성으로만 유지) -->
    <section class="section">
        <div class="section-title">
            <span class="section-bar"></span>
            <h2>지능형 프로세스 모니터링</h2>
        </div>

        <div class="widget-grid">
            <div id="w-sales" class="widget card-hover">
                <div class="widget-head">
                    <h3>Sales Intelligence</h3>
                </div>
                <div class="widget-body">
                    <div class="row">
                        <span>AI 통합 플랫폼 수주 확률</span>
                        <span class="accent">85%</span>
                    </div>
                    <div class="progress">
                        <div class="progress-bar" style="width:85%"></div>
                    </div>
                </div>
            </div>

            <div id="w-contract" class="widget card-hover">
                <div class="widget-head">
                    <h3>Contract Status</h3>
                </div>
                <div class="widget-body">
                    <p class="muted">최근 체결 완료</p>
                    <p id="w-contract-detail" class="accent">전남 테크노파크 유지보수 계약</p>
                </div>
            </div>

            <div id="w-project" class="widget card-hover">
                <div class="widget-head">
                    <h3>Project Analysis</h3>
                </div>
                <div class="widget-body">
                    <div class="row">
                        <span>Space-PMS 고도화</span>
                        <span class="accent">72%</span>
                    </div>
                    <div class="progress">
                        <div class="progress-bar" style="width:72%"></div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- 하단 메뉴 카드 -->
    <div class="dashboard-grid">
        <a href="<c:url value='/pms/customerList.do'/>" class="card card-hover">
            <h3>고객 관리</h3>
            <p>고객사 정보 및 담당자 관리</p>
        </a>

        <a href="<c:url value='/pms/salesList.do'/>" class="card card-hover">
            <h3>영업 관리</h3>
            <p>영업 기회 및 수주 확률 관리</p>
        </a>

        <a href="<c:url value='/pms/contractList.do'/>" class="card card-hover">
            <h3>계약 관리</h3>
            <p>체결된 계약서 및 조건 관리</p>
        </a>

        <a href="<c:url value='/pms/projectList.do'/>" class="card card-hover">
            <h3>프로젝트 관리</h3>
            <p>수행 중인 프로젝트 현황</p>
            <span class="stat">${projectCount}건</span>
        </a>

        <a href="<c:url value='/pms/billingList.do'/>" class="card card-hover">
            <h3>청구/정산</h3>
            <p>세금계산서 발행 및 입금 확인</p>
            <span class="stat">${billingCount}건</span>
        </a>

        <a href="<c:url value='/pms/userList.do'/>" class="card card-hover">
            <h3>직원 관리</h3>
            <p>내부 인력 및 조직 관리</p>
        </a>

        <a href="<c:url value='/pms/meetingList.do'/>" class="card card-hover">
            <h3>🎙️ AI 회의록 분석 바로가기</h3>
            <p>회의록 분석</p>
        </a>


    </div>
</div>

<c:import url="/WEB-INF/jsp/egovframework/com/pms/include/notification.jsp" />

<script src="<c:url value='/js/egovframework/com/pms/dashboard.js'/>"></script>
</body>
</html>
