package egovframework.com.pms.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;

import egovframework.com.pms.service.ProjectService;
import egovframework.com.pms.service.ProjectVO;

@Service("projectService")
public class ProjectServiceImpl extends EgovAbstractServiceImpl implements ProjectService {

    @Resource(name = "projectMapper")
    private ProjectMapper projectMapper;

    @Override
    public List<ProjectVO> selectProjectList(ProjectVO vo) throws Exception {
        return projectMapper.selectProjectList(vo);
    }

    @Override
    public int selectProjectListTotCnt(ProjectVO vo) throws Exception {
        return projectMapper.selectProjectListTotCnt(vo);
    }
    
    @Override
    public void saveProject(ProjectVO vo) throws Exception {
        if (vo.getProjId() == null || vo.getProjId() == 0) {
            projectMapper.insertProject(vo);
        } else {
            projectMapper.updateProject(vo);
        }
    }
    
    @Override
    public ProjectVO selectProjectDetail(Long id) throws Exception {
        ProjectVO resultVO = projectMapper.selectProjectDetail(id);
        if (resultVO == null)
            throw processException("info.nodata.msg");
        return resultVO;
    }

    @Override
    public void deleteProject(ProjectVO vo) throws Exception {
        projectMapper.deleteProject(vo);
    }
    
    @Override
    public void updateProject(ProjectVO vo) throws Exception {
        projectMapper.updateProject(vo);
    }
    
    @Override
    public void updateProjectStatus(Map<String, Object> param) throws Exception {
        projectMapper.updateProjectStatusAjax(param);
    }
}