package egovframework.com.pms.web;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import egovframework.com.pms.service.CustomerService;
import egovframework.com.pms.service.CustomerVO;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class CustomerController {

    @Resource(name = "customerService")
    private CustomerService customerService;

    @RequestMapping(value = "/pms/customerList.do")
    public String selectCustomerList(@ModelAttribute("searchVO") CustomerVO customerVO, Model model) throws Exception {
        
        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(customerVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(customerVO.getPageUnit());
        paginationInfo.setPageSize(customerVO.getPageSize());

        customerVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        customerVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

        List<?> list = customerService.selectCustomerList(customerVO);
        model.addAttribute("resultList", list);

        int totCnt = customerService.selectCustomerListTotCnt(customerVO);
        paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);

        return "egovframework/com/pms/CustomerList";
    }

    @RequestMapping(value = "/pms/addCustomerView.do")
    public String addCustomerView(@ModelAttribute("customerVO") CustomerVO customerVO) throws Exception {
        return "egovframework/com/pms/CustomerRegist";
    }

    @RequestMapping(value = "/pms/addCustomer.do")
    public String insertCustomer(@ModelAttribute("customerVO") CustomerVO customerVO) throws Exception {
        customerService.saveCustomer(customerVO);
        return "redirect:/pms/customerList.do";
    }

    @RequestMapping(value = "/pms/updateCustomerView.do")
    public String updateCustomerView(@RequestParam("selectedId") Integer id, Model model) throws Exception {
        CustomerVO result = customerService.selectCustomerDetail(id);
        model.addAttribute("customerVO", result);
        return "egovframework/com/pms/CustomerUpdt";
    }

    @RequestMapping(value = "/pms/deleteCustomer.do")
    public String deleteCustomer(@RequestParam("selectedId") Integer id) throws Exception {
        customerService.deleteCustomer(id);
        return "redirect:/pms/customerList.do";
    }
}