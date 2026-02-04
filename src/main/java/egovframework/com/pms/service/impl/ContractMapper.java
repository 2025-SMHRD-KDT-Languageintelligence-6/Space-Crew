package egovframework.com.pms.service.impl;

import java.util.List;
import java.util.Map;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;
import egovframework.com.pms.service.ContractVO;
import egovframework.com.pms.service.SalesVO;

@Mapper("contractMapper")
public interface ContractMapper {
    List<ContractVO> selectContractList(ContractVO vo) throws Exception;
    int selectContractListTotCnt(ContractVO vo);
    ContractVO selectContractDetail(Long id) throws Exception;
    void insertContract(ContractVO vo) throws Exception;
    void updateContract(ContractVO vo) throws Exception;
	void deleteContract(ContractVO vo) throws Exception;
	void updateContractStatus(Map<String, Object> param) throws Exception;
	void updateContractAtchFileId(Map<String, Object> map);
	List<SalesVO> selectAvailableSalesList();
}