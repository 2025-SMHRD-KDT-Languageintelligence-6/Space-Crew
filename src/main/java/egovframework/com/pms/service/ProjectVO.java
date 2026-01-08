package egovframework.com.pms.service;

import java.io.Serializable;
import egovframework.com.cmm.ComDefaultVO;

public class ProjectVO extends ComDefaultVO implements Serializable {

    private static final long serialVersionUID = 1L;

    private Long projId;
    private String projNm;
    private String projType;
    private String status;
    private String startDt;
    private String endDt;
    private Double progressRate;
    private Integer complexityScore;
    
    private Long contractId;
    private String contractName;
    private String mainManagerId;
    private String mainManagerName;
    private String subManagerId;
    private String subManagerName;

    public Long getProjId() { return projId; }
    public void setProjId(Long projId) { this.projId = projId; }
    public String getProjNm() { return projNm; }
    public void setProjNm(String projNm) { this.projNm = projNm; }
    public String getProjType() { return projType; }
    public void setProjType(String projType) { this.projType = projType; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getStartDt() { return startDt; }
    public void setStartDt(String startDt) { this.startDt = startDt; }
    public String getEndDt() { return endDt; }
    public void setEndDt(String endDt) { this.endDt = endDt; }
    public Double getProgressRate() { return progressRate; }
    public void setProgressRate(Double progressRate) { this.progressRate = progressRate; }
    public Integer getComplexityScore() { return complexityScore; }
    public void setComplexityScore(Integer complexityScore) { this.complexityScore = complexityScore; }
    public Long getContractId() { return contractId; }
    public void setContractId(Long contractId) { this.contractId = contractId; }
    public String getContractName() { return contractName; }
    public void setContractName(String contractName) { this.contractName = contractName; }
    public String getMainManagerId() { return mainManagerId; }
    public void setMainManagerId(String mainManagerId) { this.mainManagerId = mainManagerId; }
    public String getMainManagerName() { return mainManagerName; }
    public void setMainManagerName(String mainManagerName) { this.mainManagerName = mainManagerName; }
    public String getSubManagerId() { return subManagerId; }
    public void setSubManagerId(String subManagerId) { this.subManagerId = subManagerId; }
    public String getSubManagerName() { return subManagerName; }
    public void setSubManagerName(String subManagerName) { this.subManagerName = subManagerName; }
}