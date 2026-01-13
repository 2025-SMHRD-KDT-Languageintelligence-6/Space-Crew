package egovframework.com.pms.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.pms.service.BillingService;
import egovframework.com.pms.service.BillingVO;
import egovframework.com.pms.service.ProjectService;
import egovframework.com.pms.service.ProjectVO;

@Controller
public class BillingController {

    @Resource(name = "billingService")
    private BillingService billingService;

    @Resource(name = "projectService")
    private ProjectService projectService;

    @RequestMapping(value = "/pms/billingList.do")
    public String list(@ModelAttribute("searchVO") BillingVO billingVO, Model model) throws Exception {
        
        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(billingVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(billingVO.getPageUnit());
        paginationInfo.setPageSize(billingVO.getPageSize());

        billingVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        billingVO.setLastIndex(paginationInfo.getLastRecordIndex());
        billingVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

        List<?> list = billingService.selectBillingList(billingVO);
        model.addAttribute("resultList", list);

        int totCnt = billingService.selectBillingListTotCnt(billingVO);
        paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);

        return "egovframework/com/pms/BillingList";
    }

    @RequestMapping(value = "/pms/addBillingView.do")
    public String addView(@ModelAttribute("billingVO") BillingVO billingVO, Model model) throws Exception {
        model.addAttribute("projectList", projectService.selectProjectList(new ProjectVO()));
        return "egovframework/com/pms/BillingRegist";
    }

    @RequestMapping(value = "/pms/addBilling.do")
    public String save(@ModelAttribute("billingVO") BillingVO billingVO) throws Exception {
    	LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
    	if (user != null) {
    		billingVO.setLastUpdusrId(user.getId());
    	}
    	billingService.saveBilling(billingVO);
        return "redirect:/pms/billingList.do";
    }
        
    @RequestMapping(value = "/pms/updateBillingView.do")
    public String updateView(@RequestParam("selectedId") Long id, Model model) throws Exception {
        model.addAttribute("billingVO", billingService.selectBillingDetail(id));
        model.addAttribute("projectList", projectService.selectProjectList(new ProjectVO()));
        return "egovframework/com/pms/BillingUpdt";
    }

    @RequestMapping(value = "/pms/updateBilling.do")
    public String update(@ModelAttribute("billingVO") BillingVO billingVO) throws Exception {
    	LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
        if (user != null) {
            billingVO.setLastUpdusrId(user.getId());
        }
        billingService.updateBilling(billingVO); 
        return "redirect:/pms/billingList.do";
    }
    
    @RequestMapping(value = "/pms/deleteBilling.do")
    public String delete(@RequestParam("selectedId") Long id) throws Exception {
    	BillingVO billingVO = new BillingVO();
        billingVO.setBillId(id);
        LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
        if (user != null) {
            billingVO.setLastUpdusrId(user.getId());
        }
    	billingService.deleteBilling(billingVO);
        return "redirect:/pms/billingList.do";
    }
    
    @RequestMapping(value = "/pms/billingDetailPopup.do")
    public String billingDetailPopup(@RequestParam("projId") Long projId, Model model) throws Exception {
        BillingVO summary = billingService.selectProjectBillingSummary(projId);
        List<BillingVO> billList = billingService.selectBillingListByProject(summary);

        model.addAttribute("summary", summary);
        model.addAttribute("billList", billList);
        return "egovframework/com/pms/BillingDetailPopup";
    }
    
    @ResponseBody
    @RequestMapping(value = "/pms/addBillingAjax.do")
    public Map<String, Object> addBillingAjax(@ModelAttribute("billingVO") BillingVO billingVO) throws Exception {
        Map<String, Object> result = new HashMap<>();
        try {
            LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
            if (user != null) {
            	billingVO.setLastUpdusrId(user.getId());
            }
            
            billingService.saveBilling(billingVO);
            result.put("status", "success");
        } catch (Exception e) {
            result.put("status", "fail");
            result.put("message", e.getMessage());
        }
        return result;
    }
    
    @ResponseBody
    @RequestMapping(value = "/pms/deleteBillingAjax.do")
    public Map<String, Object> deleteBillingAjax(@RequestParam("selectedId") Long id) throws Exception {
        Map<String, Object> result = new HashMap<>();
        try {
            BillingVO billingVO = new BillingVO();
            billingVO.setBillId(id);
            LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
            if (user != null) billingVO.setLastUpdusrId(user.getId());
            
            billingService.deleteBilling(billingVO);
            result.put("status", "success");
        } catch (Exception e) {
            result.put("status", "fail");
        }
        return result;
    }
    
}