package egovframework.com.pms.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.com.pms.service.LogVO;
import egovframework.com.pms.service.MeetingVO;

@Mapper("meetingMapper")
public interface MeetingMapper {

    List<MeetingVO> selectMeetingList(MeetingVO vo) throws Exception;

    MeetingVO selectMeetingDetail(String meetId) throws Exception;

    void insertMeeting(MeetingVO vo) throws Exception;

	MeetingVO selectMeetingDetail(MeetingVO vo) throws Exception;
	
	void insertLog(LogVO vo) throws Exception;

	List<LogVO> selectRecentRiskAlert() throws Exception;

}