package egovframework.example.pms.service.impl;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.example.pms.domain.Customer;
import egovframework.example.pms.dto.CustomerDTO;
import egovframework.example.pms.repository.CustomerRepository;
import egovframework.example.pms.service.CustomerService;

@Service
@RequiredArgsConstructor
@Transactional
public class CustomerServiceImpl implements CustomerService {

    private final CustomerRepository customerRepository;

    @Override
    @Transactional(readOnly = true)
    public Page<CustomerDTO> getCustomerList(String keyword, int page) {
        Pageable pageable = PageRequest.of(page, 10, Sort.by("custId").descending());
        Page<Customer> entities;

        if (keyword != null && !keyword.isEmpty()) {
            entities = customerRepository.findByCustNmContaining(keyword, pageable);
        } else {
            entities = customerRepository.findAll(pageable);
        }

        return entities.map(entity -> {
            CustomerDTO dto = new CustomerDTO();
            dto.setCustId(entity.getCustId());
            dto.setCustNm(entity.getCustNm());
            dto.setBizRegNo(entity.getBizRegNo());
            dto.setCeoNm(entity.getCeoNm());
            dto.setPicNm(entity.getPicNm());
            dto.setPicTel(entity.getPicTel());
            dto.setPicEmail(entity.getPicEmail());
            dto.setCustAddr(entity.getCustAddr());
            dto.setCustRemark(entity.getCustRemark());
            return dto;
        });
    }

    @Override
    public void saveCustomer(CustomerDTO dto) {
        Customer customer = new Customer();
        
        if (dto.getCustId() != null) {
            customer = customerRepository.findById(dto.getCustId())
                    .orElseThrow(() -> new IllegalArgumentException("Invalid customer Id"));
        }

        customer.setCustNm(dto.getCustNm());
        customer.setBizRegNo(dto.getBizRegNo());
        customer.setCeoNm(dto.getCeoNm());
        customer.setPicNm(dto.getPicNm());
        customer.setPicTel(dto.getPicTel());
        customer.setPicEmail(dto.getPicEmail());
        customer.setCustAddr(dto.getCustAddr());
        customer.setCustRemark(dto.getCustRemark());
        
        customerRepository.save(customer);
    }

    @Override
    @Transactional(readOnly = true)
    public CustomerDTO getCustomerById(Long id) {
        Customer entity = customerRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Invalid customer Id"));
        
        CustomerDTO dto = new CustomerDTO();
        dto.setCustId(entity.getCustId());
        dto.setCustNm(entity.getCustNm());
        dto.setBizRegNo(entity.getBizRegNo());
        dto.setCeoNm(entity.getCeoNm());
        dto.setPicNm(entity.getPicNm());
        dto.setPicTel(entity.getPicTel());
        dto.setPicEmail(entity.getPicEmail());
        dto.setCustAddr(entity.getCustAddr());
        dto.setCustRemark(entity.getCustRemark());
        
        return dto;
    }

    @Override
    public void deleteCustomer(Long id) {
        customerRepository.deleteById(id);
    }
}