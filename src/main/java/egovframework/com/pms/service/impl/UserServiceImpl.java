package egovframework.com.pms.service.impl;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.com.pms.service.ProjectAssignVO;
import egovframework.com.pms.service.UserService;
import egovframework.com.pms.service.UserVO;

@Service("userService")
public class UserServiceImpl extends EgovAbstractServiceImpl implements UserService {

    @Resource(name = "userMapper")
    private UserMapper userMapper;

    @Override
    public List<UserVO> selectUserList(UserVO vo) throws Exception {
    	List<UserVO> userList = userMapper.selectUserList(vo);
        
    	LocalDate today = LocalDate.now();
        LocalDate thirtyDaysLater = today.plusDays(30);
        
        long totalWorkingDays30 = countWorkingDays(today, thirtyDaysLater);

        if (totalWorkingDays30 == 0) return userList; 

        for (UserVO user : userList) {
            List<ProjectAssignVO> assignments = userMapper.selectActiveAssignments(user.getUserId());
            
            double effortScore30Days = 0.0;
            double effortScoreTotalFuture = 0.0;

            for (ProjectAssignVO assign : assignments) {
                if (assign.getStartDt() == null || assign.getEndDt() == null) continue;

                try {
                    LocalDate start = LocalDate.parse(assign.getStartDt());
                    LocalDate end = LocalDate.parse(assign.getEndDt());
                    double rate = (assign.getInputRate() != null) ? assign.getInputRate() : 0.0;

                    LocalDate overlapStart30 = start.isBefore(today) ? today : start;
                    LocalDate overlapEnd30 = end.isAfter(thirtyDaysLater) ? thirtyDaysLater : end;
                    
                    if (!overlapStart30.isAfter(overlapEnd30)) {
                        long workingDays30 = countWorkingDays(overlapStart30, overlapEnd30);
                        effortScore30Days += (rate * workingDays30);
                    }

                    LocalDate futureStart = start.isBefore(today) ? today : start;
                    
                    if (!futureStart.isAfter(end)) {
                        long futureWorkingDays = countWorkingDays(futureStart, end);
                        effortScoreTotalFuture += (rate * futureWorkingDays);
                    }

                } catch (Exception e) {
                    continue; 
                }
            }

            double loadPercent = (effortScore30Days / (double) totalWorkingDays30) * 100;
            user.setCurrentLoad(BigDecimal.valueOf(Math.round(loadPercent)));
            
            user.setRemainingMM(effortScoreTotalFuture / 20.0); 
        }
        
        return userList;
    }

    private long countWorkingDays(LocalDate start, LocalDate end) {
        return start.datesUntil(end.plusDays(1))
                    .filter(date -> {
                        java.time.DayOfWeek day = date.getDayOfWeek();
                        return day != java.time.DayOfWeek.SATURDAY && day != java.time.DayOfWeek.SUNDAY;
                    })
                    .count();
    }
    
	@Override
    public int selectUserListTotCnt(UserVO vo) throws Exception {
        return userMapper.selectUserListTotCnt(vo);
    }

    @Override
    public void saveUser(UserVO vo) throws Exception {
    	UserVO check = userMapper.selectUserDetail(vo.getUserId());
    	if (check == null) {
    		userMapper.insertUser(vo);
    	} else {
    		userMapper.updateUser(vo);
    	}
    }
    
    @Override
    public UserVO selectUserDetail(String id) throws Exception {
        return userMapper.selectUserDetail(id);
    }

    @Override
    public void deleteUser(UserVO vo) throws Exception {
        userMapper.deleteUser(vo);
    }
    
    @Override
    public void updateUser(UserVO vo) throws Exception {
        userMapper.updateUser(vo);
    }
    
    @Override
    public void updateUserAtchFileId(UserVO vo) throws Exception {
        userMapper.updateUserAtchFileId(vo);
    }
}