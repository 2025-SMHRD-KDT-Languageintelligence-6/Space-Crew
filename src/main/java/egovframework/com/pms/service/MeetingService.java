package egovframework.com.pms.service;

import java.util.List;

public interface MeetingService {

    List<MeetingVO> selectMeetingList(MeetingVO vo) throws Exception;

    MeetingVO selectMeetingDetail(String meetId) throws Exception;

    void insertMeeting(MeetingVO vo) throws Exception;

	MeetingVO selectMeetingById(MeetingVO vo) throws Exception;

    RiskAnalysisVO detectProjectRisk(RiskAnalysisVO vo) throws Exception;
}