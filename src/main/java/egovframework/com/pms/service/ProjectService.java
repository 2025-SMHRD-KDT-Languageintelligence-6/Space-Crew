package egovframework.com.pms.service;

import java.util.List;

public interface ProjectService {
    
    List<ProjectVO> selectProjectList(ProjectVO vo) throws Exception;

    int selectProjectListTotCnt(ProjectVO vo) throws Exception;

    ProjectVO selectProjectDetail(String id) throws Exception;

    void saveProject(ProjectVO vo) throws Exception;

    void deleteProject(Long id) throws Exception;
}