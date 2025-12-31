package egovframework.example.pms.service;

import org.springframework.data.domain.Page;

import egovframework.example.pms.dto.ContractDTO;

public interface ContractService {
    Page<ContractDTO> getContractList(String keyword, int page);
    ContractDTO getContractById(Long id);
    void saveContract(ContractDTO dto);
    void deleteContract(Long id);
}