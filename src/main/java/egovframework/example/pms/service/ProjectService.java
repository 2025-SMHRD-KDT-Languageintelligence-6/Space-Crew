package egovframework.example.pms.service;

import org.springframework.data.domain.Page;
import egovframework.example.pms.dto.ProjectDTO;

public interface ProjectService {
    Page<ProjectDTO> getProjectList(String keyword, int page);
    ProjectDTO getProjectById(Long id);
    void saveProject(ProjectDTO dto);
    void deleteProject(Long id);
}