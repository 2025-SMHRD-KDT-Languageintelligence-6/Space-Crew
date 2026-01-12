package egovframework.com.pms.web;

import java.util.List;
import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.pms.service.UserVO;
import egovframework.com.pms.service.UserService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class UserController {

    @Resource(name = "userService")
    private UserService userService;

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
}