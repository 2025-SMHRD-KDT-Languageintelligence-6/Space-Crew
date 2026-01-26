package egovframework.com.pms.service.impl;

import java.util.List;
import java.util.Map;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;
import egovframework.com.pms.service.CustomerVO;

@Mapper("customerMapper")
public interface CustomerMapper {
    List<CustomerVO> selectCustomerList(CustomerVO vo) throws Exception;
    int selectCustomerListTotCnt(CustomerVO vo);
    CustomerVO selectCustomerDetail(Integer id) throws Exception;
    void insertCustomer(CustomerVO vo) throws Exception;
    void updateCustomer(CustomerVO vo) throws Exception;
	void deleteCustomer(CustomerVO vo) throws Exception;
	
	int selectFavoriteCount(Map<String, Object> param) throws Exception;
	void insertFavorite(Map<String, Object> param) throws Exception;
	void deleteFavorite(Map<String, Object> param) throws Exception;
	void updateCustomerAtchFileId(Map<String, Object> map);
}