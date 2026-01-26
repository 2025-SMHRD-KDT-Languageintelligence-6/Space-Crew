package egovframework.com.cmm.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;

public class AdminAccessInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
	    String requestURI = request.getRequestURI();

	    if (isAdminPath(requestURI)) {
	        egovframework.com.cmm.LoginVO loginVO = (egovframework.com.cmm.LoginVO) request.getSession().getAttribute("loginVO");

	        if (loginVO == null || loginVO.getId() == null) {
	            System.out.println("### [Security Alert] 비로그인 사용자 차단: " + requestURI);
	            response.sendRedirect(request.getContextPath() + "/uat/uia/egovLoginUsr.do");
	            return false;
	        }

	        String userId = loginVO.getId();
	        String userSe = loginVO.getUserSe();
	        
	        System.out.println("DEBUG: 접속 시도자 ID -> " + userId + " (구분: " + userSe + ")");

	        if ("webmaster".equals(userId) || "USR".equals(userSe)) { 
	            return true;
	        } else {
	            System.out.println("### [Security Alert] 권한 부족 차단! ID: " + userId);
	            response.sendRedirect(request.getContextPath() + "/pms/main.do");
	            return false;
	        }
	    }

	    return true;
	}

    private boolean isAdminPath(String uri) {
    	if (uri.contains("EgovStplatCnfirm")
    			|| uri.contains("EgovRlnmCnfirm")
    	        || uri.contains("MberSbscrb")
    	        || uri.contains("MberInsert")
    	        || uri.contains("EntrprsSbscrb")
    	        || uri.contains("EntrprsInsert")
    	        || uri.contains("IdDplctCnfirm")) {
    	        return false; 
    	    }
    	
        return uri.contains("/sec/")
            || uri.contains("/sym/")
            || uri.contains("/uat/uap/")
            || uri.contains("/cop/ems/")
            || uri.contains("/uss/umt/");
    }
}