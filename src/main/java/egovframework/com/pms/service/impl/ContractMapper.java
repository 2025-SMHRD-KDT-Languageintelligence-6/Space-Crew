package egovframework.com.pms.service.impl;

import java.util.List;
import org.egovframe.rte.psl.dataaccess.mapper.Mapper;
import egovframework.com.pms.service.ContractVO;

@Mapper("contractMapper")
public interface ContractMapper {
    List<ContractVO> selectContractList(ContractVO vo) throws Exception;
    int selectContractListTotCnt(ContractVO vo);
    ContractVO selectContractDetail(Long id) throws Exception;
    void insertContract(ContractVO vo) throws Exception;
    void updateContract(ContractVO vo) throws Exception;
	void deleteContract(ContractVO vo) throws Exception;
}