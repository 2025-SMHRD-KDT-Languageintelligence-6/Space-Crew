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
import egovframework.com.pms.service.ContractService;
import egovframework.com.pms.service.ContractVO;
import egovframework.com.pms.service.CustomerService;
import egovframework.com.pms.service.CustomerVO;
import egovframework.com.pms.service.SalesService;
import egovframework.com.pms.service.SalesVO;
import egovframework.com.pms.service.UserService;
import egovframework.com.pms.service.UserVO;

@Controller
public class ContractController {

    @Resource(name = "contractService")
    private ContractService contractService;

    @Resource(name = "userService")
    private UserService userService;
    
    @Resource(name = "salesService")
    private SalesService salesService;
    
    @Resource(name = "customerService")
    private CustomerService customerService;
    
    @RequestMapping(value = "/pms/contractList.do")
    public String selectContractList(@ModelAttribute("searchVO") ContractVO contractVO, Model model) throws Exception {
        
        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(contractVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(contractVO.getPageUnit());
        paginationInfo.setPageSize(contractVO.getPageSize());

        contractVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        contractVO.setLastIndex(paginationInfo.getLastRecordIndex());
        contractVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

        List<?> list = contractService.selectContractList(contractVO);
        model.addAttribute("resultList", list);

        int totCnt = contractService.selectContractListTotCnt(contractVO);
        paginationInfo.setTotalRecordCount(totCnt);
        
        model.addAttribute("paginationInfo", paginationInfo);

        return "egovframework/com/pms/ContractList";
    }
    
    @RequestMapping(value = "/pms/addContractView.do")
    public String addContractView(@ModelAttribute("contractVO") ContractVO contractVO, Model model) throws Exception {
        List<SalesVO> salesList = salesService.selectSalesList(new SalesVO());
        List<CustomerVO> customerList = customerService.selectCustomerList(new CustomerVO());
        
        UserVO userSearchVO = new UserVO();
        userSearchVO.setRecordCountPerPage(999);
        userSearchVO.setFirstIndex(0);
        List<UserVO> userList = userService.selectUserList(userSearchVO);

        model.addAttribute("contractVO", new ContractVO());
        model.addAttribute("salesList", salesList);
        model.addAttribute("customerList", customerList);
        model.addAttribute("userList", userList);

        return "egovframework/com/pms/ContractRegist";
    }
    
    @RequestMapping(value = "/pms/addContract.do")
    public String save(@ModelAttribute("contractVO") ContractVO contractVO) throws Exception {
    	LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
    	if (user != null) {
    		contractVO.setLastUpdusrId(user.getId());
    	}
    	contractService.saveContract(contractVO);
        return "redirect:/pms/contractList.do";
    }
    
    @RequestMapping(value = "/pms/updateContractView.do")
    public String updateContractView(@RequestParam("selectedId") Long id, Model model) throws Exception {
        ContractVO result = contractService.selectContractDetail(id);
        if(result != null) {
            if(result.getContDt() != null && result.getContDt().length() >= 10) {
                result.setContDt(result.getContDt().substring(0, 10));
            }
            if(result.getStartDt() != null && result.getStartDt().length() >= 10) {
                result.setStartDt(result.getStartDt().substring(0, 10));
            }
            if(result.getEndDt() != null && result.getEndDt().length() >= 10) {
                result.setEndDt(result.getEndDt().substring(0, 10));
            }
        }
        List<SalesVO> salesList = salesService.selectSalesList(new SalesVO());
        List<CustomerVO> customerList = customerService.selectCustomerList(new CustomerVO());
        UserVO userSearchVO = new UserVO();
        userSearchVO.setRecordCountPerPage(999);
        userSearchVO.setFirstIndex(0);
        List<UserVO> userList = userService.selectUserList(userSearchVO);

        model.addAttribute("contractVO", result);
        model.addAttribute("salesList", salesList);
        model.addAttribute("customerList", customerList);
        model.addAttribute("userList", userList);
        return "egovframework/com/pms/ContractUpdt";
    }
    
    @RequestMapping(value = "/pms/updateContract.do")
    public String update(@ModelAttribute("contractVO") ContractVO contractVO) throws Exception {
    	LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
        if (user != null) {
            contractVO.setLastUpdusrId(user.getId());
        }
        contractService.updateContract(contractVO); 
        return "redirect:/pms/contractList.do";
    }
    
    @RequestMapping(value = "/pms/deleteContract.do")
    public String delete(@RequestParam("selectedId") Long id) throws Exception {
    	ContractVO contractVO = new ContractVO();
    	contractVO.setContId(id);
        LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
        if (user != null) {
        	contractVO.setLastUpdusrId(user.getId());
        }
        contractService.deleteContract(contractVO);
        return "redirect:/pms/contractList.do";
    }
    
    @RequestMapping(value = "/pms/contractDetailPopup.do")
    public String contractDetailPopup(@RequestParam("selectedId") Long id, Model model) throws Exception {
        ContractVO result = contractService.selectContractDetail(id);
        model.addAttribute("contractVO", result);
        return "egovframework/com/pms/ContractDetailPopup";
    }
    
    @ResponseBody
    @RequestMapping(value = "/pms/updateContractStatusAjax.do")
    public Map<String, Object> updateContractStatusAjax(@RequestParam Map<String, Object> param) {
        Map<String, Object> resultMap = new HashMap<>();
        try {
            contractService.updateContractStatus(param);
            resultMap.put("status", "success");
        } catch (Exception e) {
            resultMap.put("status", "fail");
            resultMap.put("message", e.getMessage());
        }
        return resultMap;
    }
    
}