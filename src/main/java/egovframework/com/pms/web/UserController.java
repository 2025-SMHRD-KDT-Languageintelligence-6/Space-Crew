package egovframework.com.pms.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.pms.service.UserVO;
import egovframework.com.pms.service.impl.BillingMapper;
import egovframework.com.pms.service.impl.ContractMapper;
import egovframework.com.pms.service.impl.CustomerMapper;
import egovframework.com.pms.service.impl.ProjectMapper;
import egovframework.com.pms.service.impl.SalesMapper;
import egovframework.com.pms.service.UserService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class UserController {

    @Resource(name = "userService")
    private UserService userService;
    
    @Resource(name = "EgovFileMngService")
    private EgovFileMngService fileMngService;

    @Resource(name = "EgovFileMngUtil")
    private EgovFileMngUtil fileUtil;
    
    @Resource(name = "salesMapper")
    private SalesMapper salesMapper;
    
    @Resource(name = "projectMapper")
    private ProjectMapper projectMapper;
    
    @Resource(name = "contractMapper")
    private ContractMapper contractMapper;
    
    @Resource(name = "customerMapper")
    private CustomerMapper customerMapper;
    
    @Resource(name = "billingMapper")
    private BillingMapper billingMapper;
    
    
    @RequestMapping(value = "/pms/userList.do")
    public String selectUserList(@ModelAttribute("searchVO") UserVO userVO, Model model) throws Exception {
        
        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(userVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(userVO.getPageUnit());
        paginationInfo.setPageSize(userVO.getPageSize());

        userVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        userVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

        List<?> list = userService.selectUserList(userVO);
        model.addAttribute("resultList", list);

        int totCnt = userService.selectUserListTotCnt(userVO);
        paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);

        return "egovframework/com/pms/UserList";
    }

    @RequestMapping(value = "/pms/addUserView.do")
    public String addUserView(@ModelAttribute("userVO") UserVO userVO) throws Exception {
        return "egovframework/com/pms/UserRegist";
    }

    @RequestMapping(value = "/pms/addUser.do")
    public String insertUser(@ModelAttribute("userVO") UserVO userVO) throws Exception {
    	LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
    	if (user != null) {
    		userVO.setLastUpdusrId(user.getId());
    	}
    	userService.saveUser(userVO);
        return "redirect:/pms/userList.do";
    }

    @RequestMapping(value = "/pms/updateUserView.do")
    public String updateUserView(@RequestParam("selectedId") String id, Model model) throws Exception {
        UserVO result = userService.selectUserDetail(id);
        
        if(result.getJoinDt() != null && result.getJoinDt().length() == 8) {
            String raw = result.getJoinDt();
            result.setJoinDt(raw.substring(0, 4) + "-" + raw.substring(4, 6) + "-" + raw.substring(6, 8));
        }
        
        model.addAttribute("userVO", result);
        return "egovframework/com/pms/UserUpdt";
    }
    
    @RequestMapping(value = "/pms/updateUser.do")
    public String update(@ModelAttribute("userVO") UserVO userVO) throws Exception {
    	LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
        if (user != null) {
            userVO.setLastUpdusrId(user.getId());
        }
        userService.updateUser(userVO); 
        return "redirect:/pms/userList.do";
    }
    
    @RequestMapping(value = "/pms/deleteUser.do")
    public String delete(@RequestParam("selectedId") String id) throws Exception {
    	UserVO userVO = new UserVO();
        userVO.setUserId(id);
        LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
        if (user != null) {
            userVO.setLastUpdusrId(user.getId());
        }
    	userService.deleteUser(userVO);
        return "redirect:/pms/userList.do";
    }
    
    @RequestMapping(value = "/pms/userDetailPopup.do")
    public String userDetailPopup(@RequestParam("selectedId") String id, Model model) throws Exception {
        UserVO result = userService.selectUserDetail(id);
        model.addAttribute("userVO", result);
        return "egovframework/com/pms/UserDetailPopup";
    }
    
    @ResponseBody
    @RequestMapping(value = "/pms/uploadFileAjax.do")
    public Map<String, Object> uploadFileAjax(final MultipartHttpServletRequest multiRequest, 
                                              @RequestParam Map<String, Object> param) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();
        
        try {
            List<FileVO> result = null;
            String atchFileId = (String) param.get("atchFileId");
            String userId = (String) param.get("userId");
            String salesId = (String) param.get("salesId");
            String projId = (String) param.get("projId");
            String contId = (String) param.get("contId");
            String custId = (String) param.get("custId");
            String billId = (String) param.get("billId");
            
            final Map<String, MultipartFile> files = multiRequest.getFileMap();
            
            if (!files.isEmpty()) {

                if (atchFileId == null || "".equals(atchFileId)) {
                    result = fileUtil.parseFileInf(files, "PMS_", 0, "", "");
                    atchFileId = fileMngService.insertFileInfs(result);
                    
                    if (userId != null && !"".equals(userId)) {
                        UserVO vo = new UserVO();
                        vo.setUserId(userId);
                        vo.setAtchFileId(atchFileId);
                        userService.updateUserAtchFileId(vo);
                    } else if (salesId != null && !"".equals(salesId)) {
                        Map<String, Object> map = new HashMap<>();
                        map.put("salesId", salesId);
                        map.put("atchFileId", atchFileId);
                        salesMapper.updateSalesAtchFileId(map);
                    } else if (projId != null && !"".equals(projId)) {
                        Map<String, Object> map = new HashMap<>();
                        map.put("projId", projId);
                        map.put("atchFileId", atchFileId);
                        projectMapper.updateProjectAtchFileId(map);
                    } else if (contId != null && !"".equals(contId)) {
                        Map<String, Object> map = new HashMap<>();
                        map.put("contId", contId);
                        map.put("atchFileId", atchFileId);
                        contractMapper.updateContractAtchFileId(map);
                    } else if (custId != null && !"".equals(custId)) {
                        Map<String, Object> map = new HashMap<>();
                        map.put("custId", custId);
                        map.put("atchFileId", atchFileId);
                        customerMapper.updateCustomerAtchFileId(map);
                    } else if (billId != null && !"".equals(billId)) {
                        Map<String, Object> map = new HashMap<>();
                        map.put("billId", billId);
                        map.put("atchFileId", atchFileId);
                        billingMapper.updateBillingAtchFileId(map);
                    }
                } 
                else {
                    FileVO fvo = new FileVO();
                    fvo.setAtchFileId(atchFileId);
                    int cnt = fileMngService.getMaxFileSN(fvo);
                    result = fileUtil.parseFileInf(files, "PMS_", cnt, atchFileId, "");
                    fileMngService.updateFileInfs(result);
                }
            }
            resultMap.put("status", "success");
            resultMap.put("atchFileId", atchFileId);
        } catch (Exception e) {
            e.printStackTrace();
            resultMap.put("status", "error");
            resultMap.put("message", e.getMessage());
        }
        
        return resultMap;
    }
}