package egovframework.com.pms.web;

import java.util.List;
import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import egovframework.com.pms.service.ProjectService;
import egovframework.com.pms.service.ProjectVO;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

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
        projectService.saveProject(projectVO);
        return "redirect:/pms/projectList.do";
    }

    @RequestMapping(value = "/pms/updateProjectView.do")
    public String updateProjectView(@RequestParam("selectedId") String id, @ModelAttribute("projectVO") ProjectVO projectVO, Model model) throws Exception {
        ProjectVO result = projectService.selectProjectDetail(id);
        model.addAttribute("projectVO", result);
        return "egovframework/com/pms/ProjectUpdt";
    }
    
    @RequestMapping(value = "/pms/deleteProject.do")
    public String deleteProject(@RequestParam("selectedId") Long id) throws Exception {
        projectService.deleteProject(id);
        return "redirect:/pms/projectList.do";
    }
    
    
    
    
    
    
    
    
}