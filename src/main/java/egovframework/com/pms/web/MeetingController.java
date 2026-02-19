package egovframework.com.pms.web;

import java.io.File;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
import egovframework.com.pms.service.LogVO;
import egovframework.com.pms.service.MeetingService;
import egovframework.com.pms.service.MeetingVO;

@Controller
public class MeetingController {

	@Resource(name = "meetingService")
	private MeetingService meetingService;
	
	@Resource(name = "EgovFileMngUtil")
	private EgovFileMngUtil fileUtil;

	@Resource(name = "EgovFileMngService")
	private EgovFileMngService fileMngService;
	
	@RequestMapping(value = "/pms/meetingList.do")
	public String selectMeetingList(
			@RequestParam(value = "targetDate", required = false) String targetDate,
	        MeetingVO meetingVO, ModelMap model) throws Exception {
		
	    Calendar cal = Calendar.getInstance();
	    SimpleDateFormat dbSdf = new SimpleDateFormat("yyyy-MM-dd");
	    SimpleDateFormat sdf = new SimpleDateFormat("d");
	    SimpleDateFormat fullSdf = new SimpleDateFormat("yyyyMMdd");
	    
	    if (targetDate != null && !targetDate.isEmpty()) {
	        cal.setTime(dbSdf.parse(targetDate));
	    }
	    
	    int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
	    cal.add(Calendar.DATE, (dayOfWeek - 1) * -1);
	    
	    Calendar searchCal = (Calendar) cal.clone();
	    searchCal.add(Calendar.DATE, -7); 
	    meetingVO.setSearchStartDt(dbSdf.format(searchCal.getTime()));
	    
	    searchCal.add(Calendar.DATE, 21); 
	    meetingVO.setSearchEndDt(dbSdf.format(searchCal.getTime()));
	    
	    List<MeetingVO> dbMeetingList = meetingService.selectMeetingList(meetingVO);

	    List<Map<String, Object>> weekDays = new ArrayList<>();
	    String todayStr = fullSdf.format(new Date());

	    for (int i = 0; i < 7; i++) {
	        Map<String, Object> dayMap = new HashMap<>();
	        String currentFullDate = fullSdf.format(cal.getTime());
	        String currentDbDate = dbSdf.format(cal.getTime());

	        dayMap.put("dayNum", sdf.format(cal.getTime()));
	        dayMap.put("fullDate", currentFullDate);
	        dayMap.put("isToday", currentFullDate.equals(todayStr));

	        if (dbMeetingList != null) {
	            for (MeetingVO dbVO : dbMeetingList) {
	                if (currentDbDate.equals(dbVO.getMeetDt())) {
	                    dayMap.put("atchFileId", dbVO.getAtchFileId());
	                    dayMap.put("meetId", dbVO.getMeetId());
	                    break;
	                }
	            }
	        }
	        weekDays.add(dayMap);
	        cal.add(Calendar.DATE, 1);
	    }

	    cal.setTime(targetDate != null && !targetDate.isEmpty() ? dbSdf.parse(targetDate) : new Date());
	    List<Map<String, Object>> weeklyList = new ArrayList<>();

	    for (int i = 0; i < 2; i++) {
	        Map<String, Object> weekMap = new HashMap<>();

	        weekMap.put("weekLabel", (cal.get(Calendar.MONTH) + 1) + "월 " + cal.get(Calendar.WEEK_OF_MONTH) + "주차");
	        weekMap.put("weekNum", cal.get(Calendar.WEEK_OF_MONTH) + "W");
	        weekMap.put("isCurrent", (i == 0));
	        
	        Calendar tempCal = (Calendar) cal.clone();
	        tempCal.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
	        String repDate = dbSdf.format(tempCal.getTime());
	        weekMap.put("representativeDate", repDate);

	        if (dbMeetingList != null) {
	            for (MeetingVO dbVO : dbMeetingList) {
	                if (repDate.equals(dbVO.getMeetDt())) {
	                    weekMap.put("meetId", dbVO.getMeetId());
	                    break;
	                }
	            }
	        }
	        
	        weeklyList.add(weekMap);
	        cal.add(Calendar.DATE, -7);
	    }

	    model.addAttribute("weeklyList", weeklyList);
	    model.addAttribute("weekDays", weekDays);
	    model.addAttribute("targetDate", targetDate);
	    
	    return "egovframework/com/pms/MeetingList";
	}
	
	@RequestMapping(value = "/pms/meetingAnalysisView.do")
	public String meetingAnalysisView() throws Exception {
		return "egovframework/com/pms/MeetingAnalysis";
	}
	
