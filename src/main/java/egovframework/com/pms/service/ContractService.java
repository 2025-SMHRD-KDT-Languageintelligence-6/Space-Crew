package egovframework.com.pms.service;

import java.util.List;
import java.util.Map;

public interface ContractService {
	
    List<ContractVO> selectContractList(ContractVO vo) throws Exception;

    int selectContractListTotCnt(ContractVO vo) throws Exception;

    ContractVO selectContractDetail(Long id) throws Exception;

    void saveContract(ContractVO vo) throws Exception;

	void updateContract(ContractVO vo) throws Exception;

	void deleteContract(ContractVO vo) throws Exception;

	void updateContractStatus(Map<String, Object> param) throws Exception;
	
	List<SalesVO> selectAvailableSalesList() throws Exception;
}