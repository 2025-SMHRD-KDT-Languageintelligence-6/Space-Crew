package egovframework.com.pms.service;

import java.io.Serializable;
import java.util.List;

import egovframework.com.cmm.ComDefaultVO;
import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class ProjectAssignVO extends ComDefaultVO implements Serializable {
    private Integer assignId;
    private Integer projId;
    private String userId;
    private String userNm;
    private String assignTitle;
    private String startDate;
    private String endDate;
    private Double inputRate;
    private String lastUpdusrId;
    private String delYn;
    private String taskGroupId;
    
    private List<ProjectAssignVO> assignList;
    
    private String confirmYn;
}

