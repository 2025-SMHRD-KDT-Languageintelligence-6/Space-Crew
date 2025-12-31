package egovframework.example.pms.service.impl;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.example.pms.domain.Customer;
import egovframework.example.pms.domain.Sales;
import egovframework.example.pms.domain.User;
import egovframework.example.pms.dto.SalesDTO;
import egovframework.example.pms.repository.CustomerRepository;
import egovframework.example.pms.repository.SalesRepository;
import egovframework.example.pms.repository.UserRepository;
import egovframework.example.pms.service.SalesService;

@Service
@RequiredArgsConstructor
@Transactional
public class SalesServiceImpl implements SalesService {

    private final SalesRepository salesRepository;
    private final CustomerRepository customerRepository;
    private final UserRepository userRepository;

    @Override
    @Transactional(readOnly = true)
    public Page<SalesDTO> getSalesList(String keyword, int page) {
        Pageable pageable = PageRequest.of(page, 10, Sort.by("salesId").descending());
        Page<Sales> entities;

        if (keyword != null && !keyword.isEmpty()) {
            entities = salesRepository.findBySalesTitleContaining(keyword, pageable);
        } else {
            entities = salesRepository.findAll(pageable);
        }

        return entities.map(entity -> {
            SalesDTO dto = new SalesDTO();
            dto.setSalesId(entity.getSalesId());
            dto.setSalesTitle(entity.getSalesTitle());
            dto.setExpectedAmt(entity.getExpectedAmt());
            dto.setExpectedDt(entity.getExpectedDt());
            dto.setProbability(entity.getProbability());
            dto.setStatus(entity.getStatus());
            dto.setRegDt(entity.getRegDt());
            
            if (entity.getCustomer() != null) {
                dto.setCustomerName(entity.getCustomer().getCustNm());
            }
            if (entity.getSalesUser() != null) {
                dto.setSalesUserName(entity.getSalesUser().getUserNm());
            }
            return dto;
        });
    }

    @Override
    public void saveSales(SalesDTO dto) {
        Sales sales = new Sales();
        
        if (dto.getSalesId() != null) {
            sales = salesRepository.findById(dto.getSalesId())
                    .orElseThrow(() -> new IllegalArgumentException("Invalid sales ID"));
        }

        sales.setSalesTitle(dto.getSalesTitle());
        sales.setExpectedAmt(dto.getExpectedAmt());
        sales.setExpectedDt(dto.getExpectedDt());
        sales.setProbability(dto.getProbability());
        sales.setStatus(dto.getStatus());
        sales.setSalesContent(dto.getSalesContent());
        
        if (dto.getCustomerId() != null) {
            Customer customer = customerRepository.findById(dto.getCustomerId())
                    .orElseThrow(() -> new IllegalArgumentException("Invalid Customer ID"));
            sales.setCustomer(customer);
        }
        
        if (dto.getSalesUserId() != null && !dto.getSalesUserId().isEmpty()) {
            User user = userRepository.findById(dto.getSalesUserId())
                    .orElseThrow(() -> new IllegalArgumentException("Invalid User ID"));
            sales.setSalesUser(user);
        }

        salesRepository.save(sales);
    }

    @Override
    @Transactional(readOnly = true)
    public SalesDTO getSalesById(Long id) {
        Sales entity = salesRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Invalid sales ID"));
        
        SalesDTO dto = new SalesDTO();
        dto.setSalesId(entity.getSalesId());
        dto.setSalesTitle(entity.getSalesTitle());
        dto.setExpectedAmt(entity.getExpectedAmt());
        dto.setExpectedDt(entity.getExpectedDt());
        dto.setProbability(entity.getProbability());
        dto.setStatus(entity.getStatus());
        dto.setSalesContent(entity.getSalesContent());
        dto.setRegDt(entity.getRegDt());

        if (entity.getCustomer() != null) {
            dto.setCustomerId(entity.getCustomer().getCustId());
            dto.setCustomerName(entity.getCustomer().getCustNm());
        }
        
        if (entity.getSalesUser() != null) {
            dto.setSalesUserId(entity.getSalesUser().getUserId());
            dto.setSalesUserName(entity.getSalesUser().getUserNm());
        }
        
        return dto;
    }

    @Override
    public void deleteSales(Long id) {
        salesRepository.deleteById(id);
    }
}