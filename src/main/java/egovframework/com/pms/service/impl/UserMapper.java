package egovframework.com.pms.service.impl;

import java.util.List;
import org.egovframe.rte.psl.dataaccess.mapper.Mapper;
import egovframework.com.pms.service.UserVO;

@Mapper("userMapper")
public interface UserMapper {
    List<UserVO> selectUserList(UserVO vo) throws Exception;
    int selectUserListTotCnt(UserVO vo);
    UserVO selectUserDetail(String id) throws Exception;
    void insertUser(UserVO vo) throws Exception;
    void updateUser(UserVO vo) throws Exception;
    void deleteUser(String id) throws Exception;
}