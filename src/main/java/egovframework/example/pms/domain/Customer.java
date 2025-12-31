package egovframework.example.pms.domain;

import javax.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "tb_customer")
@Getter @Setter
public class Customer {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "CUST_ID")
    private Long custId;
    
    @Column(name = "CUST_NM", length = 100, nullable = false)
    private String custNm;
    
    @Column(name = "BIZ_REG_NO", length = 20)
    private String bizRegNo;
    
    @Column(name = "CEO_NM", length = 50)
    private String ceoNm;
    
    @Column(name = "PIC_NM", length = 50)
    private String picNm;
    
    @Column(name = "PIC_TEL", length = 20)
    private String picTel;
    
    @Column(name = "PIC_EMAIL", length = 100)
    private String picEmail;
    
    @Column(name = "CUST_ADDR", length = 255)
    private String custAddr;
    
    @Column(name = "CUST_REMARK", columnDefinition = "TEXT")
    private String custRemark;
}