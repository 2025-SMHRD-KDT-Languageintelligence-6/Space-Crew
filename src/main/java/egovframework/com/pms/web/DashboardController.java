package egovframework.com.pms.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import javax.servlet.http.HttpServletRequest;

@Controller
public class DashboardController {

    @RequestMapping(value = "/pms/dashboard.do")
    public String dashboardView(Model model) throws Exception {
        
        model.addAttribute("projectCount", 5);
        model.addAttribute("billingCount", 12);
        
        return "egovframework/com/pms/MainDashboard"; 
    }
}