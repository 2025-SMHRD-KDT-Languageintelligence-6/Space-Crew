package egovframework.example.pms.domain;

import java.time.LocalDate;
import javax.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "tb_contract")
@Getter @Setter
public class Contract {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "CONT_ID")
    private Long contId;

    @Column(name = "SALES_ID")
    private Long salesId;

    @Column(name = "CONT_NM", length = 200)
    private String contNm;

    @Column(name = "CONT_AMT")
    private Long contAmt;

    @Column(name = "START_DT")
    private LocalDate startDt;

    @Column(name = "END_DT")
    private LocalDate endDt;

    @Column(name = "CONT_DT")
    private LocalDate contDt;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "PIC_USER_ID")
    private User picUser;

    @Column(name = "CONT_STATUS", length = 20)
    private String contStatus;

    @Column(name = "CONT_REMARK", columnDefinition = "TEXT")
    private String contRemark;
}