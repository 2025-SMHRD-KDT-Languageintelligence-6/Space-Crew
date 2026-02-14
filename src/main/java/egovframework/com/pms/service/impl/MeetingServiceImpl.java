package egovframework.com.pms.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate; // 통신 도구

import egovframework.com.pms.service.LogVO;
import egovframework.com.pms.service.MeetingService;
import egovframework.com.pms.service.MeetingVO;
import egovframework.com.pms.service.RiskAnalysisVO; // 우리가 만든 VO

@Service("meetingService")
public class MeetingServiceImpl extends EgovAbstractServiceImpl implements MeetingService {

    @Resource(name="meetingMapper")
    private MeetingMapper meetingMapper;

    @Override
    public List<MeetingVO> selectMeetingList(MeetingVO vo) throws Exception {
        return meetingMapper.selectMeetingList(vo);
    }

    @Override
    public MeetingVO selectMeetingDetail(String meetId) throws Exception {
        return meetingMapper.selectMeetingDetail(meetId);
    }

    @Override
    @Transactional
    public void insertMeeting(MeetingVO vo) throws Exception {
        meetingMapper.insertMeeting(vo);
    }

	@Override
	public MeetingVO selectMeetingById(MeetingVO vo) throws Exception {
		return meetingMapper.selectMeetingDetail(vo);
	}

	@Override
	public List<LogVO> selectRecentRiskAlert() throws Exception {
	    return meetingMapper.selectRecentRiskAlert();
	}

	
    @Override
    public RiskAnalysisVO detectProjectRisk(RiskAnalysisVO vo) throws Exception {
        // 1. 통신 도구 생성 (실제로는 공통 빈으로 등록해서 쓰는 게 좋지만, 우선 직접 생성합니다)
        RestTemplate restTemplate = new RestTemplate();

        // 2. AI 서버(FastAPI) 주소 - 팀장님 PC에서 돌릴 경우 localhost입니다.
        String fastApiUrl = "http://localhost:8000/api/v1/analyze/risk";

        try {
            // 3. 시스템 통합 실행: Spring(Java)이 FastAPI(Python)에게 데이터를 쏘고 결과를 받아옵니다.
            // 이 한 줄이 바로 팀장님이 강조하신 '이기종 시스템 통합'의 핵심입니다!
            RiskAnalysisVO result = restTemplate.postForObject(fastApiUrl, vo, RiskAnalysisVO.class);

            return result;
        } catch (Exception e) {
            // 4. 예외 처리: AI 서버가 응답하지 않을 때를 대비한 안전장치입니다.
            throw new Exception("AI 분석 서버와의 통신에 실패했습니다. 관리자에게 문의하세요.");
        }
    }

	@Override
	public void insertLog(LogVO vo) throws Exception {
		meetingMapper.insertLog(vo);
	}
}