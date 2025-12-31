package egovframework.example.pms.dto;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class CustomerDTO {
    private Long custId;
    private String custNm;
    private String bizRegNo;
    private String ceoNm;
    private String picNm;
    private String picTel;
    private String picEmail;
    private String custAddr;
    private String custRemark;
}