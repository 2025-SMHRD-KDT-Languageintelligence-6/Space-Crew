<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<link rel="stylesheet" href="<c:url value='/css/egovframework/com/menu_sidebar.css'/>">

<div class="sidebar">
    <div class="logo">
        <a href="<c:url value='/pms/main.do'/>">🚀 PMS 시스템</a>
    </div>
    <ul class="nav">
        <li><a href="<c:url value='/pms/customerList.do'/>"><i class="fas fa-address-card mr-3"></i> 고객 관리</a></li>
        <li><a href="<c:url value='/pms/salesList.do'/>"><i class="fas fa-chart-line mr-3"></i> 영업 관리</a></li>
        <li><a href="<c:url value='/pms/contractList.do'/>"><i class="fas fa-file-signature mr-3"></i> 계약 관리</a></li>
        <li><a href="<c:url value='/pms/projectList.do'/>"><i class="fas fa-project-diagram mr-3"></i> 프로젝트 관리</a></li>
        <li><a href="<c:url value='/pms/billingList.do'/>"><i class="fas fa-file-invoice-dollar mr-3"></i> 청구/정산 관리</a></li>
        <li><a href="<c:url value='/pms/userList.do'/>"><i class="fas fa-user-tie mr-3"></i> 직원 관리</a></li>
    </ul>
    <a href="<c:url value='/uat/uia/actionLogout.do'/>" class="logout-btn">로그아웃</a>
</div>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">