package egovframework.com.pms.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;

import egovframework.com.pms.service.ContractService;
import egovframework.com.pms.service.ContractVO;

@Service("contractService")
public class ContractServiceImpl extends EgovAbstractServiceImpl implements ContractService {

    @Resource(name = "contractMapper")
    private ContractMapper contractMapper;

    @Override
    public List<ContractVO> selectContractList(ContractVO vo) throws Exception {
        return contractMapper.selectContractList(vo);
    }

    @Override
    public int selectContractListTotCnt(ContractVO vo) throws Exception {
        return contractMapper.selectContractListTotCnt(vo);
    }

    @Override
    public void saveContract(ContractVO vo) throws Exception {
        if (vo.getContId() == null || vo.getContId() == 0) {
            contractMapper.insertContract(vo);
        } else {
            contractMapper.updateContract(vo);
        }
    }
    
    @Override
    public ContractVO selectContractDetail(Long id) throws Exception {
        return contractMapper.selectContractDetail(id);
    }
    
    @Override
    public void deleteContract(ContractVO vo) throws Exception {
        contractMapper.deleteContract(vo);
    }

    @Override
    public void updateContract(ContractVO vo) throws Exception {
        contractMapper.updateContract(vo);
    }
    
}