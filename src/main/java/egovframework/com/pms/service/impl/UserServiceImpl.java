package egovframework.com.pms.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;

import egovframework.com.pms.service.UserService;
import egovframework.com.pms.service.UserVO;

@Service("userService")
public class UserServiceImpl extends EgovAbstractServiceImpl implements UserService {

    @Resource(name = "userMapper")
    private UserMapper userMapper;

    @Override
    public List<UserVO> selectUserList(UserVO vo) throws Exception {
        return userMapper.selectUserList(vo);
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