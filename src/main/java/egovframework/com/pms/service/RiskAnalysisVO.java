package egovframework.com.pms.service;

import java.io.Serializable;
import java.util.List;

/**
 * 지능형 리스크 분석 결과 전송을 위한 VO 클래스
 */
public class RiskAnalysisVO implements Serializable {

    private static final long serialVersionUID = 1L;

    // 분석 대상 정보
    private Long projectId;     // 프로젝트 ID
    private Long reportId;      // 보고서/회의록 ID

    // 분석 결과 (FastAPI로부터 받는 데이터)
    private int riskScore;      // 리스크 점수 (0~100)
    private String riskLevel;   // 위험 등급 (SAFE, CAUTION, DANGER)
    private String analysisSummary; // GPT-4o가 요약한 분석 사유
    private List<String> riskKeywords; // 탐지된 핵심 위험어 리스트
    private String detectedAt;  // 분석 완료 시간

    // 기본 생성자
    public RiskAnalysisVO() {}

    // Getter 및 Setter (전자정부프레임워크 표준 규격)
    public Long getProjectId() { return projectId; }
    public void setProjectId(Long projectId) { this.projectId = projectId; }

    public Long getReportId() { return reportId; }
    public void setReportId(Long reportId) { this.reportId = reportId; }

    public int getRiskScore() { return riskScore; }
    public void setRiskScore(int riskScore) { this.riskScore = riskScore; }

    public String getRiskLevel() { return riskLevel; }
    public void setRiskLevel(String riskLevel) { this.riskLevel = riskLevel; }

    public String getAnalysisSummary() { return analysisSummary; }
    public void setAnalysisSummary(String analysisSummary) { this.analysisSummary = analysisSummary; }

    public List<String> getRiskKeywords() { return riskKeywords; }
    public void setRiskKeywords(List<String> riskKeywords) { this.riskKeywords = riskKeywords; }

    public String getDetectedAt() { return detectedAt; }
    public void setDetectedAt(String detectedAt) { this.detectedAt = detectedAt; }
}