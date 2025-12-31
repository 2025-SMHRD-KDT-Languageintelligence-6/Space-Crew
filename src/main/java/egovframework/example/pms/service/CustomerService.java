package egovframework.example.pms.service;

import org.springframework.data.domain.Page;
import egovframework.example.pms.dto.CustomerDTO;

public interface CustomerService {
    Page<CustomerDTO> getCustomerList(String keyword, int page);
    CustomerDTO getCustomerById(Long id);
    void saveCustomer(CustomerDTO dto);
    void deleteCustomer(Long id);
}