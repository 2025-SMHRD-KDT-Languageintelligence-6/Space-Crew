package egovframework.example.pms.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import egovframework.example.pms.domain.Billing;

public interface BillingRepository extends JpaRepository<Billing, Long> {
    
    Page<Billing> findByBillTitleContaining(String keyword, Pageable pageable);

    Page<Billing> findByIsPaid(String isPaid, Pageable pageable);
    
    // List<Billing> findByProjectProjId(Long projId);
}