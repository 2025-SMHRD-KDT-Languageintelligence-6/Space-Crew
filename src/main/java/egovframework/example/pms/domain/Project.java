package egovframework.example.pms.domain;

import javax.persistence.*;
import lombok.Getter;
import lombok.Setter;
import java.time.LocalDate;

@Entity
@Table(name = "tb_project")
@Getter @Setter
public class Project {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "PROJ_ID")
    private Long projId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "CONT_ID")
    private Contract contract;

    @Column(name = "PROJ_NM", nullable = false)
    private String projNm;

    @Column(name = "PROJ_TYPE")
    private String projType;

    @Column(name = "STATUS")
    private String status;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "MAIN_MGR_ID")
    private User mainManager;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "SUB_MGR_ID")
    private User subManager;

    @Column(name = "START_DT")
    private LocalDate startDt;

    @Column(name = "END_DT")
    private LocalDate endDt;

    @Column(name = "PROGRESS_RATE")
    private Double progressRate;

    @Column(name = "COMPLEXITY_SCORE")
    private Integer complexityScore;
}