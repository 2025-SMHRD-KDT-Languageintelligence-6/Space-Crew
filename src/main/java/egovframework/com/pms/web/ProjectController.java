package egovframework.com.pms.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.pms.service.ProjectAssignVO;
import egovframework.com.pms.service.ProjectService;
import egovframework.com.pms.service.ProjectVO;

@Controller
public class ProjectController {

    @Resource(name = "projectService")
    private ProjectService projectService;

    @RequestMapping(value = "/pms/projectList.do")
    public String selectProjectList(@ModelAttribute("searchVO") ProjectVO projectVO, Model model) throws Exception {
        
        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(projectVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(projectVO.getPageUnit());
        paginationInfo.setPageSize(projectVO.getPageSize());

        projectVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        projectVO.setLastIndex(paginationInfo.getLastRecordIndex());
        projectVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

        List<?> list = projectService.selectProjectList(projectVO);
        model.addAttribute("resultList", list);

        int totCnt = projectService.selectProjectListTotCnt(projectVO);
        paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);

        return "egovframework/com/pms/ProjectList";
    }

    @RequestMapping(value = "/pms/addProjectView.do")
    public String addProjectView(@ModelAttribute("projectVO") ProjectVO projectVO, Model model) throws Exception {
        return "egovframework/com/pms/ProjectRegist";
    }

    @RequestMapping(value = "/pms/addProject.do")
    public String insertProject(@ModelAttribute("projectVO") ProjectVO projectVO) throws Exception {
    	LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
    	if (user != null) {
    		projectVO.setLastUpdusrId(user.getId());
    	}
    	projectService.saveProject(projectVO);
        return "redirect:/pms/projectList.do";
    }

    @RequestMapping(value = "/pms/updateProjectView.do")
    public String updateProjectView(@RequestParam("selectedId") Long id, @ModelAttribute("projectVO") ProjectVO projectVO, Model model) throws Exception {
        ProjectVO result = projectService.selectProjectDetail(id);
        model.addAttribute("projectVO", result);
        return "egovframework/com/pms/ProjectUpdt";
    }
    
    @RequestMapping(value = "/pms/updateProject.do")
    public String update(@ModelAttribute("projectVO") ProjectVO projectVO) throws Exception {
    	LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
        if (user != null) {
            projectVO.setLastUpdusrId(user.getId());
        }
        projectService.updateProject(projectVO); 
        return "redirect:/pms/projectList.do";
    }
    
    @RequestMapping(value = "/pms/deleteProject.do")
    public String delete(@RequestParam("selectedId") Long id) throws Exception {
    	ProjectVO projectVO = new ProjectVO();
        projectVO.setProjId(id);
        LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
        if (user != null) {
            projectVO.setLastUpdusrId(user.getId());
        }
    	projectService.deleteProject(projectVO);
        return "redirect:/pms/projectList.do";
    }
    
    @RequestMapping(value = "/pms/projectDetailPopup.do")
    public String projectDetailPopup(@RequestParam("selectedId") Long id, Model model) throws Exception {
        ProjectVO result = projectService.selectProjectDetail(id);
        model.addAttribute("projectVO", result);
        return "egovframework/com/pms/ProjectDetailPopup";
    }
    
    @ResponseBody
    @RequestMapping(value = "/pms/updateProjectStatusAjax.do")
    public Map<String, Object> updateProjectStatusAjax(@RequestParam Map<String, Object> param) {
        Map<String, Object> resultMap = new HashMap<>();
        try {
            projectService.updateProjectStatus(param);
            resultMap.put("status", "success");
        } catch (Exception e) {
            resultMap.put("status", "fail");
            resultMap.put("message", e.getMessage());
        }
        return resultMap;
    }
    
    @ResponseBody
    @RequestMapping(value = "/pms/saveProjectAssignAjax.do")
    public Map<String, Object> saveProjectAssignAjax(ProjectAssignVO assignVO, 
            @RequestParam(value="forceSave", defaultValue="N") String forceSave) throws Exception {
        
        Map<String, Object> resultMap = new HashMap<>();
        
        String result = projectService.insertProjectAssign(assignVO, forceSave);

        if ("OVERLOAD".equals(result)) {
            resultMap.put("status", "OVERLOAD");
            double currentRate = projectService.selectUserCurrentRate(assignVO);
            resultMap.put("message", "주의! 해당 인원은 현재 기간에 이미 " + (int)(currentRate * 100) + "% 투입 중입니다.");
        } else {
            resultMap.put("status", "SUCCESS");
            resultMap.put("message", "저장되었습니다.");
        }
        return resultMap;
    }
    
    @ResponseBody
    @RequestMapping(value = "/pms/selectProjectAssignListAjax.do")
    public Map<String, Object> selectProjectAssignListAjax(@RequestParam("projectId") int projectId) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();
        
        List<ProjectAssignVO> list = projectService.selectProjectAssignList(projectId);
        
        resultMap.put("list", list);
        return resultMap;
    }
    
    @ResponseBody
    @RequestMapping(value = "/pms/deleteProjectAssignAjax.do")
    public Map<String, Object> deleteProjectAssignAjax(@RequestParam("assignId") int assignId) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();
        try {
            projectService.deleteProjectAssign(assignId);
            resultMap.put("status", "SUCCESS");
        } catch (Exception e) {
            resultMap.put("status", "ERROR");
            resultMap.put("message", e.getMessage());
        }
        return resultMap;
    }
    
    @ResponseBody
    @RequestMapping(value = "/pms/searchUserAjax.do")
    public Map<String, Object> searchUserAjax(@RequestParam("searchNm") String searchNm) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();
        List<Map<String, Object>> userList = projectService.selectUserListForPopup(searchNm);
        resultMap.put("userList", userList);
        return resultMap;
    }
    
    @RequestMapping(value = "/pms/selectUserAssignListAjax.do")
    @ResponseBody
    public Map<String, Object> selectUserAssignListAjax(
            @RequestParam("userId") String userId) throws Exception {
        
        Map<String, Object> map = new HashMap<String, Object>();
        
        List<EgovMap> list = projectService.selectUserAssignListAjax(userId);
        
        map.put("list", list);
        
        return map;
    }
}