package egovframework.com.pms.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.com.pms.service.SalesService;
import egovframework.com.pms.service.SalesVO;
import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.pms.service.CustomerService;
import egovframework.com.pms.service.CustomerVO;
import egovframework.com.pms.service.UserService;
import egovframework.com.pms.service.UserVO;

import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class SalesController {

    @Resource(name = "salesService")
    private SalesService salesService;

    @Resource(name = "customerService")
    private CustomerService customerService;

    @Resource(name = "userService")
    private UserService userService;

    @RequestMapping(value = "/pms/salesList.do")
    public String list(@ModelAttribute("searchVO") SalesVO salesVO, Model model) throws Exception {
        
        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(salesVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(salesVO.getPageUnit());
        paginationInfo.setPageSize(salesVO.getPageSize());

        salesVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        salesVO.setLastIndex(paginationInfo.getLastRecordIndex());
        salesVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
        
        LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
        if (user != null) {
            salesVO.setLoginId(user.getUniqId());
        }
        
        List<?> list = salesService.selectSalesList(salesVO);
        model.addAttribute("resultList", list);

        int totCnt = salesService.selectSalesListTotCnt(salesVO);
        paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);

        return "egovframework/com/pms/SalesList";
    }

    @RequestMapping(value = "/pms/addSalesView.do")
    public String addView(@ModelAttribute("salesVO") SalesVO salesVO, Model model) throws Exception {
    	CustomerVO custSearchVO = new CustomerVO();
        custSearchVO.setRecordCountPerPage(999);
        custSearchVO.setFirstIndex(0);
        model.addAttribute("customerList", customerService.selectCustomerList(custSearchVO));
        
        UserVO userSearchVO = new UserVO();
        userSearchVO.setRecordCountPerPage(999);
        userSearchVO.setFirstIndex(0);
        model.addAttribute("userList", userService.selectUserList(userSearchVO));
        
        return "egovframework/com/pms/SalesRegist";
    }

    @RequestMapping(value = "/pms/addSales.do")
    public String save(@ModelAttribute("salesVO") SalesVO salesVO) throws Exception {
    	LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
    	if (user != null) {
    		salesVO.setLastUpdusrId(user.getId());
    	}
    	salesService.saveSales(salesVO);
        return "redirect:/pms/salesList.do";
    }

    @RequestMapping(value = "/pms/updateSalesView.do")
    public String updateView(@RequestParam("selectedId") Long id, Model model) throws Exception {
        SalesVO result = salesService.selectSalesDetail(id);
        if(result != null && result.getExpectedDt() != null) {
            String rawDt = result.getExpectedDt();
            if(rawDt.length() >= 10) {
                result.setExpectedDt(rawDt.substring(0, 10));
            }
        }
        model.addAttribute("salesVO", result);
        
        CustomerVO custSearchVO = new CustomerVO();
        custSearchVO.setRecordCountPerPage(999);
        custSearchVO.setFirstIndex(0);
        model.addAttribute("customerList", customerService.selectCustomerList(custSearchVO));
        
        UserVO userSearchVO = new UserVO();
        userSearchVO.setRecordCountPerPage(999);
        model.addAttribute("userList", userService.selectUserList(userSearchVO));
        
        return "egovframework/com/pms/SalesUpdt";
    }
    
    @RequestMapping(value = "/pms/updateSales.do")
    public String update(@ModelAttribute("salesVO") SalesVO salesVO) throws Exception {
    	LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
        if (user != null) {
            salesVO.setLastUpdusrId(user.getId());
        }
        salesService.updateSales(salesVO); 
        return "redirect:/pms/salesList.do";
    }
    
    @RequestMapping(value = "/pms/deleteSales.do")
    public String delete(@RequestParam("selectedId") Long id) throws Exception {
    	SalesVO salesVO = new SalesVO();
        salesVO.setSalesId(id);
        LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
        if (user != null) {
            salesVO.setLastUpdusrId(user.getId());
        }
    	salesService.deleteSales(salesVO);
        return "redirect:/pms/salesList.do";
    }
    
    @RequestMapping(value = "/pms/salesDetailPopup.do")
    public String salesDetailPopup(@RequestParam("selectedId") Long id, Model model) throws Exception {
    	SalesVO result = salesService.selectSalesDetail(id);
        model.addAttribute("salesVO", result);
        return "egovframework/com/pms/SalesDetailPopup";
    }
    
    @ResponseBody
    @RequestMapping(value = "/pms/updateSalesStatusAjax.do")
    public Map<String, Object> updateSalesStatusAjax(@RequestParam Map<String, Object> param) {
        Map<String, Object> resultMap = new HashMap<>();
        try {
            salesService.updateSalesStatus(param);
            resultMap.put("status", "success");
        } catch (Exception e) {
            resultMap.put("status", "fail");
            resultMap.put("message", e.getMessage());
        }
        return resultMap;
    }
    
    
    
}