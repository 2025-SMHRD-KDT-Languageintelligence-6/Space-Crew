package egovframework.example.pms.domain;

import lombok.Getter;
import lombok.Setter;
import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;

@Entity
@Table(name = "tb_user")
@Getter @Setter
public class User {

    @Id
    @Column(name = "USER_ID", length = 20)
    private String userId;

    @Column(name = "USER_NM", nullable = false, length = 50)
    private String userNm;

    @Column(name = "USER_PWD", nullable = false, length = 100)
    private String userPwd;

    @Column(name = "DEPT_NM", length = 50)
    private String deptNm;

    @Column(name = "JOB_ROLE", length = 30)
    private String jobRole;

    @Column(name = "POSITION_NM", length = 30)
    private String positionNm;

    @Column(name = "CAREER_YEARS")
    private Integer careerYears = 0;

    @Column(name = "JOB_FIELD", length = 50)
    private String jobField;

    @Column(name = "CURRENT_LOAD", precision = 5, scale = 2)
    private BigDecimal currentLoad = BigDecimal.ZERO;

    @Column(name = "JOIN_DT")
    private LocalDate joinDt;

    @Column(name = "AUTH_LEVEL")
    private Integer authLevel = 2; // 1관리자 2일반

    @Column(name = "USE_YN", length = 1)
    private String useYn = "Y";
}