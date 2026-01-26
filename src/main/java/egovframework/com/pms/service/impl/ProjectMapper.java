package egovframework.com.pms.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.egovframe.rte.psl.dataaccess.mapper.Mapper;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;

import egovframework.com.pms.service.ProjectAssignVO;
import egovframework.com.pms.service.ProjectVO;

@Mapper("projectMapper")
public interface ProjectMapper {
    
    List<ProjectVO> selectProjectList(ProjectVO vo) throws Exception;

    int selectProjectListTotCnt(ProjectVO vo);

    ProjectVO selectProjectDetail(Long id) throws Exception;
    void insertProject(ProjectVO vo) throws Exception;
    void updateProject(ProjectVO vo) throws Exception;
	void deleteProject(ProjectVO vo) throws Exception;

	void updateProjectStatus(@Param("projId") Long projId, @Param("status") String status);

	void updateProjectStatusAjax(Map<String, Object> param) throws Exception;

	double selectUserCurrentRate(ProjectAssignVO vo) throws Exception;

	void insertProjectAssign(ProjectAssignVO vo) throws Exception;

	void deleteProjectAssign(int assignId) throws Exception;

    List<ProjectAssignVO> selectProjectAssignList(ProjectVO vo) throws Exception;

	List<Map<String, Object>> selectUserListForPopup(String searchNm) throws Exception;

	List<EgovMap> selectUserAssignListAjax(String userId) throws Exception;

	void saveProjectTaskGroup(ProjectAssignVO vo) throws Exception;

	void deleteProjectTaskGroup(String taskGroupId) throws Exception;

	void insertProjectTaskGroup(ProjectAssignVO vo) throws Exception;

	List<ProjectAssignVO> selectTaskGroupMemberList(String taskGroupId) throws Exception;
	
	void updateAssignConfirm(Map<String, Object> param) throws Exception;
	
	void updateTaskGroupConfirm(Map<String, Object> param) throws Exception;
	
	void updateProjectAtchFileId(Map<String, Object> map);
}