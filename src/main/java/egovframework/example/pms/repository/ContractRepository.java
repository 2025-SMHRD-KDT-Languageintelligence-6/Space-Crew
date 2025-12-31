package egovframework.example.pms.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import egovframework.example.pms.domain.Contract;

public interface ContractRepository extends JpaRepository<Contract, Long> {
    
    Page<Contract> findByContNmContaining(String keyword, Pageable pageable);
}