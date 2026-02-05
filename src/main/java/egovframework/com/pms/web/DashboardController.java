package egovframework.com.pms.web;

import egovframework.com.pms.service.impl.SalesMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@Controller
public class DashboardController {

    @Autowired
    private SalesMapper salesMapper; // Mapper 주입을 상단으로 통합

    // 대시보드 화면 호출
    @RequestMapping(value = "/pms/dashboard.do")
    public String dashboardView(Model model) throws Exception {
        model.addAttribute("projectCount", 5);
        model.addAttribute("billingCount", 12);
        return "egovframework/com/pms/MainDashboard";
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