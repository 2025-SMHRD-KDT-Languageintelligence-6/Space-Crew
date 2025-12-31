package egovframework.example.pms.service.impl;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.example.pms.domain.Contract;
import egovframework.example.pms.domain.User;
import egovframework.example.pms.dto.ContractDTO;
import egovframework.example.pms.repository.ContractRepository;
import egovframework.example.pms.repository.UserRepository;
import egovframework.example.pms.service.ContractService;

@Service
@RequiredArgsConstructor
@Transactional
public class ContractServiceImpl implements ContractService {

    private final ContractRepository contractRepository;
    private final UserRepository userRepository;

    @Override
    @Transactional(readOnly = true)
    public Page<ContractDTO> getContractList(String keyword, int page) {
        Pageable pageable = PageRequest.of(page, 10, Sort.by("contId").descending());
        Page<Contract> entities;

        if (keyword != null && !keyword.isEmpty()) {
            entities = contractRepository.findByContNmContaining(keyword, pageable);
        } else {
            entities = contractRepository.findAll(pageable);
        }

        return entities.map(entity -> {
            ContractDTO dto = new ContractDTO();
            dto.setContId(entity.getContId());
            dto.setSalesId(entity.getSalesId());
            dto.setContNm(entity.getContNm());
            dto.setContAmt(entity.getContAmt());
            dto.setStartDt(entity.getStartDt());
            dto.setEndDt(entity.getEndDt());
            dto.setContDt(entity.getContDt());
            dto.setContStatus(entity.getContStatus());
            
            if (entity.getPicUser() != null) {
                dto.setPicUserName(entity.getPicUser().getUserNm());
            }
            return dto;
        });
    }

    @Override
    public void saveContract(ContractDTO dto) {
        Contract contract = new Contract();
        
        if (dto.getContId() != null) {
            contract = contractRepository.findById(dto.getContId())
                    .orElseThrow(() -> new IllegalArgumentException("Invalid contract ID"));
        }

        contract.setSalesId(dto.getSalesId());
        contract.setContNm(dto.getContNm());
        contract.setContAmt(dto.getContAmt());
        contract.setStartDt(dto.getStartDt());
        contract.setEndDt(dto.getEndDt());
        contract.setContDt(dto.getContDt());
        contract.setContStatus(dto.getContStatus());
        contract.setContRemark(dto.getContRemark());

        if (dto.getPicUserId() != null) {
            User user = userRepository.findById(dto.getPicUserId())
                    .orElseThrow(() -> new IllegalArgumentException("Invalid User ID"));
            contract.setPicUser(user);
        }

        contractRepository.save(contract);
    }

    @Override
    @Transactional(readOnly = true)
    public ContractDTO getContractById(Long id) {
        Contract entity = contractRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Invalid contract ID"));
        
        ContractDTO dto = new ContractDTO();
        dto.setContId(entity.getContId());
        dto.setSalesId(entity.getSalesId());
        dto.setContNm(entity.getContNm());
        dto.setContAmt(entity.getContAmt());
        dto.setStartDt(entity.getStartDt());
        dto.setEndDt(entity.getEndDt());
        dto.setContDt(entity.getContDt());
        dto.setContStatus(entity.getContStatus());
        dto.setContRemark(entity.getContRemark());

        if (entity.getPicUser() != null) {
            dto.setPicUserId(entity.getPicUser().getUserId());
            dto.setPicUserName(entity.getPicUser().getUserNm());
        }
        
        return dto;
    }

    @Override
    public void deleteContract(Long id) {
        contractRepository.deleteById(id);
    }
}