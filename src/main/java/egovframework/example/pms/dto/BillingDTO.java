package egovframework.example.pms.dto;

import java.time.LocalDate;
import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class BillingDTO {
    private Long billId;
    private Long projectId;
    private String projectName;
    private String billTitle;
    private Long billAmt;
    private LocalDate taxBillDt;
    private LocalDate payDt;
    private String isPaid;
    private LocalDate actualPayDt;
    private String billRemark;
}