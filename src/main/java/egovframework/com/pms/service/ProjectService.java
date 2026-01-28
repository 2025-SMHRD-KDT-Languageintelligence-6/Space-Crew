package egovframework.com.pms.service;

import java.util.List;
import java.util.Map;

import org.egovframe.rte.psl.dataaccess.util.EgovMap;

public interface ProjectService {

    List<ProjectVO> selectProjectList(ProjectVO vo) throws Exception;

    int selectProjectListTotCnt(ProjectVO vo) throws Exception;

    ProjectVO selectProjectDetail(Long id) throws Exception;

    void saveProject(ProjectVO vo) throws Exception;

    void deleteProject(ProjectVO vo) throws Exception;

    void updateProject(ProjectVO vo) throws Exception;

    void updateProjectStatus(Map<String, Object> param) throws Exception;

    String insertProjectAssign(ProjectAssignVO assignVO, String forceSave) throws Exception;

    // [수정 완료] 기존 int projId -> ProjectVO vo 로 변경!
    List<ProjectAssignVO> selectProjectAssignList(ProjectVO vo) throws Exception;

    void deleteProjectAssign(int assignId) throws Exception;

    List<Map<String, Object>> selectUserListForPopup(String searchNm) throws Exception;

    double selectUserCurrentRate(ProjectAssignVO assignVO) throws Exception;

    List<EgovMap> selectUserAssignListAjax(String userId) throws Exception;

	void saveProjectTaskGroup(ProjectAssignVO vo) throws Exception;

	List<ProjectAssignVO> selectTaskGroupMemberList(String taskGroupId) throws Exception;

	void deleteProjectTaskGroup(String taskGroupId) throws Exception;

	void updateAssignConfirm(Map<String, Object> param) throws Exception;
	
	void updateTaskGroupConfirm(Map<String, Object> param) throws Exception;

    /** [추가] AI 매칭용 요구사항 등록 (TB_ASSIGNMENT INSERT) */
    void insertAssignmentReq(ProjectAssignVO vo) throws Exception;
}