package egovframework.com.pms.service;

import java.io.Serializable;
import egovframework.com.cmm.ComDefaultVO;
import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class SalesVO extends ComDefaultVO implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long salesId;
    private Integer custId;
    private String salesUserId;
    private String salesTitle;
    private Long expectedAmt;
    private String expectedDt;
    private Integer probability;
    private String status;
    private String salesContent;

    private String customerName;
    private String salesUserName;
    private String lastUpdusrId;
}