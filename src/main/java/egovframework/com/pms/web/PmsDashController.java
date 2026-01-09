package egovframework.com.pms.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class PmsDashController {

    /**
     * 오너 대시보드 화면 호출
     */
    @RequestMapping(value = "/pms/dash/main_own.do")
    public String selectOwnerMain() throws Exception {

        // WEB-INF/jsp/와 .jsp 사이의 경로만 리턴합니다.
        // 설정된 ViewResolver에 따라 경로가 완성됩니다.
        return "egovframework/com/pms/dash/main_own";

    }
}