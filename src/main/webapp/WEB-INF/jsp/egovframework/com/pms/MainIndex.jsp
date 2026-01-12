<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>PMS 통합 관리 시스템</title>
    <style>
        body { font-family: 'Malgun Gothic', sans-serif; background-color: #f4f7f6; margin: 0; padding: 0; }
        .container { max-width: 1000px; margin: auto; }
        .header { text-align: center; margin-bottom: 40px; }
        .dashboard-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; }
        .card { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); 
                text-align: center; text-decoration: none; color: #333; transition: transform 0.2s; }
        .card:hover { transform: translateY(-5px); border: 2px solid #007bff; }
        .card h3 { margin-top: 0; color: #007bff; }
        .card p { font-size: 0.9em; color: #666; }
        .stat { font-size: 24px; font-weight: bold; color: #333; display: block; margin-top: 10px; }
        
        .content-page { margin-left: 220px; padding: 40px; min-height: 100vh; }
    </style>
</head>
<body>
	
	<c:import url="/WEB-INF/jsp/egovframework/com/pms/include/menu.jsp" />
	<div class="content-page">
	    <div class="container">
	        <div class="header">
	            <h1>🚀 PMS 통합 관리 시스템</h1>
	            <p>프로젝트 관리 시스템 대시보드입니다.</p>
	        </div>
	
	        <div class="dashboard-grid">
	            <a href="<c:url value='/pms/customerList.do'/>" class="card">
	                <h3>🤝 고객 관리</h3>
	                <p>고객사 정보 및 담당자 관리</p>
	            </a>
	
	            <a href="<c:url value='/pms/salesList.do'/>" class="card">
	                <h3>💰 영업 관리</h3>
	                <p>영업 기회 및 수주 확률 관리</p>
	            </a>
	
	            <a href="<c:url value='/pms/contractList.do'/>" class="card">
	                <h3>📄 계약 관리</h3>
	                <p>체결된 계약서 및 조건 관리</p>
	            </a>
	
	            <a href="<c:url value='/pms/projectList.do'/>" class="card">
	                <h3>🏗️ 업무 관리</h3>
	                <p>수행 중인 업무 현황</p>
	                <span class="stat">${projectCount}건</span>
	            </a>
	
	            <a href="<c:url value='/pms/billingList.do'/>" class="card">
	                <h3>💳 청구/정산</h3>
	                <p>세금계산서 발행 및 입금 확인</p>
	                <span class="stat">${billingCount}건</span>
	            </a>
	
	            <a href="<c:url value='/pms/userList.do'/>" class="card">
	                <h3>👥 직원 관리</h3>
	                <p>내부 인력 및 조직 관리</p>
	            </a>
	        </div>
	    </div>
	</div>
</body>
</html>