package egovframework.com.pms.web;

import java.util.List;
import javax.annotation.Resource;

import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.pms.service.ContractService;
import egovframework.com.pms.service.ContractVO;
import egovframework.com.pms.service.UserService;
import egovframework.com.pms.service.UserVO;

@Controller
public class ContractController {

    @Resource(name = "contractService")
    private ContractService contractService;

    @Resource(name = "userService")
    private UserService userService;

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
        model.addAttribute("userList", userService.selectUserList(new UserVO()));
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
        model.addAttribute("contractVO", result);
        
        model.addAttribute("userList", userService.selectUserList(new UserVO()));
        
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
    
}