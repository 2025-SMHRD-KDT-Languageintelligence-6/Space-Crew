package egovframework.com.pms.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.com.pms.service.SalesVO;
import egovframework.com.pms.service.SalesService;

@Service("salesService")
public class SalesServiceImpl extends EgovAbstractServiceImpl implements SalesService {

    @Resource(name="salesMapper")
    private SalesMapper salesMapper;

    @Override
    public List<SalesVO> selectSalesList(SalesVO vo) throws Exception {
        return salesMapper.selectSalesList(vo);
    }

    @Override
    public int selectSalesListTotCnt(SalesVO vo) throws Exception {
        return salesMapper.selectSalesListTotCnt(vo);
    }

    /**
     * 알림용: 1분 이내 신규 영업 건수 조회 (추가됨)
     */
    @Override
    public int selectNewSalesCount() throws Exception {
        return salesMapper.selectNewSalesCount();
    }

    @Override
    public void saveSales(SalesVO vo) throws Exception {
        // ID가 없으면 등록, 있으면 수정하는 로직은 아주 좋습니다.
        if (vo.getSalesId() == null || vo.getSalesId() == 0) {
            salesMapper.insertSales(vo);
        } else {
            salesMapper.updateSales(vo);
        }
    }

    @Override
    public SalesVO selectSalesDetail(Long id) throws Exception {
        return salesMapper.selectSalesDetail(id);
    }

    @Override
    public void deleteSales(SalesVO vo) throws Exception {
        salesMapper.deleteSales(vo);
    }

    @Override
    public void updateSales(SalesVO vo) throws Exception {
        salesMapper.updateSales(vo);
    }

    @Override
    public void updateSalesStatus(Map<String, Object> param) throws Exception {
        salesMapper.updateSalesStatus(param);
    }
}