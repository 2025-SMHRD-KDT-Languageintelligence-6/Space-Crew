package egovframework.com.pms.service;

import java.util.List;


public interface UserService {

    List<UserVO> selectUserList(UserVO vo) throws Exception;

    int selectUserListTotCnt(UserVO vo) throws Exception;

    UserVO selectUserDetail(String id) throws Exception;

    void saveUser(UserVO vo) throws Exception;

    void deleteUser(String id) throws Exception;
}