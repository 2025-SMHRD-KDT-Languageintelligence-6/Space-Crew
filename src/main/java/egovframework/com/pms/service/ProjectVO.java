package egovframework.com.pms.service;

import java.io.Serializable;
import egovframework.com.cmm.ComDefaultVO;
import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class ProjectVO extends ComDefaultVO implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long projId;
    private String projNm;
    private String projType;
    private String status;
    private String startDt;
    private String endDt;
    private Double estEffort;
    
    private String lastUpdusrId;
    private String reqSkills;
    
    private String contNm;
    private Long contAmt;
    private String salesTitle;
    private String custNm;
    private String picUserNm;
    private String mainMgrNm;
    private String subMgrNm;
    private String salesUserNm;
    private String mainMgrId;
    private String subMgrId;
    private Long contId;
}