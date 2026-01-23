package egovframework.com.pms.web;

import javax.annotation.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.pms.service.ProjectService;
import egovframework.com.pms.service.ProjectVO;
import egovframework.com.pms.service.BillingService;
import egovframework.com.pms.service.BillingVO;

@Controller
public class MainController {

    @Resource(name = "projectService")
    private ProjectService projectService;

    @Resource(name = "billingService")
    private BillingService billingService;

    @RequestMapping(value = "/pms/main.do")
    public String mainDashboard(Model model) throws Exception {
        
        int totalProjects = projectService.selectProjectListTotCnt(new ProjectVO());
        model.addAttribute("projectCount", totalProjects);

        int totalBillings = billingService.selectBillingListTotCnt(new BillingVO());
        model.addAttribute("billingCount", totalBillings);

        return "egovframework/com/pms/MainIndex";
    }

    @RequestMapping(value = "/")
    public String index() {
        return "redirect:/pms/main.do";
    }

    // 회의록 분석
    @RequestMapping("/pms/meetingView.do")
    public String meetingViewPage() {
        return "egovframework/com/pms/meeting_view";
    }
}