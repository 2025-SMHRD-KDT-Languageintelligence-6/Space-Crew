package egovframework.com.pms.service;

import java.util.List;
import java.util.Map;

public interface ProjectService {
    
    List<ProjectVO> selectProjectList(ProjectVO vo) throws Exception;

    int selectProjectListTotCnt(ProjectVO vo) throws Exception;

    ProjectVO selectProjectDetail(Long id) throws Exception;

    void saveProject(ProjectVO vo) throws Exception;

    void deleteProject(ProjectVO vo) throws Exception;

    void updateProject(ProjectVO vo) throws Exception;

	void updateProjectStatus(Map<String, Object> param) throws Exception;

	String insertProjectAssign(ProjectAssignVO assignVO, String forceSave) throws Exception;

	List<ProjectAssignVO> selectProjectAssignList(int projectId) throws Exception;

	void deleteProjectAssign(int assignId) throws Exception;

	List<Map<String, Object>> selectUserListForPopup(String searchNm) throws Exception;

	double selectUserCurrentRate(ProjectAssignVO assignVO) throws Exception;
}