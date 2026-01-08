package egovframework.com.pms.service;

import java.util.List;

public interface ContractService {
    List<ContractVO> selectContractList(ContractVO vo) throws Exception;

    int selectContractListTotCnt(ContractVO vo) throws Exception;

    ContractVO selectContractDetail(Long id) throws Exception;

    void saveContract(ContractVO vo) throws Exception;

    void deleteContract(Long id) throws Exception;
}