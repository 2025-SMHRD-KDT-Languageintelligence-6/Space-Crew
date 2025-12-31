package egovframework.example.pms.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import egovframework.example.pms.domain.Sales;

public interface SalesRepository extends JpaRepository<Sales, Long> {
    Page<Sales> findBySalesTitleContaining(String keyword, Pageable pageable);
}