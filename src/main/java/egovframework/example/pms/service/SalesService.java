package egovframework.example.pms.service;

import org.springframework.data.domain.Page;
import egovframework.example.pms.dto.SalesDTO;

public interface SalesService {
    Page<SalesDTO> getSalesList(String keyword, int page);
    SalesDTO getSalesById(Long id);
    void saveSales(SalesDTO dto);
    void deleteSales(Long id);
}