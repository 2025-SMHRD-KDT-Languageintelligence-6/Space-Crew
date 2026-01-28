package egovframework.com.pms.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.com.pms.service.MeetingVO;

@Mapper("meetingMapper")
public interface MeetingMapper {

    List<MeetingVO> selectMeetingList(MeetingVO vo) throws Exception;

    MeetingVO selectMeetingDetail(String meetId) throws Exception;

    void insertMeeting(MeetingVO vo) throws Exception;

	MeetingVO selectMeetingDetail(MeetingVO vo) throws Exception;
}