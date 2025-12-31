package egovframework.example.pms.domain;

import java.time.LocalDate;
import javax.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "tb_billing")
@Getter @Setter
public class Billing {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "BILL_ID")
    private Long billId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "PROJ_ID")
    private Project project;

    @Column(name = "BILL_TITLE", length = 200)
    private String billTitle;

    @Column(name = "BILL_AMT")
    private Long billAmt;

    @Column(name = "TAX_BILL_DT")
    private LocalDate taxBillDt;

    @Column(name = "PAY_DT")
    private LocalDate payDt;

    @Column(name = "IS_PAID", length = 1)
    private String isPaid = "N";

    @Column(name = "ACTUAL_PAY_DT")
    private LocalDate actualPayDt;

    @Column(name = "BILL_REMARK", columnDefinition = "TEXT")
    private String billRemark;
}