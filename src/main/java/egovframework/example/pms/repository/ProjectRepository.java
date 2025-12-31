package egovframework.example.pms.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import egovframework.example.pms.domain.Project;

public interface ProjectRepository extends JpaRepository<Project, Long> {
    Page<Project> findByProjNmContaining(String keyword, Pageable pageable);
}