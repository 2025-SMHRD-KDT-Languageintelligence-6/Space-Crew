package egovframework.com.pms.service;

import java.util.List;

public interface CustomerService {
    List<CustomerVO> selectCustomerList(CustomerVO vo) throws Exception;
    
    int selectCustomerListTotCnt(CustomerVO vo) throws Exception;
    
    CustomerVO selectCustomerDetail(Integer id) throws Exception;
    
    void saveCustomer(CustomerVO vo) throws Exception;
    
    void deleteCustomer(Integer id) throws Exception;
}