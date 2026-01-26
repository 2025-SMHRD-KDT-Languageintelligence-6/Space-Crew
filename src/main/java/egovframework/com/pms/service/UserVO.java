package egovframework.com.pms.service;

import java.io.Serializable;
import java.math.BigDecimal;
import egovframework.com.cmm.ComDefaultVO;
import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class UserVO extends ComDefaultVO implements Serializable {
    private static final long serialVersionUID = 1L;

    private String userId;
    private String userNm;
    private String deptNm;
    private String jobRole;
    private String positionNm;
    private Integer careerYears;
    private String jobField;
    private BigDecimal currentLoad;
    private String joinDt;
    private String useYn;
    private String lastUpdusrId;
    private String skillDesc;
    
    private String atchFileId;
}