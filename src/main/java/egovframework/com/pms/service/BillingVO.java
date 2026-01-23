package egovframework.com.pms.service;

import java.io.Serializable;
import egovframework.com.cmm.ComDefaultVO;
import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class BillingVO extends ComDefaultVO implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long billId;
    private Long projId;
    private String projNm;
    private String billTitle;
    private Long billAmt;
    private String taxBillDt;
    private String payDt;
    private String actualPayDt;
    private String billRemark;
    private String lastUpdusrId;
    private String isPaid;
    private Long totalAmt;
    private Long totalBilledAmt;
    private Long totalPaidAmt;
    private String contNm;
    private String contRemark;
    private String salesTitle;
    private String salesContent;
    private String custNm;
    private String salesUserNm;
    private String picUserNm;
    private String mainMgrNm;
    private String subMgrNm;
    private String billStatus;
    private String billStep;
    
}