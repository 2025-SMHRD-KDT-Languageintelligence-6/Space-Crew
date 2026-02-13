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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.PathVariable;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.pms.service.ContractService;
import egovframework.com.pms.service.ContractVO;
import egovframework.com.pms.service.ProjectAssignVO;
import egovframework.com.pms.service.ProjectService;
import egovframework.com.pms.service.ProjectVO;
import egovframework.com.pms.service.UserService;
import egovframework.com.pms.service.UserVO;

import org.springframework.web.client.RestTemplate;

@Controller
public class ProjectController {

    @Resource(name = "projectService")
    private ProjectService projectService;
    
    @Resource(name = "userService")
    private UserService userService;
    
    @Resource(name = "contractService")
    private ContractService contractService;
    

    @RequestMapping(value = "/pms/projectList.do")
    public String selectProjectList(@ModelAttribute("searchVO") ProjectVO projectVO, Model model) throws Exception {
        
        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(projectVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(projectVO.getPageUnit());
        paginationInfo.setPageSize(projectVO.getPageSize());

        projectVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        projectVO.setLastIndex(paginationInfo.getLastRecordIndex());
        projectVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
        
        LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
        if (user != null) {
            projectVO.setLoginId(user.getUniqId());
        }
        
        List<?> list = projectService.selectProjectList(projectVO);
        model.addAttribute("resultList", list);

        int totCnt = projectService.selectProjectListTotCnt(projectVO);
        paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);

        return "egovframework/com/pms/ProjectList";
    }

    @RequestMapping(value = "/pms/addProjectView.do")
    public String addProjectView(@ModelAttribute("projectVO") ProjectVO projectVO, Model model) throws Exception {
    	ContractVO contractSearchVO = new ContractVO();
        contractSearchVO.setRecordCountPerPage(999);
        contractSearchVO.setFirstIndex(0);
        //List<ContractVO> contractList = contractService.selectContractList(contractSearchVO);
        List<ContractVO> contractList = projectService.selectAvailableContractList();
        
    	UserVO userSearchVO = new UserVO();
        userSearchVO.setRecordCountPerPage(999);
        userSearchVO.setFirstIndex(0);
        List<UserVO> userList = userService.selectUserList(userSearchVO);
        
        model.addAttribute("projectVO", new ProjectVO());
        model.addAttribute("contractList", contractList);
        model.addAttribute("userList", userList);
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
        if(result != null) {
            if(result.getStartDt() != null && result.getStartDt().length() >= 10) {
                result.setStartDt(result.getStartDt().substring(0, 10));
            }
            if(result.getEndDt() != null && result.getEndDt().length() >= 10) {
                result.setEndDt(result.getEndDt().substring(0, 10));
            }
        }
        List<ContractVO> contractList = contractService.selectContractList(new ContractVO());
        UserVO userSearchVO = new UserVO();
        userSearchVO.setRecordCountPerPage(999);
        userSearchVO.setFirstIndex(0);
        List<UserVO> userList = userService.selectUserList(userSearchVO);
        model.addAttribute("projectVO", result);
        model.addAttribute("contractList", contractList);
        model.addAttribute("userList", userList);
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
    public Map<String, Object> selectProjectAssignListAjax(ProjectAssignVO vo) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();

        List<ProjectAssignVO> list = projectService.selectProjectAssignListAjax(vo);
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
    
    @ResponseBody
    @RequestMapping(value = "/pms/saveProjectTaskGroupAjax.do")
    public Map<String, Object> saveProjectTaskGroupAjax(@RequestBody ProjectAssignVO vo) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();
        
        LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
        if(vo.getTaskGroupId() == null || vo.getTaskGroupId().isEmpty()) {
            vo.setTaskGroupId("TG_" + user.getId() + "_" + System.currentTimeMillis());
        }
        
        vo.setLastUpdusrId(user.getId());

        try {
            projectService.saveProjectTaskGroup(vo); 
            resultMap.put("status", "SUCCESS");
        } catch (Exception e) {
            resultMap.put("status", "ERROR");
            resultMap.put("message", e.getMessage());
        }
        
        return resultMap;
    }
    
    @ResponseBody
    @RequestMapping(value = "/pms/selectTaskGroupDetailAjax.do")
    public Map<String, Object> selectTaskGroupDetailAjax(@RequestParam("taskGroupId") String taskGroupId) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();

        List<ProjectAssignVO> memberList = projectService.selectTaskGroupMemberList(taskGroupId);

        if (memberList != null && !memberList.isEmpty()) {
            resultMap.put("status", "SUCCESS");
            resultMap.put("memberList", memberList);
            resultMap.put("info", memberList.get(0));
        } else {
            resultMap.put("status", "EMPTY");
        }

