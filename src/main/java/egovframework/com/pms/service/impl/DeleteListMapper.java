package egovframework.com.pms.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.com.pms.service.DeleteListVO;

@Mapper("DeleteListMapper")
public interface DeleteListMapper {
	List<DeleteListVO> selectDeleteList(DeleteListVO vo) throws Exception;
	void restoreData(DeleteListVO vo) throws Exception;
	int selectDeleteListTotCnt(DeleteListVO vo);
	
}