	@RequestMapping(value = "/pms/analyzeMeetingData.do")
	@ResponseBody
	public Map<String, Object> analyzeMeetingData(final MultipartHttpServletRequest multiRequest) throws Exception {
	    Map<String, Object> resultMap = new HashMap<>();
	    
	    String meetDt = multiRequest.getParameter("meetDt");
	    
	    String projIdStr = multiRequest.getParameter("projId");
	    Integer pId = (projIdStr == null || projIdStr.isEmpty() || "null".equals(projIdStr)) ? 1 : Integer.parseInt(projIdStr);
	    
	    Map<String, MultipartFile> files = multiRequest.getFileMap();
	    
	    if (files.isEmpty()) {
	        resultMap.put("status", "error");
	        resultMap.put("message", "파일이 전송되지 않았습니다");
	        return resultMap;
	    }
	    
	    try {
	        List<FileVO> result = fileUtil.parseFileInf(files, "MEET_", 0, "", "");
	        String atchFileId = fileMngService.insertFileInfs(result);

	        MultipartFile mFile = files.get("uploadAudio");
	        
	        String tempDir = System.getProperty("java.io.tmpdir");
	        File tempFile = new File(tempDir + File.separator + mFile.getOriginalFilename());
	        mFile.transferTo(tempFile);

	        org.springframework.web.client.RestTemplate restTemplate = new org.springframework.web.client.RestTemplate();
	        String pythonUrl = "http://127.0.0.1:8001/process-meeting";

	        org.springframework.http.HttpHeaders headers = new org.springframework.http.HttpHeaders();
	        headers.setContentType(org.springframework.http.MediaType.MULTIPART_FORM_DATA);

	        org.springframework.util.MultiValueMap<String, Object> body = new org.springframework.util.LinkedMultiValueMap<>();
	        
	        body.add("file", new org.springframework.core.io.FileSystemResource(tempFile));
	        
	        body.add("project_id", pId);
	        body.add("report_id", 1001);

	        org.springframework.http.HttpEntity<org.springframework.util.MultiValueMap<String, Object>> requestEntity = 
	            new org.springframework.http.HttpEntity<>(body, headers);

	        org.springframework.http.ResponseEntity<Map> response = 
	            restTemplate.postForEntity(pythonUrl, requestEntity, Map.class);

	        if (response.getStatusCode() == org.springframework.http.HttpStatus.OK) {
	            Map<String, Object> aiRes = (Map<String, Object>) response.getBody();
	            Map<String, Object> aiData = (Map<String, Object>) aiRes.get("data");

	            MeetingVO vo = new MeetingVO();
	            vo.setAtchFileId(atchFileId);
	            vo.setMeetDt(meetDt);
	            vo.setMeetTitle(meetDt + " AI 분석 회의록");
	            vo.setContentFull((String) aiData.get("full_text"));
	            vo.setContentSum((String) aiData.get("summary"));
	            vo.setActionItems((String) aiData.get("action_items"));
	            
	            egovframework.com.cmm.LoginVO user = (egovframework.com.cmm.LoginVO) egovframework.com.cmm.util.EgovUserDetailsHelper.getAuthenticatedUser();
	            if (user != null) {
	                vo.setLastUpdusrId(user.getUniqId());
	            } else {
	                vo.setLastUpdusrId("SYSTEM");
	            }
	            
	            meetingService.insertMeeting(vo);

	            resultMap.put("status", "success");
	            resultMap.put("data", aiData);
	            resultMap.put("excel_path", aiRes.get("excel_path"));
	        }

	        if (tempFile.exists()) tempFile.delete();

	    } catch (Exception e) {
	        e.printStackTrace();
	        resultMap.put("status", "error");
	        resultMap.put("message", "AI 분석 중 오류: " + e.getMessage());
	    }

	    return resultMap;
	}
	
	@RequestMapping(value = "/pms/meetingDetail.do")
	public String selectMeetingDetail(MeetingVO vo, ModelMap model) throws Exception {
	    MeetingVO result = meetingService.selectMeetingById(vo);
	    model.addAttribute("meeting", result);
	    return "egovframework/com/pms/MeetingDetail";
	}
	
	@RequestMapping(value = "/pms/updateMeetingView.do")
	public String meetingUpdtView(MeetingVO meetingVO, ModelMap model) throws Exception {
	    
	    Map<String, Object> dummyData = new HashMap<>();
	    dummyData.put("summary", "회의 요약 내용 출력");
	    dummyData.put("action_items", "1. 다음 회의 준비\n2. 결과 보고서 작성");
	    
	    Map<String, Object> dummyRes = new HashMap<>();
	    dummyRes.put("status", "success");
	    dummyRes.put("data", dummyData);
	    
	    model.addAttribute("res", dummyRes);
	    
	    return "egovframework/com/pms/MeetingUpdt";
	}
	