        return resultMap;
    }
    
    @ResponseBody
    @RequestMapping(value = "/pms/deleteProjectTaskGroupAjax.do")
    public Map<String, Object> deleteProjectTaskGroupAjax(@RequestParam("taskGroupId") String taskGroupId) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();
        try {
        	projectService.deleteProjectTaskGroup(taskGroupId); 
            resultMap.put("status", "SUCCESS");
        } catch (Exception e) {
            resultMap.put("status", "ERROR");
        }
        return resultMap;
    }
    
    @ResponseBody
    @RequestMapping(value = "/pms/updateAssignConfirmAjax.do")
    public Map<String, Object> updateAssignConfirmAjax(
    		@RequestParam("taskGroupId") String taskGroupId, 
            @RequestParam("confirmYn") String confirmYn) throws Exception {
    	
        Map<String, Object> param = new HashMap<>();
        param.put("taskGroupId", taskGroupId);
        param.put("confirmYn", confirmYn);
        
        Map<String, Object> resultMap = new HashMap<>();
        try {
            projectService.updateAssignConfirm(param); 
            resultMap.put("status", "SUCCESS");
        } catch (Exception e) {
            resultMap.put("status", "ERROR");
            resultMap.put("message", e.getMessage());
        }
        return resultMap;
    }
    
    
    @ResponseBody
    @RequestMapping(value = "/pms/proxyAiMatch.do", method = RequestMethod.POST)
    public List<Map<String, Object>> proxyAiMatch(@RequestBody Map<String, Object> param) {
        try {
            // 1. 파이썬 서버 주소 (8000번)
            String pythonUrl = "http://127.0.0.1:8000/api/match";

            // 2. 자바가 직접 파이썬 호출 (이러면 CORS 안 뜸!)
            org.springframework.web.client.RestTemplate restTemplate = new org.springframework.web.client.RestTemplate();
            
            // 3. 파이썬으로부터 리스트 형태로 결과 받아오기
            List<Map<String, Object>> result = restTemplate.postForObject(pythonUrl, param, List.class);

            System.out.println("✅ [AI Proxy] 파이썬 응답 성공! 데이터 개수: " + (result != null ? result.size() : 0));
            return result;

        } catch (Exception e) {
            System.out.println("❌ [AI Proxy] 파이썬 호출 중 에러: " + e.getMessage());
            e.printStackTrace();
            return new java.util.ArrayList<>(); // 에러 시 빈 리스트 반환해서 JS 에러 방지
        }
    }
    
    @RequestMapping("/pms/updateTaskGroupConfirmAjax.do")
    @ResponseBody
    public Map<String, Object> updateTaskGroupConfirmAjax(@RequestParam Map<String, Object> param) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();
        
        try {
            projectService.updateTaskGroupConfirm(param); 
            resultMap.put("status", "SUCCESS");
        } catch (Exception e) {
            resultMap.put("status", "FAIL");
            resultMap.put("message", e.getMessage());
        }
        
        return resultMap;
    }
    /**
     * [AI 매칭] 요구사항 텍스트 저장 -> assignId 반환
     * (기존 ProjectController에 통합)
     */
	/*
	 * @ResponseBody
	 * 
	 * @RequestMapping(value = "/api/matching/projects/{projId}/assignments/req")
	 * public Map<String, Object> addAssignmentReq(@PathVariable int
	 * projId, @RequestBody Map<String, Object> payload) throws Exception {
	 * 
	 * // 1. VO 생성 (ProjectAssignVO 사용) ProjectAssignVO vo = new ProjectAssignVO();
	 * vo.setProjId(projId); vo.setReqSkills((String) payload.get("req_skills"));
	 * 
	 * // 제목이 있으면 넣고, 없으면 앞부분 잘라서 임시 제목으로 String title = (String)
	 * payload.get("assign_title"); if(title == null || title.isEmpty()) { String
	 * req = (String) payload.get("req_skills"); title = (req.length() > 10) ?
	 * req.substring(0, 10) + "..." : req; } vo.setAssignTitle(title);
	 * 
	 * // 2. 서비스 호출 (기존 projectService 사용!) // 서비스에 insertAssignmentReq 메서드를 추가해야
	 * 합니다. projectService.insertAssignmentReq(vo);
	 * 
	 * // 3. 결과 반환 Map<String, Object> result = new HashMap<>();
	 * result.put("status", "success"); result.put("assignId", vo.getAssignId()); //
	 * INSERT 후 생성된 ID
	 * 
	 * return result; }
	 */
    
    
}