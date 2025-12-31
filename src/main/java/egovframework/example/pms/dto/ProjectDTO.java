package egovframework.example.pms.dto;

import java.time.LocalDate;
import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class ProjectDTO {
    private Long projId;
    private String projNm;
    private String projType;
    private String status;
    private LocalDate startDt;
    private LocalDate endDt;
    private Double progressRate;
    private Integer complexityScore;
    private Long contractId;
    private String contractName;
    private String mainManagerId;
    private String mainManagerName;
    private String subManagerId;
    private String subManagerName;
}