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
    private Integer complexityScore;
    
    private Long contractId;
    private String contractName;
    private String mainManagerId;
    private String mainManagerName;
    private String subManagerId;
    private String subManagerName;
    private String lastUpdusrId;

}