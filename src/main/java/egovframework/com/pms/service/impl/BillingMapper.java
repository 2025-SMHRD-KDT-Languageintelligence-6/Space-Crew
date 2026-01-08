package egovframework.com.pms.service.impl;

import java.util.List;
import org.egovframe.rte.psl.dataaccess.mapper.Mapper;
import egovframework.com.pms.service.BillingVO;

@Mapper("billingMapper")
public interface BillingMapper {
    List<BillingVO> selectBillingList(BillingVO vo) throws Exception;
    int selectBillingListTotCnt(BillingVO vo);
    BillingVO selectBillingDetail(Long id) throws Exception;
    void insertBilling(BillingVO vo) throws Exception;
    void updateBilling(BillingVO vo) throws Exception;
    void deleteBilling(Long id) throws Exception;
}