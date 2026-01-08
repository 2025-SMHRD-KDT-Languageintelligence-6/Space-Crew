package egovframework.com.pms.service;

import java.io.Serializable;
import egovframework.com.cmm.ComDefaultVO;
import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class CustomerVO extends ComDefaultVO implements Serializable {

    private static final long serialVersionUID = 1L;

    private Integer custId;
    private String custNm;
    private String bizRegNo;
    private String ceoNm;
    private String picNm;
    private String picTel;
    private String picEmail;
    private String custAddr;
    private String custRemark;
}