	@RequestMapping("/pms/downloadExcel.do")
	public void downloadExcel(@RequestParam("filePath") String filePath, HttpServletResponse response) throws Exception {
	    
	    String fileName = new File(filePath).getName();
	    
	    String fixedPath = "D:" + File.separator + "pms_uploads" + File.separator + "results";
	    File file = new File(fixedPath, fileName);

	    System.out.println("🔎 [Download] 찾는 위치: " + file.getAbsolutePath());

	    if (file.exists()) {
	        String downloadName = "AI_Meeting_Report.xlsx";
	        
	        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
	        response.setHeader("Content-Disposition", "attachment; filename=\"" + downloadName + "\"");
	        
	        Files.copy(file.toPath(), response.getOutputStream());
	        response.getOutputStream().flush();
	    } else {
	        System.out.println("❌ [Download] 파일을 찾을 수 없습니다! (D드라이브 확인 필요)");
	        response.setStatus(404);
	    }
	}

	@RequestMapping(value = "/pms/analyzeRiskDocument.do")
	@ResponseBody
	public Map<String, Object> analyzeRiskDocument(final MultipartHttpServletRequest multiRequest) throws Exception {
	    Map<String, Object> resultMap = new HashMap<>();
	    
	    String projIdStr = multiRequest.getParameter("projId");
	    String docDt = multiRequest.getParameter("docDt");
	    Integer pId = (projIdStr == null || projIdStr.isEmpty() || "null".equals(projIdStr)) ? 1 : Integer.parseInt(projIdStr);
	    
	    Map<String, MultipartFile> files = multiRequest.getFileMap();
	    MultipartFile mFile = files.get("uploadDoc");

	    if (mFile == null || mFile.isEmpty()) {
	        resultMap.put("status", "error");
	        resultMap.put("message", "분석할 문서 파일이 없습니다.");
	        return resultMap;
	    }

	    try {
	        List<FileVO> result = fileUtil.parseFileInf(files, "RISK_", 0, "", "");
	        String atchFileId = fileMngService.insertFileInfs(result);
	        
	        String tempDir = System.getProperty("java.io.tmpdir");
	        File tempFile = new File(tempDir + File.separator + mFile.getOriginalFilename());
	        mFile.transferTo(tempFile);

	        org.springframework.web.client.RestTemplate restTemplate = new org.springframework.web.client.RestTemplate();
	        String pythonUrl = "http://127.0.0.1:8002/api/v1/analyze/risk";

	        org.springframework.http.HttpHeaders headers = new org.springframework.http.HttpHeaders();
	        headers.setContentType(org.springframework.http.MediaType.MULTIPART_FORM_DATA);

	        org.springframework.util.MultiValueMap<String, Object> body = new org.springframework.util.LinkedMultiValueMap<>();
	        body.add("file", new org.springframework.core.io.FileSystemResource(tempFile));
	        body.add("project_id", pId);
	        body.add("report_id", 1001);

	        org.springframework.http.HttpEntity<org.springframework.util.MultiValueMap<String, Object>> requestEntity = 
	            new org.springframework.http.HttpEntity<>(body, headers);

	        org.springframework.http.ResponseEntity<Map> response = 
	            restTemplate.postForEntity(pythonUrl, requestEntity, Map.class);

	        if (response.getStatusCode() == org.springframework.http.HttpStatus.OK) {
	            Map<String, Object> aiRes = (Map<String, Object>) response.getBody();
	            
	            LogVO logVO = new LogVO();
	            logVO.setProjId(pId);
	            logVO.setFileId(atchFileId);
	            logVO.setAiCategory("RISK");
	            logVO.setInputData("파일명: " + mFile.getOriginalFilename());
	            logVO.setOutputData(aiRes.toString());
	            
	            Object riskScore = aiRes.get("risk_score");
	            logVO.setConfidenceIndex(new java.math.BigDecimal(riskScore != null ? riskScore.toString() : "0"));
	            logVO.setReasoning((String) aiRes.get("analysis_summary"));
	            logVO.setDocDt(docDt);
	            egovframework.com.cmm.LoginVO user = (egovframework.com.cmm.LoginVO) egovframework.com.cmm.util.EgovUserDetailsHelper.getAuthenticatedUser();
	            logVO.setLastUpdusrId(user != null ? user.getUniqId() : "AI_SYSTEM");

	            meetingService.insertLog(logVO);

	            resultMap.put("status", "success");
	            resultMap.put("data", aiRes);
	        }

	        if (tempFile.exists()) tempFile.delete();

	    } catch (Exception e) {
	        e.printStackTrace();
	        resultMap.put("status", "error");
	        resultMap.put("message", "리스크 분석 중 오류: " + e.getMessage());
	    }

	    return resultMap;
	}
	
}