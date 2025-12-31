package egovframework.example.pms.dto;

import java.time.LocalDate;
import java.time.LocalDateTime;
import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class SalesDTO {
    private Long salesId;
    private Long customerId;
    private String customerName;
    private String salesUserId;
    private String salesUserName;
    private String salesTitle;
    private Long expectedAmt;
    private LocalDate expectedDt;
    private Integer probability;
    private String status;
    private String salesContent;
    private LocalDateTime regDt;
}