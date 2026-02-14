package egovframework.com.pms.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.com.pms.service.LogVO;
import egovframework.com.pms.service.impl.SalesMapper;

@Controller
public class DashboardController {

    @Autowired
    private SalesMapper salesMapper; // Mapper 주입을 상단으로 통합
    
    @Autowired
    private egovframework.com.pms.service.impl.MeetingMapper meetingMapper;
    
    @Autowired
    private egovframework.com.pms.service.MeetingService meetingService;
    
    // 대시보드 화면 호출
    @RequestMapping(value = "/pms/dashboard.do")
    public String dashboardView(Model model) throws Exception {

    	List<LogVO> riskAlertList = meetingMapper.selectRecentRiskAlert();
    	
        model.addAttribute("riskAlertList", riskAlertList);
        model.addAttribute("notificationCount", riskAlertList.size());
        
        return "egovframework/com/pms/MainIndex";
    }

    // 알림 데이터를 반환하는 API (통합 버전)
    @RequestMapping("/pms/api/latest-alerts.do")
    @ResponseBody
    public Map<String, Object> getLatestSalesAlert(HttpServletRequest request) {
        Map<String, Object> result = new HashMap<>();

        try {
            // DB에서 1분 이내 신규 등록 건수 조회
            int newCount = salesMapper.selectNewSalesCount();

            if (newCount > 0) {
                result.put("hasChange", true);
                result.put("message", "영업 건에서 " + newCount + "건이 변경되었습니다!");
            } else {
                result.put("hasChange", false);
            }
        } catch (Exception e) {
            result.put("hasChange", false);
            result.put("error", e.toString()); // 에러 발생 시 로그 확인용
        }

        return result;
    }
}