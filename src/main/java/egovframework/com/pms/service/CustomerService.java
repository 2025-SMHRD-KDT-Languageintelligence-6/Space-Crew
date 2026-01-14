package egovframework.com.pms.service;

import java.util.List;
import java.util.Map;

public interface CustomerService {
	
    List<CustomerVO> selectCustomerList(CustomerVO vo) throws Exception;
    
    int selectCustomerListTotCnt(CustomerVO vo) throws Exception;
    
    CustomerVO selectCustomerDetail(Integer id) throws Exception;
    
    void saveCustomer(CustomerVO vo) throws Exception;
    
    void deleteCustomer(CustomerVO vo) throws Exception;

	void updateCustomer(CustomerVO vo) throws Exception;

	void deleteFavorite(Map<String, Object> param) throws Exception;

	int selectFavoriteCount(Map<String, Object> param) throws Exception;

	void insertFavorite(Map<String, Object> param) throws Exception;
}