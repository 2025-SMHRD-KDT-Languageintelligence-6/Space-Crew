package egovframework.example.pms.dto;

import java.time.LocalDate;
import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class ContractDTO {
    private Long contId;
    private Long salesId;
    private String contNm;
    private Long contAmt;
    private LocalDate startDt;
    private LocalDate endDt;
    private LocalDate contDt;
    private String picUserId;     
    private String picUserName; 
    private String contStatus;
    private String contRemark;
}