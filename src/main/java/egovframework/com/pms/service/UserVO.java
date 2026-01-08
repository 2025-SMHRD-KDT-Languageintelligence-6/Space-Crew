package egovframework.com.pms.service;

import java.io.Serializable;
import java.math.BigDecimal;
import egovframework.com.cmm.ComDefaultVO;

public class UserVO extends ComDefaultVO implements Serializable {

    private static final long serialVersionUID = 1L;

    private String userId;
    private String userNm;
    private String userPwd;
    private String deptNm;
    private String jobRole;
    private String positionNm;
    private Integer careerYears;
    private String jobField;
    private BigDecimal currentLoad;
    private String joinDt;
    private Integer authLevel;
    private String useYn;

    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }
    public String getUserNm() { return userNm; }
    public void setUserNm(String userNm) { this.userNm = userNm; }
    public String getUserPwd() { return userPwd; }
    public void setUserPwd(String userPwd) { this.userPwd = userPwd; }
    public String getDeptNm() { return deptNm; }
    public void setDeptNm(String deptNm) { this.deptNm = deptNm; }
    public String getJobRole() { return jobRole; }
    public void setJobRole(String jobRole) { this.jobRole = jobRole; }
    public String getPositionNm() { return positionNm; }
    public void setPositionNm(String positionNm) { this.positionNm = positionNm; }
    public Integer getCareerYears() { return careerYears; }
    public void setCareerYears(Integer careerYears) { this.careerYears = careerYears; }
    public String getJobField() { return jobField; }
    public void setJobField(String jobField) { this.jobField = jobField; }
    public BigDecimal getCurrentLoad() { return currentLoad; }
    public void setCurrentLoad(BigDecimal currentLoad) { this.currentLoad = currentLoad; }
    public String getJoinDt() { return joinDt; }
    public void setJoinDt(String joinDt) { this.joinDt = joinDt; }
    public Integer getAuthLevel() { return authLevel; }
    public void setAuthLevel(Integer authLevel) { this.authLevel = authLevel; }
    public String getUseYn() { return useYn; }
    public void setUseYn(String useYn) { this.useYn = useYn; }
}