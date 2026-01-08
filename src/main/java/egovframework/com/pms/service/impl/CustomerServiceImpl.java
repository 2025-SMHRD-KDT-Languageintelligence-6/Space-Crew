package egovframework.com.pms.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.com.pms.service.CustomerService;
import egovframework.com.pms.service.CustomerVO;

@Service("customerService")
public class CustomerServiceImpl extends EgovAbstractServiceImpl implements CustomerService {

    @Resource(name = "customerMapper")
    private CustomerMapper customerMapper;

    @Override
    public List<CustomerVO> selectCustomerList(CustomerVO vo) throws Exception {
        return customerMapper.selectCustomerList(vo);
    }

    @Override
    public int selectCustomerListTotCnt(CustomerVO vo) throws Exception {
        return customerMapper.selectCustomerListTotCnt(vo);
    }

    @Override
    public CustomerVO selectCustomerDetail(Integer id) throws Exception {
        return customerMapper.selectCustomerDetail(id);
    }

    @Override
    public void saveCustomer(CustomerVO vo) throws Exception {
        if (vo.getCustId() == null || vo.getCustId() == 0) {
            customerMapper.insertCustomer(vo);
        } else {
            customerMapper.updateCustomer(vo);
        }
    }

    @Override
    public void deleteCustomer(Integer id) throws Exception {
        customerMapper.deleteCustomer(id);
    }
}