package egovframework.example.pms.service;

import org.springframework.data.domain.Page;

import egovframework.example.pms.dto.BillingDTO;

public interface BillingService {
    Page<BillingDTO> getBillingList(String keyword, int page);
    BillingDTO getBillingById(Long id);
    void saveBilling(BillingDTO dto);
    void deleteBilling(Long id);
}