package egovframework.com.pms.service;

import java.util.List;

public interface SalesService {
    List<SalesVO> selectSalesList(SalesVO vo) throws Exception;
    int selectSalesListTotCnt(SalesVO vo) throws Exception;
    void saveSales(SalesVO vo) throws Exception;
    SalesVO selectSalesDetail(Long id) throws Exception;
    void deleteSales(Long id) throws Exception;
}