<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>PMS 통합 관리 시스템</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="<c:url value='/css/egovframework/com/dashboard.css'/>">
</head>
<body>

	<%-- 사이드바 메뉴 수입 --%>
	<c:import url="/WEB-INF/jsp/egovframework/com/pms/include/menu.jsp" />


	<div class="content-page">
	    <div class="container">
	        <div class="header">
	            <h1>🚀 PMS 통합 관리 시스템</h1>
	            <p>프로젝트 관리 시스템 대시보드입니다.</p>
	        </div>
	
	        <div class="dashboard-grid">
                <a href="<c:url value='/pms/customerList.do'/>" class="card">
                    <h3><i class="fas fa-address-card"></i> 고객 관리</h3>
                    <p>고객사 정보 및 담당자 관리</p>
                </a>

                <a href="<c:url value='/pms/salesList.do'/>" class="card">
                    <h3><i class="fas fa-chart-line"></i> 영업 관리</h3>
                    <p>영업 기회 및 수주 확률 관리</p>
                </a>

                <a href="<c:url value='/pms/contractList.do'/>" class="card">
                    <h3><i class="fas fa-file-signature"></i> 계약 관리</h3>
                    <p>체결된 계약서 및 조건 관리</p>
                </a>

                <a href="<c:url value='/pms/projectList.do'/>" class="card">
                    <h3><i class="fas fa-project-diagram"></i> 프로젝트 관리</h3>
                    <p>수행 중인 프로젝트 현황</p>
                    <span class="stat">${projectCount}건</span>
                </a>

                <a href="<c:url value='/pms/billingList.do'/>" class="card">
                    <h3><i class="fas fa-file-invoice-dollar"></i> 청구/정산</h3>
                    <p>세금계산서 발행 및 입금 확인</p>
                    <span class="stat">${billingCount}건</span>
                </a>

                <a href="<c:url value='/pms/userList.do'/>" class="card">
                    <h3><i class="fas fa-user-tie"></i> 직원 관리</h3>
                    <p>내부 인력 및 조직 관리</p>
                </a>
            </div>
	    </div>
	</div>
</body>
</html>