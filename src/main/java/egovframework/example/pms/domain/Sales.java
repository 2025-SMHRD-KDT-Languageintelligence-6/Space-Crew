package egovframework.example.pms.domain;

import java.time.LocalDate;
import java.time.LocalDateTime;
import javax.persistence.*;

import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.CreationTimestamp; // 자동 날짜 생성을 위해 사용 권장

@Entity
@Table(name = "tb_sales")
@Getter @Setter
public class Sales {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "SALES_ID")
    private Long salesId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "CUST_ID")
    private Customer customer;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "SALES_USER_ID")
    private User salesUser;

    @Column(name = "SALES_TITLE", length = 200)
    private String salesTitle;

    @Column(name = "EXPECTED_AMT")
    private Long expectedAmt;

    @Column(name = "EXPECTED_DT")
    private LocalDate expectedDt;

    @Column(name = "PROBABILITY")
    private Integer probability;

    @Column(name = "STATUS", length = 20)
    private String status;

    @Column(name = "SALES_CONTENT", columnDefinition = "TEXT")
    private String salesContent;

    @CreationTimestamp
    @Column(name = "REG_DT", updatable = false)
    private LocalDateTime regDt;
}