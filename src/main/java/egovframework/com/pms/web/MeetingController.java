package egovframework.com.pms.web;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.cmm.service.EgovFileMngService;
import egovframework.com.cmm.service.EgovFileMngUtil;
import egovframework.com.cmm.service.FileVO;
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
	public String selectMeetingList(MeetingVO meetingVO, ModelMap model) throws Exception {

	    List<MeetingVO> dbMeetingList = meetingService.selectMeetingList(meetingVO);

	    Calendar cal = Calendar.getInstance();
	    SimpleDateFormat sdf = new SimpleDateFormat("d");
	    SimpleDateFormat fullSdf = new SimpleDateFormat("yyyyMMdd");
	    SimpleDateFormat dbSdf = new SimpleDateFormat("yyyy-MM-dd");

	    int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
	    cal.add(Calendar.DATE, (dayOfWeek - 1) * -1);

	    List<Map<String, Object>> weekDays = new ArrayList<>();
	    Calendar today = Calendar.getInstance();
	    String todayStr = fullSdf.format(today.getTime());

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

	    cal.setTime(new Date());
	    List<Map<String, Object>> weeklyList = new ArrayList<>();

	    for (int i = 0; i < 2; i++) {
	        Map<String, Object> weekMap = new HashMap<>();

	        int month = cal.get(Calendar.MONTH) + 1;
	        int weekOfMonth = cal.get(Calendar.WEEK_OF_MONTH);
	        
	        weekMap.put("weekLabel", month + "월 " + weekOfMonth + "주차");
	        weekMap.put("weekNum", weekOfMonth + "W");
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
	    model.addAttribute("currentMonth", today.get(Calendar.MONTH) + 1);
	    
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
	    
	    Map<String, MultipartFile> files = multiRequest.getFileMap();
	    
	    if (!files.isEmpty()) {
	        List<FileVO> result = fileUtil.parseFileInf(files, "MEET_", 0, "", "Globals.fileStorePath");
	        String atchFileId = fileMngService.insertFileInfs(result);

	        MeetingVO vo = new MeetingVO();
	        vo.setMeetTitle(result.get(0).getOrignlFileNm());
	        vo.setAtchFileId(atchFileId);
	        
	        String meetDt = multiRequest.getParameter("meetDt");
	        vo.setMeetDt(meetDt);
	        vo.setLastUpdusrId("webmaster");
	        vo.setContentSum("표준 테이블 연동 업로드 완료.");
	        vo.setActionItems(" ");

	        meetingService.insertMeeting(vo); 

	        resultMap.put("status", "success");
	        resultMap.put("meetId", vo.getMeetId());
	    } else {
	        resultMap.put("status", "fail");
	        resultMap.put("message", "파일이 전송되지 않았습니다.");
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
	
}