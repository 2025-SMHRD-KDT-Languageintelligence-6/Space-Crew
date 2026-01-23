package egovframework.com.pms.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.http.*;
import java.util.HashMap;
import java.util.Map;

@Controller
public class PmsMeetingController {

    // 1. 페이지 호출 (URL: /pms/meetingView.do)
    @RequestMapping("/pms/meetingView.do")
    public String meetingViewPage() {
        // JSP 파일의 물리적 경로: /WEB-INF/jsp/egovframework/com/pms/meeting_view.jsp
        return "egovframework/com/pms/meeting_view";
    }

    // 2. 분석 실행 (URL: /pms/analyzeMeetingData.do)
    @RequestMapping("/pms/analyzeMeetingData.do")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> analyzeMeetingData(@RequestParam("uploadAudio") MultipartFile file) {
        Map<String, Object> resultMap = new HashMap<>();
        try {
            // 우선 자바가 파일을 정상적으로 받았는지 로그로 확인
            System.out.println("받은 파일명: " + file.getOriginalFilename());
            System.out.println("파일 크기: " + file.getSize());

            // 파이썬 연결 전이므로 가짜 데이터(Dummy)를 반환하여 연동 확인
            resultMap.put("status", "success");
            resultMap.put("message", "자바 컨트롤러가 파일을 성공적으로 수신했습니다.");

            Map<String, String> dummyData = new HashMap<>();
            dummyData.put("summary", "파이썬 연동 전 테스트 요약입니다.");
            dummyData.put("action_items", "1. 테스트 결정사항입니다.");
            resultMap.put("data", dummyData);

            return new ResponseEntity<>(resultMap, HttpStatus.OK);
        } catch (Exception e) {
            resultMap.put("status", "error");
            resultMap.put("message", e.getMessage());
            return new ResponseEntity<>(resultMap, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}