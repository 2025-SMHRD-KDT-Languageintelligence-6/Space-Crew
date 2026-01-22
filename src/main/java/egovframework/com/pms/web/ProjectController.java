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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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

        List<?> list = projectService.selectProjectList(projectVO);
        model.addAttribute("resultList", list);

        int totCnt = projectService.selectProjectListTotCnt(projectVO);
        paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);

        return "egovframework/com/pms/ProjectList";
    }

    @RequestMapping(value = "/pms/addProjectView.do")
    public String addProjectView(@ModelAttribute("projectVO") ProjectVO projectVO, Model model) throws Exception {
    	List<ContractVO> contractList = contractService.selectContractList(new ContractVO());
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
    // 1. int -> Long으로 변경 (DB의 PROJ_ID는 숫자가 커서 Long이 안전해)
    public Map<String, Object> selectProjectAssignListAjax(@RequestParam("projId") Long projId) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();

        // 2. VO 객체 생성 (MyBatis는 VO로 받는 걸 좋아해)
        ProjectVO projectVO = new ProjectVO();
        projectVO.setProjId(projId); // 검색 조건 담기

        // 3. 서비스에 VO를 통째로 넘기기
        // (만약 서비스가 아직 int를 받는다면, 서비스 파일도 고쳐야 해!)
        List<ProjectAssignVO> list = projectService.selectProjectAssignList(projectVO);

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

    
    /**
     * [추가 기능] AI 인력 추천 팝업 열기 (Python FastAPI 연동)
     */
    @RequestMapping(value = "/pms/openAIRecommendation.do")
    public String openAIRecommendation(
            @RequestParam("projId") String projId,
            @RequestParam("reqSkills") String reqSkills,
            @RequestParam(value = "aiWeight", defaultValue = "0.7") double aiWeight,
            @RequestParam(value = "careerWeight", defaultValue = "0.3") double careerWeight,
            Model model) throws Exception {

        System.out.println("🚀 [AI 추천] 요청 도착! Project ID: " + projId);
        System.out.println("📝 요구사항: " + reqSkills);

        // 1. Python Server URL (파이썬 서버가 켜져 있어야 함)
        String pythonUrl = "http://127.0.0.1:8000/match/real";

        // 2. 파이썬에게 보낼 데이터 포장 (Map)
        Map<String, Object> requestBody = new HashMap<>();
        requestBody.put("req_skills", reqSkills);
        requestBody.put("target_role", "개발"); // 기본값
        requestBody.put("ai_weight", aiWeight);
        requestBody.put("career_weight", careerWeight);

        // 3. 파이썬에게 전송 (RestTemplate 사용)
        RestTemplate restTemplate = new RestTemplate();

        try {
            // 파이썬이 준 결과(JSON)를 Map으로 받기
            Map response = restTemplate.postForObject(pythonUrl, requestBody, Map.class);
            System.out.println("✅ [AI 추천] 응답 성공: " + response);

            // 4. 결과를 JSP(팝업)로 전달
            model.addAttribute("recommendList", response.get("ranking")); // 랭킹 리스트
            model.addAttribute("reqSkills", reqSkills); // 입력했던 내용
            model.addAttribute("projId", projId);       // 프로젝트 ID
            model.addAttribute("aiWeight", (int)(aiWeight * 100)); // 화면 표시용 (70)
            model.addAttribute("careerWeight", (int)(careerWeight * 100)); // 화면 표시용 (30)

        } catch (Exception e) {
            System.err.println("❌ [AI 추천] 파이썬 서버 연결 실패: " + e.getMessage());
            model.addAttribute("errorMessage", "AI 서버(FastAPI)가 꺼져 있거나 연결할 수 없습니다.");
        }

        // 5. 결과를 보여줄 새로운 팝업 JSP 파일 (이제 만들어야 함)
        return "egovframework/com/pms/RecommendationPopup";
    }

// ↑ 여기 바로 아래에 클래스 닫는 괄호 '}'가 있어야 해!
}