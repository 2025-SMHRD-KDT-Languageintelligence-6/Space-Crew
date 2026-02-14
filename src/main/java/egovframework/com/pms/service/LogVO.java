package egovframework.com.pms.service;

import java.io.Serializable;
import java.math.BigDecimal;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class LogVO implements Serializable {

    private static final long serialVersionUID = 1L; 

    private int logId;
    private int projId;
    private Integer refId;
    private String fileId;
    private String aiCategory;
    private String inputData;
    private String outputData;
    private String reasoning;
    private BigDecimal confidenceIndex;
    private String lastUpdusrId;

    private String docDt;
}