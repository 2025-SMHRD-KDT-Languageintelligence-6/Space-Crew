package egovframework.com.pms.service;

import java.io.Serializable;
import egovframework.com.cmm.ComDefaultVO;
import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class BillingVO extends ComDefaultVO implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long billId;
    private Long projectId;
    private String projectName;
    private String billTitle;
    private Long billAmt;
    private String taxBillDt;
    private String payDt;
    private String isPaid;
    private String actualPayDt;
    private String billRemark;
    private String lastUpdusrId;
}