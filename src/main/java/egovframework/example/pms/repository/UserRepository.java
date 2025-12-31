package egovframework.example.pms.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import egovframework.example.pms.domain.User;

public interface UserRepository extends JpaRepository<User, String> {
    Page<User> findByUserNmContaining(String keyword, Pageable pageable);
}