package egovframework.com.pms.service;

import java.io.Serializable;
import egovframework.com.cmm.ComDefaultVO;
import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class ContractVO extends ComDefaultVO implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long contId;
    private Long salesId;
    private String contNm;
    private Long contAmt;
    
    private String startDt;
    private String endDt;
    private String contDt;
    
    private String picUserId;
    private String picUserNm;
    private String contStatus;
    private String contRemark;
    private String lastUpdusrId;
    
    private String salesTitle;
    private String salesUserId;
    private String salesUserNm;
    private String custNm;
    
    private String custId;
    
}