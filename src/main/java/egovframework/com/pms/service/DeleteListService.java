package egovframework.com.pms.service;

import java.util.List;

public interface DeleteListService {
	List<DeleteListVO> selectDeleteList(DeleteListVO vo) throws Exception;
	void restoreData(DeleteListVO vo) throws Exception;
	int selectDeleteListTotCnt(DeleteListVO vo);
}
