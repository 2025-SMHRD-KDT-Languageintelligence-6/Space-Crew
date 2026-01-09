<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="sidebar">
    <div class="logo">
        <a href="<c:url value='/pms/main.do'/>">🚀 PMS 시스템</a>
    </div>
    <ul class="nav">
        <li><a href="<c:url value='/pms/customerList.do'/>">🤝 고객 관리</a></li>
        <li><a href="<c:url value='/pms/salesList.do'/>">💰 영업 관리</a></li>
        <li><a href="<c:url value='/pms/contractList.do'/>">📄 계약 관리</a></li>
        <li><a href="<c:url value='/pms/projectList.do'/>">🏗️ 프로젝트 관리</a></li>
        <li><a href="<c:url value='/pms/billingList.do'/>">💳 청구/정산 관리</a></li>
        <li><a href="<c:url value='/pms/userList.do'/>">👥 직원 관리</a></li>
    </ul>
    <a href="<c:url value='/uat/uia/actionLogout.do'/>" class="logout-btn">로그아웃</a>
</div>

<style>
    .sidebar { width: 220px; background: #2c3e50; color: white; height: 100vh; position: fixed; left: 0; top: 0; padding-top: 20px; }
    .sidebar .logo { text-align: center; margin-bottom: 30px; font-size: 1.2em; font-weight: bold; }
    .sidebar .logo a { color: #ecf0f1; text-decoration: none; }
    .sidebar ul.nav { list-style: none; padding: 0; }
    .sidebar ul.nav li a { display: block; padding: 15px 25px; color: #bdc3c7; text-decoration: none; transition: 0.3s; }
    .sidebar ul.nav li a:hover { background: #34495e; color: white; padding-left: 35px; }
    .content-page { margin-left: 240px; padding: 20px; }
</style>