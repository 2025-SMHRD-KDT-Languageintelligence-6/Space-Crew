package egovframework.com.pms.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.com.pms.service.DeleteListService;
import egovframework.com.pms.service.DeleteListVO;

@Service("DeleteListService")
public class DeleteListServiceImpl extends EgovAbstractServiceImpl implements DeleteListService{
	
	@Resource(name="DeleteListMapper")
    private DeleteListMapper deleteListMapper;
	
	@Override
	public List<DeleteListVO> selectDeleteList(DeleteListVO vo) throws Exception {
		return deleteListMapper.selectDeleteList(vo);
	}

	@Override
	public void restoreData(DeleteListVO vo) throws Exception {
		deleteListMapper.restoreData(vo);
		
	}

	@Override
	public int selectDeleteListTotCnt(DeleteListVO vo) {
		return deleteListMapper.selectDeleteListTotCnt(vo);
	}

}
