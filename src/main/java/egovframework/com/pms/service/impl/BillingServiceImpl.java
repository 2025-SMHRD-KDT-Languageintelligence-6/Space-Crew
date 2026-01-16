package egovframework.com.pms.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;
import egovframework.com.pms.service.BillingService;
import egovframework.com.pms.service.BillingVO;

@Service("billingService")
public class BillingServiceImpl extends EgovAbstractServiceImpl implements BillingService {

    @Resource(name="billingMapper")
    private BillingMapper billingMapper;
    
    @Resource(name="projectMapper")
    private ProjectMapper projectMapper;
    
    @Override
    public List<BillingVO> selectBillingList(BillingVO vo) throws Exception {
        return billingMapper.selectBillingList(vo);
    }

    @Override
    public int selectBillingListTotCnt(BillingVO vo) throws Exception {
        return billingMapper.selectBillingListTotCnt(vo);
    }

    @Override
    public void saveBilling(BillingVO vo) throws Exception {
    	BillingVO summary = billingMapper.selectProjectBillingSummary(vo.getProjId());
        long totalAmt = summary.getTotalAmt();
        long alreadyBilled = summary.getTotalBilledAmt();
        
        if (vo.getBillId() != null && vo.getBillId() != 0) {
            BillingVO origin = billingMapper.selectBillingDetail(vo.getBillId());
            alreadyBilled -= origin.getBillAmt();
        }
        
        if (totalAmt < (alreadyBilled + vo.getBillAmt())) {
            throw new Exception("계약 금액을 초과하여 청구할 수 없습니다."); 
        }

        if (vo.getBillId() == null || vo.getBillId() == 0) {
            billingMapper.insertBilling(vo);
        } else {
            billingMapper.updateBilling(vo);
        }
        this.updateAutoProjectStatus(vo.getProjId());
    }

    @Override
    public BillingVO selectBillingDetail(Long id) throws Exception {
        return billingMapper.selectBillingDetail(id);
    }

    @Override
    public void deleteBilling(BillingVO vo) throws Exception {
        billingMapper.deleteBilling(vo);
        
        this.updateAutoProjectStatus(vo.getProjId());
    }
    
    @Override
    public void updateBilling(BillingVO vo) throws Exception {
        billingMapper.updateBilling(vo);
    }
    
    @Override
    public BillingVO selectProjectBillingSummary(Long projId) throws Exception {
        return billingMapper.selectProjectBillingSummary(projId);
    }

    @Override
    public List<BillingVO> selectBillingListByProject(BillingVO searchVO) throws Exception {
        return billingMapper.selectBillingListByProject(searchVO);
    }
    
    @Override
    public void updateAutoProjectStatus(Long projId) throws Exception {
        Map<String, Object> status = billingMapper.selectProjectSettlementStatus(projId);
        
        if (status == null || status.get("totalContAmt") == null) return;

        long totalCount = Long.parseLong(String.valueOf(status.get("totalCount")));
        long paidCount = Long.parseLong(String.valueOf(status.get("paidCount")));
        long totalContAmt = Long.parseLong(String.valueOf(status.get("totalContAmt")));
        long totalBilledAmt = Long.parseLong(String.valueOf(status.get("totalBilledAmt")));

        String finalStatus = "청구진행중";

        if (totalContAmt > 0 && totalContAmt == totalBilledAmt) {
            if (totalCount == paidCount && totalCount > 0) {
                finalStatus = "정산완료";
            } else {
                finalStatus = "입금대기";
            }
        }

        projectMapper.updateProjectStatus(projId, finalStatus);
    }
    
    @Override
    public void updateActualPayDt(BillingVO vo) throws Exception {
        billingMapper.updateActualPayDt(vo);
        
        this.updateAutoProjectStatus(vo.getProjId());
    }
}