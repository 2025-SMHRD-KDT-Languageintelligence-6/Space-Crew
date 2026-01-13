package egovframework.com.pms.service;

import java.util.List;

public interface BillingService {

    List<BillingVO> selectBillingList(BillingVO vo) throws Exception;

    int selectBillingListTotCnt(BillingVO vo) throws Exception;

    BillingVO selectBillingDetail(Long id) throws Exception;

    void saveBilling(BillingVO vo) throws Exception;

    void deleteBilling(BillingVO vo) throws Exception;
    
    void updateBilling(BillingVO vo) throws Exception;

    List<BillingVO> selectBillingListByProject(BillingVO searchVO) throws Exception;

    BillingVO selectProjectBillingSummary(Long projId) throws Exception;

    void updateAutoProjectStatus(Long projId) throws Exception;
    
    void updateActualPayDt(BillingVO vo) throws Exception;
}