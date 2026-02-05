<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- 메인 스타일 --%>

<link rel="stylesheet" href="<c:url value='/css/egovframework/com/dashboard.css'/>">

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>프로젝트 크루 -프로젝트 통합 관리 시스템</title>



</head>
<body>



	<c:import url="/WEB-INF/jsp/egovframework/com/pms/include/menu.jsp" />
	<div class="content-page">
	    <div class="container">
	        <div class="header">
	            <h1>🚀 프로젝트 통합 관리 시스템</h1>
	            <p>시스템 대시보드입니다.</p>
	        </div>

	        <div class="dashboard-grid">
	            <a href="<c:url value='/pms/customerList.do'/>" class="card">
	                <h3><i class="fas fa-address-card mr-3"></i> 고객 관리</h3>
	                <p>고객사 정보 및 담당자 관리</p>
	            </a>

	            <a href="<c:url value='/pms/salesList.do'/>" class="card">
	                <h3><i class="fas fa-chart-line mr-3"></i> 영업 관리</h3>
	                <p>영업 기회 및 수주 확률 관리</p>
	            </a>

	            <a href="<c:url value='/pms/contractList.do'/>" class="card">
	                <h3><i class="fas fa-file-signature mr-3"></i> 계약 관리</h3>
	                <p>체결된 계약서 및 조건 관리</p>
	            </a>

	            <a href="<c:url value='/pms/projectList.do'/>" class="card">
	                <h3><i class="fas fa-project-diagram"></i> 프로젝트 관리</h3>
	                <p>수행 중인 프로젝트 현황</p>
	                <span class="stat">${projectCount}건</span>
	            </a>

	            <a href="<c:url value='/pms/billingList.do'/>" class="card">
	                <h3><i class="fas fa-file-invoice-dollar mr-3"></i> 청구/정산</h3>
	                <p>세금계산서 발행 및 입금 확인</p>
	                <span class="stat">${billingCount}건</span>
	            </a>

	            <a href="<c:url value='/pms/userList.do'/>" class="card">
	                <h3><i class="fas fa-user-tie mr-3"></i> 직원 관리</h3>
	                <p>내부 인력 및 조직 관리</p>
	            </a>

	            <a href="<c:url value='/pms/meetingList.do'/>" class="card">
                    <h3>🎙️ AI 회의록 분석 바로가기</h3>
                    <p>회의록 분석</p>
                </a>

                <a href="<c:url value='/pms/dashboard.do'/>" class="card">
                    <h3>대시보드</h3>
                    <p>대시보드</p>
                </a>


	        </div>
	    </div>
	</div>
</body>
</html>