package egovframework.com.pms.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.com.pms.service.ProjectAssignVO;
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
    
    public String insertProjectAssign(ProjectAssignVO assignVO, String forceSave) throws Exception {
    	
    	double currentRate = projectMapper.selectUserCurrentRate(assignVO);
        double newTotalRate = currentRate + assignVO.getInputRate();
        
        if (newTotalRate > 1.0 && "N".equals(forceSave)) {
        	return "OVERLOAD";
        }

        projectMapper.insertProjectAssign(assignVO);
        return "SUCCESS";
    }

	@Override
    public List<ProjectAssignVO> selectProjectAssignList(ProjectVO projectVO) throws Exception {
        return projectMapper.selectProjectAssignList(projectVO);
    }

	@Override
	public void deleteProjectAssign(int assignId) throws Exception {
	    projectMapper.deleteProjectAssign(assignId);
	}
	
	@Override
	public List<Map<String, Object>> selectUserListForPopup(String searchNm) throws Exception {
		return projectMapper.selectUserListForPopup(searchNm);
	}
	
	@Override
	public double selectUserCurrentRate(ProjectAssignVO assignVO) throws Exception {
	    return projectMapper.selectUserCurrentRate(assignVO);
	}
	
	
	@Override
	public List<EgovMap> selectUserAssignListAjax(String userId) throws Exception {
		return projectMapper.selectUserAssignListAjax(userId);
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public void saveProjectTaskGroup(ProjectAssignVO vo) throws Exception {
		if (vo.getTaskGroupId() != null && !vo.getTaskGroupId().isEmpty()) {
	        projectMapper.deleteProjectTaskGroup(vo.getTaskGroupId());
	    }
	    projectMapper.insertProjectTaskGroup(vo);
	}

	@Override
	public List<ProjectAssignVO> selectTaskGroupMemberList(String taskGroupId) throws Exception {
		return projectMapper.selectTaskGroupMemberList(taskGroupId);
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public void deleteProjectTaskGroup(String taskGroupId) throws Exception {
		projectMapper.deleteProjectTaskGroup(taskGroupId);
	}

	@Override
	public void updateAssignConfirm(Map<String, Object> param) throws Exception {
		projectMapper.updateTaskGroupConfirm(param);
	}

	@Override
	public void updateTaskGroupConfirm(Map<String, Object> param) throws Exception {
		projectMapper.updateTaskGroupConfirm(param);
	}

    /**
     * [추가] AI 매칭용 요구사항 등록 구현
     * ProjectMapper를 통해 DB에 저장합니다.
     */
    @Override
    public void insertAssignmentReq(ProjectAssignVO vo) throws Exception {
        projectMapper.insertAssignmentReq(vo);
    }

	@Override
	public List<ProjectAssignVO> selectProjectAssignListAjax(ProjectAssignVO vo) throws Exception {
		return projectMapper.selectProjectAssignListAjax(vo);
	}
}