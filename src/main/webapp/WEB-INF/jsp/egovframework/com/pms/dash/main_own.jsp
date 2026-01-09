<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>프로젝트 크루 - 오너 대시보드</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="bg-gray-100 flex">

    <%-- 사이드바 인클루드 --%>
    <jsp:include page="layout/sidebar.jsp" />

    <main class="flex-1 p-8">
        <%-- 헤더 섹션 --%>
        <header class="flex justify-between items-center mb-8">
            <h1 class="text-2xl font-bold text-gray-800">통합 진행 현황</h1>
            <div class="flex items-center space-x-4">
                <span class="text-sm text-gray-500">
                    <c:set var="now" value="<%= new java.util.Date() %>" />
                    <fmt:formatDate value="${now}" pattern="yyyy년 MM월 dd일" /> 기준
                </span>
                <div class="w-10 h-10 bg-blue-500 rounded-full flex items-center justify-center text-white font-bold">O</div>
            </div>
        </header>

        <%-- 대시보드 그리드 --%>
        <div class="grid grid-cols-1 xl:grid-cols-3 gap-6">

            <%-- 1. 영업 현황 --%>
            <div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
                <div class="p-5 border-b border-gray-50 flex justify-between items-center bg-orange-50/30">
                    <h3 class="font-bold text-gray-700"><i class="fas fa-bullseye text-orange-500 mr-2"></i>영업 현황</h3>
                    <button class="text-xs text-gray-400 hover:text-gray-600">더보기 <i class="fas fa-chevron-right"></i></button>
                </div>
                <div class="p-5 space-y-6">
                    <%-- AI 통합 플랫폼 --%>
                    <div class="cursor-pointer group" onclick="openDetail('영업-AI 통합 플랫폼')">
                        <div class="flex justify-between mb-2">
                            <span class="text-sm font-semibold text-gray-800 group-hover:text-blue-600 transition-colors">AI 통합 플랫폼 구축</span>
                            <span class="text-xs font-bold text-orange-600 bg-orange-100 px-2 py-1 rounded">제안중</span>
                        </div>
                        <div class="w-full bg-gray-100 rounded-full h-2">
                            <div class="bg-orange-400 h-2 rounded-full" style="width: 45%"></div>
                        </div>
                        <p class="text-[11px] text-gray-400 mt-2">고객사: (주)테크솔루션 | 예상금액: 4,500만원</p>
                    </div>

                    <%-- 금융망 클라우드 --%>
                    <div class="cursor-pointer group" onclick="openDetail('영업-클라우드 전환')">
                        <div class="flex justify-between mb-2">
                            <span class="text-sm font-semibold text-gray-800 group-hover:text-blue-600 transition-colors">금융망 클라우드 전환</span>
                            <span class="text-xs font-bold text-blue-600 bg-blue-100 px-2 py-1 rounded">최종협상</span>
                        </div>
                        <div class="w-full bg-gray-100 rounded-full h-2">
                            <div class="bg-blue-500 h-2 rounded-full" style="width: 85%"></div>
                        </div>
                        <p class="text-[11px] text-gray-400 mt-2">고객사: 미래뱅크 | 예상금액: 1.2억원</p>
                    </div>
                </div>
            </div>

            <%-- 2. 계약 현황 --%>
            <div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
                <div class="p-5 border-b border-gray-50 flex justify-between items-center bg-green-50/30">
                    <h3 class="font-bold text-gray-700"><i class="fas fa-file-contract text-green-500 mr-2"></i>계약 현황</h3>
                    <button class="text-xs text-gray-400 hover:text-gray-600">더보기 <i class="fas fa-chevron-right"></i></button>
                </div>
                <div class="p-5 space-y-6">
                    <div class="cursor-pointer group">
                        <div class="flex justify-between mb-2">
                            <span class="text-sm font-semibold text-gray-800">스마트 팩토리 고도화</span>
                            <span class="text-xs font-bold text-green-600 bg-green-100 px-2 py-1 rounded">검토완료</span>
                        </div>
                        <div class="w-full bg-gray-100 rounded-full h-2">
                            <div class="bg-green-500 h-2 rounded-full" style="width: 90%"></div>
                        </div>
                        <p class="text-[11px] text-gray-400 mt-2">상태: 법무팀 최종 날인 대기 중</p>
                    </div>
                </div>
            </div>

            <%-- 3. 프로젝트 현황 --%>
            <div class="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden">
                <div class="p-5 border-b border-gray-50 flex justify-between items-center bg-blue-50/30">
                    <h3 class="font-bold text-gray-700"><i class="fas fa-tasks text-blue-500 mr-2"></i>프로젝트 현황</h3>
                    <button class="text-xs text-gray-400 hover:text-gray-600">더보기 <i class="fas fa-chevron-right"></i></button>
                </div>
                <div class="p-5 space-y-6">
                    <div class="cursor-pointer group">
                        <div class="flex justify-between mb-2">
                            <span class="text-sm font-semibold text-gray-800">Next ERP 시스템 개발</span>
                            <span class="text-sm font-bold text-blue-600">72%</span>
                        </div>
                        <div class="w-full bg-gray-100 rounded-full h-2">
                            <div class="bg-blue-600 h-2 rounded-full" style="width: 72%"></div>
                        </div>
                        <div class="flex justify-between items-center mt-2">
                            <div class="flex -space-x-2">
                                <div class="w-6 h-6 rounded-full bg-gray-300 border-2 border-white text-[10px] flex items-center justify-center">김</div>
                                <div class="w-6 h-6 rounded-full bg-blue-300 border-2 border-white text-[10px] flex items-center justify-center text-white font-bold">이</div>
                                <div class="w-6 h-6 rounded-full bg-green-300 border-2 border-white text-[10px] flex items-center justify-center text-white font-bold">AI</div>
                            </div>
                            <span class="text-[11px] text-red-500 font-bold italic"><i class="fas fa-exclamation-triangle mr-1"></i>일정 지연 주의</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="mt-8 p-4 bg-blue-50 rounded-xl text-blue-600 text-sm border border-blue-100">
            <i class="fas fa-info-circle mr-2"></i> 진행바 또는 리스트 클릭 시 우측에서 **상세 정보 드로어**가 표시됩니다.
        </div>
    </main>

    <script>
        function openDetail(id) {
            console.log("Detail for: " + id);
            // 드로어 오픈 로직 구현
        }
    </script>
</body>
</html>