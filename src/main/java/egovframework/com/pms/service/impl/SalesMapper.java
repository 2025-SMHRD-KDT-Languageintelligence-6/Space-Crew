package egovframework.com.pms.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.com.pms.service.SalesVO;
import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

@Mapper("salesMapper")
public interface SalesMapper {
    List<SalesVO> selectSalesList(SalesVO vo) throws Exception;
    int selectSalesListTotCnt(SalesVO vo);
    SalesVO selectSalesDetail(Long id) throws Exception;
    void insertSales(SalesVO vo) throws Exception;
    void updateSales(SalesVO vo) throws Exception;
    void deleteSales(SalesVO vo) throws Exception;
	void updateSalesStatus(Map<String, Object> param) throws Exception;
}

