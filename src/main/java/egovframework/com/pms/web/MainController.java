package egovframework.com.pms.web;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.pms.service.BillingService;
import egovframework.com.pms.service.ContractService;
import egovframework.com.pms.service.ContractVO;
import egovframework.com.pms.service.LogVO;
import egovframework.com.pms.service.MeetingService;
import egovframework.com.pms.service.ProjectService;
import egovframework.com.pms.service.ProjectVO;
import egovframework.com.pms.service.SalesService;
import egovframework.com.pms.service.SalesVO;

@Controller
public class MainController {

    @Resource(name = "projectService")
    private ProjectService projectService;

    @Resource(name = "billingService")
    private BillingService billingService;
    
    @Resource(name = "salesService")
    private SalesService salesService;
    
    @Resource(name = "contractService")
    private ContractService contractService;

    @Resource(name = "meetingService")
    private MeetingService meetingService;
    
    @RequestMapping(value = "/pms/main.do")
    public String mainDashboard(Model model) throws Exception {
        
    	LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
        String loginId = user.getUniqId();

        SalesVO sVO = new SalesVO();
        sVO.setLoginId(loginId);
        sVO.setFavYn("Y"); 
        sVO.setRecordCountPerPage(10);
        sVO.setFirstIndex(0);
        model.addAttribute("favSalesList", salesService.selectSalesList(sVO));

        ContractVO cVO = new ContractVO();
        cVO.setLoginId(loginId);
        cVO.setFavYn("Y");
        cVO.setRecordCountPerPage(10);
        cVO.setFirstIndex(0);
        model.addAttribute("favContractList", contractService.selectContractList(cVO));

        ProjectVO pVO = new ProjectVO();
        pVO.setLoginId(loginId);
        pVO.setFavYn("Y");
        pVO.setRecordCountPerPage(10);
        pVO.setFirstIndex(0);
        model.addAttribute("favProjectList", projectService.selectProjectList(pVO));
        
        model.addAttribute("projectCount", projectService.selectProjectCount());
        model.addAttribute("billingCount", billingService.selectBillingCount());
        
        List<LogVO> riskAlertList = meetingService.selectRecentRiskAlert();
        model.addAttribute("riskAlertList", riskAlertList);
        model.addAttribute("notificationCount", riskAlertList.size());
        
        return "egovframework/com/pms/MainDashboard";
    }
    
    
    
    @RequestMapping(value = "/")
    public String index() {
        return "redirect:/pms/main.do";
    }

    // 회의록 분석
	/*
	 * @RequestMapping("/pms/meetingView.do") public String meetingViewPage() {
	 * return "egovframework/com/pms/meeting_view"; }
	 */
}