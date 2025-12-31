package egovframework.example.pms.dto;

import java.math.BigDecimal;
import java.time.LocalDate;
import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class UserDTO {
    private String userId;
    private String userNm;
    private String userPwd;
    private String deptNm;
    private String jobRole;
    private String positionNm;
    private Integer careerYears;
    private String jobField;
    private BigDecimal currentLoad;
    private LocalDate joinDt;
    private Integer authLevel;
    private String useYn;
}