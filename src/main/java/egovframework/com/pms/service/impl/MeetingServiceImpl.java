package egovframework.com.pms.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.com.pms.service.MeetingService;
import egovframework.com.pms.service.MeetingVO;

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
}