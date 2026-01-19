<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<%-- 사이드바 스타일 --%>
<link rel="stylesheet" href="<c:url value='/css/egovframework/com/menu_sidebar.css'/>">
<%-- 아이콘 라이브러리 --%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

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
    </ul>
    <a href="<c:url value='/uat/uia/actionLogout.do'/>" class="logout-btn">로그아웃</a>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        // 1. 현재 브라우저의 전체 URL 주소를 가져옵니다.
        const currentPath = window.location.href;

        // 2. 모든 메뉴의 링크(a 태그)를 가져옵니다.
        const menuLinks = document.querySelectorAll('.sidebar ul.nav li a');

        menuLinks.forEach(link => {
            // 3. 현재 URL에 메뉴의 href 경로가 포함되어 있는지 확인합니다.
            if (currentPath.includes(link.getAttribute('href'))) {
                // 4. 일치하는 경우 부모 요소인 <li>와 자기 자신 <a>에 active 클래스를 추가합니다.
                link.parentElement.classList.add('active');
                link.classList.add('active');
            }
        });
    });
</script>