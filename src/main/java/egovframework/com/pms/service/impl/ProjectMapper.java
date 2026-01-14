package egovframework.com.pms.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.egovframe.rte.psl.dataaccess.mapper.Mapper;
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
}