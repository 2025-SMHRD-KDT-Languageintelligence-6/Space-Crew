<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
    /* 알림창 전용 스타일 */
    #notification-panel {
        transition: transform 0.3s ease-in-out;
        transform: translateX(100%);
    }

    #notification-panel.open {
        transform: translateX(0);
    }
</style>

<div id="notification-panel" class="fixed top-0 right-0 h-full w-80 bg-white shadow-2xl z-[100] border-l border-slate-100 flex flex-col">
    <div class="p-8 border-b border-slate-100 flex justify-between items-center bg-slate-50">
        <h3 class="font-bold text-slate-800 tracking-tighter uppercase underline decoration-blue-500 decoration-2 underline-offset-4">Notification Center</h3>
        <button onclick="toggleNotifications()" class="text-slate-400 hover:text-red-500 transition-colors"><i class="fas fa-times text-lg"></i></button>
    </div>

    <div class="flex-1 overflow-y-auto p-5 space-y-4">
	    <c:choose>
	        <c:when test="${not empty riskAlertList}">
	            <c:forEach var="risk" items="${riskAlertList}">
	                <div class="p-4 ${risk.confidenceIndex >= 70 ? 'bg-red-50 border-red-100' : 'bg-amber-50 border-amber-100'} rounded-[1.5rem] border animate-fade-in mb-4">
	                    <div class="flex justify-between items-center mb-2">
	                        <p class="text-[10px] font-bold ${risk.confidenceIndex >= 70 ? 'text-red-600' : 'text-amber-600'} uppercase">
	                            ${risk.confidenceIndex >= 70 ? 'High Risk' : 'Caution'} (${risk.confidenceIndex}점)
	                        </p>
	                        <p class="text-[9px] text-slate-400 font-bold">
						        ${risk.docDt} 
						        <c:if test="${not empty risk.inputData}">
						            <c:set var="fileName" value="${fn:replace(risk.inputData, '파일명: ', '')}" />
						            <c:set var="dotIndex" value="${fn:indexOf(fileName, '.')}" />
						            | <i class="fas fa-file-alt ml-1"></i> 
						            ${dotIndex != -1 ? fn:substring(fileName, 0, dotIndex) : fileName}
						        </c:if>
						    </p>
                        </div>
	                    <p class="text-[11px] ${risk.confidenceIndex >= 70 ? 'text-red-800' : 'text-amber-800'} font-bold leading-relaxed">
	                        ${risk.reasoning}
	                    </p>
	                </div>
	            </c:forEach>
	        </c:when>
	        <c:otherwise>
	            <div class="p-8 text-center text-slate-400 text-xs font-medium">
	                분석된 리스크 알림이 없습니다.
	            </div>
	        </c:otherwise>
	    </c:choose>
	</div>

    <div class="p-4 bg-slate-50 border-t border-slate-100 text-center">
         <button type="button"
                 onclick="clearNotifications()"
                 class="text-[10px] font-bold text-slate-400 hover:text-slate-600 uppercase tracking-widest">
           모든 알림 읽음 처리
         </button>
    </div>
</div>