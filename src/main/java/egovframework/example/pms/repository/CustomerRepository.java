package egovframework.example.pms.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import egovframework.example.pms.domain.Customer;


public interface CustomerRepository extends JpaRepository<Customer, Long>{
	Page<Customer> findByCustNmContaining(String keyword, Pageable pageable);
}
