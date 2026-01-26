package egovframework.com.pms.service.impl;

import java.util.List;
import java.util.Map;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;
import egovframework.com.pms.service.BillingVO;

@Mapper("billingMapper")
public interface BillingMapper {
    List<BillingVO> selectBillingList(BillingVO vo) throws Exception;
    int selectBillingListTotCnt(BillingVO vo);
    BillingVO selectBillingDetail(Long id) throws Exception;
    void insertBilling(BillingVO vo) throws Exception;
    void updateBilling(BillingVO vo) throws Exception;
    void deleteBilling(BillingVO vo) throws Exception;
	BillingVO selectProjectBillingSummary(Long projId);
	List<BillingVO> selectBillingListByProject(BillingVO searchVO);
	Map<String, Object> selectProjectSettlementStatus(Long projId);
	void updateActualPayDt(BillingVO vo);
	void updateBillingAtchFileId(Map<String, Object> map);
}