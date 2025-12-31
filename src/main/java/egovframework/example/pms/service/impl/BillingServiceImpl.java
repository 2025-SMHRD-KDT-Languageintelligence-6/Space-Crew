package egovframework.example.pms.service.impl;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.example.pms.domain.Billing;
import egovframework.example.pms.domain.Project;
import egovframework.example.pms.dto.BillingDTO;
import egovframework.example.pms.repository.BillingRepository;
import egovframework.example.pms.repository.ProjectRepository;
import egovframework.example.pms.service.BillingService;

@Service
@RequiredArgsConstructor
@Transactional
public class BillingServiceImpl implements BillingService {

    private final BillingRepository billingRepository;
    private final ProjectRepository projectRepository;

    @Override
    @Transactional(readOnly = true)
    public Page<BillingDTO> getBillingList(String keyword, int page) {
        Pageable pageable = PageRequest.of(page, 10, Sort.by("billId").descending());
        Page<Billing> entities;

        if (keyword != null && !keyword.isEmpty()) {
            entities = billingRepository.findByBillTitleContaining(keyword, pageable);
        } else {
            entities = billingRepository.findAll(pageable);
        }

        return entities.map(entity -> {
            BillingDTO dto = new BillingDTO();
            dto.setBillId(entity.getBillId());
            dto.setBillTitle(entity.getBillTitle());
            dto.setBillAmt(entity.getBillAmt());
            dto.setTaxBillDt(entity.getTaxBillDt());
            dto.setIsPaid(entity.getIsPaid());
            if (entity.getProject() != null) {
                dto.setProjectName(entity.getProject().getProjNm());
            }
            return dto;
        });
    }

    @Override
    public void saveBilling(BillingDTO dto) {
        Billing billing = new Billing();
        
        if (dto.getBillId() != null) {
            billing = billingRepository.findById(dto.getBillId())
                    .orElseThrow(() -> new IllegalArgumentException("Invalid bill Id"));
        }

        billing.setBillTitle(dto.getBillTitle());
        billing.setBillAmt(dto.getBillAmt());
        billing.setTaxBillDt(dto.getTaxBillDt());
        billing.setPayDt(dto.getPayDt());
        billing.setActualPayDt(dto.getActualPayDt());
        billing.setBillRemark(dto.getBillRemark());
        
        billing.setIsPaid(dto.getIsPaid() == null ? "N" : dto.getIsPaid());

        if (dto.getProjectId() != null) {
            Project project = projectRepository.findById(dto.getProjectId())
                    .orElseThrow(() -> new IllegalArgumentException("Invalid Project Id"));
            billing.setProject(project);
        }

        billingRepository.save(billing);
    }

    @Override
    @Transactional(readOnly = true)
    public BillingDTO getBillingById(Long id) {
        Billing entity = billingRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Invalid bill Id"));
        
        BillingDTO dto = new BillingDTO();
        dto.setBillId(entity.getBillId());
        dto.setBillTitle(entity.getBillTitle());
        dto.setBillAmt(entity.getBillAmt());
        dto.setTaxBillDt(entity.getTaxBillDt());
        dto.setPayDt(entity.getPayDt());
        dto.setIsPaid(entity.getIsPaid());
        dto.setActualPayDt(entity.getActualPayDt());
        dto.setBillRemark(entity.getBillRemark());
        
        if (entity.getProject() != null) {
            dto.setProjectId(entity.getProject().getProjId()); // 수정 폼에서 선택되도록 ID 세팅
        }
        return dto;
    }

    @Override
    public void deleteBilling(Long id) {
        billingRepository.deleteById(id);
    }
}