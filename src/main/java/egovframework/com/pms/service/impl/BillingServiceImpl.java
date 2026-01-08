package egovframework.com.pms.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;
import egovframework.com.pms.service.BillingService;
import egovframework.com.pms.service.BillingVO;

@Service("billingService")
public class BillingServiceImpl extends EgovAbstractServiceImpl implements BillingService {

    @Resource(name="billingMapper")
    private BillingMapper billingMapper;

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
        if (vo.getBillId() == null || vo.getBillId() == 0) {
            billingMapper.insertBilling(vo);
        } else {
            billingMapper.updateBilling(vo);
        }
    }

    @Override
    public BillingVO selectBillingDetail(Long id) throws Exception {
        return billingMapper.selectBillingDetail(id);
    }

    @Override
    public void deleteBilling(Long id) throws Exception {
        billingMapper.deleteBilling(id);
    }
}