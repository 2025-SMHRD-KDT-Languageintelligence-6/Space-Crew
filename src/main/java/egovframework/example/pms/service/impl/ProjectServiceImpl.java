package egovframework.example.pms.service.impl;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.example.pms.domain.Contract;
import egovframework.example.pms.domain.Project;
import egovframework.example.pms.domain.User;
import egovframework.example.pms.dto.ProjectDTO;
import egovframework.example.pms.repository.ContractRepository;
import egovframework.example.pms.repository.ProjectRepository;
import egovframework.example.pms.repository.UserRepository;
import egovframework.example.pms.service.ProjectService;

@Service
@RequiredArgsConstructor
@Transactional
public class ProjectServiceImpl implements ProjectService {

    private final ProjectRepository projectRepository;
    private final ContractRepository contractRepository;
    private final UserRepository userRepository;

    @Override
    @Transactional(readOnly = true)
    public Page<ProjectDTO> getProjectList(String keyword, int page) {
        Pageable pageable = PageRequest.of(page, 10, Sort.by("projId").descending());
        Page<Project> entities;

        if (keyword != null && !keyword.isEmpty()) {
            entities = projectRepository.findByProjNmContaining(keyword, pageable);
        } else {
            entities = projectRepository.findAll(pageable);
        }

        return entities.map(entity -> {
            ProjectDTO dto = new ProjectDTO();
            dto.setProjId(entity.getProjId());
            dto.setProjNm(entity.getProjNm());
            dto.setProjType(entity.getProjType());
            dto.setStatus(entity.getStatus());
            dto.setStartDt(entity.getStartDt());
            dto.setEndDt(entity.getEndDt());
            dto.setProgressRate(entity.getProgressRate());
            dto.setComplexityScore(entity.getComplexityScore());

            if (entity.getContract() != null) {
                dto.setContractName(entity.getContract().getContNm());
            }
            if (entity.getMainManager() != null) {
                dto.setMainManagerName(entity.getMainManager().getUserNm());
            }
            if (entity.getSubManager() != null) {
                dto.setSubManagerName(entity.getSubManager().getUserNm());
            }
            return dto;
        });
    }

    @Override
    public void saveProject(ProjectDTO dto) {
        Project project = new Project();
        
        if (dto.getProjId() != null) {
            project = projectRepository.findById(dto.getProjId())
                    .orElseThrow(() -> new IllegalArgumentException("Invalid Project ID"));
        }

        project.setProjNm(dto.getProjNm());
        project.setProjType(dto.getProjType());
        project.setStatus(dto.getStatus());
        project.setStartDt(dto.getStartDt());
        project.setEndDt(dto.getEndDt());
        project.setProgressRate(dto.getProgressRate());
        project.setComplexityScore(dto.getComplexityScore());

        if (dto.getContractId() != null) {
            Contract contract = contractRepository.findById(dto.getContractId())
                    .orElseThrow(() -> new IllegalArgumentException("Invalid Contract ID"));
            project.setContract(contract);
        }

        if (dto.getMainManagerId() != null && !dto.getMainManagerId().isEmpty()) {
            User mainUser = userRepository.findById(dto.getMainManagerId())
                    .orElseThrow(() -> new IllegalArgumentException("Invalid Main User ID"));
            project.setMainManager(mainUser);
        }

        if (dto.getSubManagerId() != null && !dto.getSubManagerId().isEmpty()) {
            User subUser = userRepository.findById(dto.getSubManagerId())
                    .orElseThrow(() -> new IllegalArgumentException("Invalid Sub User ID"));
            project.setSubManager(subUser);
        }

        projectRepository.save(project);
    }

    @Override
    @Transactional(readOnly = true)
    public ProjectDTO getProjectById(Long id) {
        Project entity = projectRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Invalid Project ID"));
        
        ProjectDTO dto = new ProjectDTO();
        dto.setProjId(entity.getProjId());
        dto.setProjNm(entity.getProjNm());
        dto.setProjType(entity.getProjType());
        dto.setStatus(entity.getStatus());
        dto.setStartDt(entity.getStartDt());
        dto.setEndDt(entity.getEndDt());
        dto.setProgressRate(entity.getProgressRate());
        dto.setComplexityScore(entity.getComplexityScore());

        if (entity.getContract() != null) {
            dto.setContractId(entity.getContract().getContId());
            dto.setContractName(entity.getContract().getContNm());
        }
        if (entity.getMainManager() != null) {
            dto.setMainManagerId(entity.getMainManager().getUserId());
            dto.setMainManagerName(entity.getMainManager().getUserNm());
        }
        if (entity.getSubManager() != null) {
            dto.setSubManagerId(entity.getSubManager().getUserId());
            dto.setSubManagerName(entity.getSubManager().getUserNm());
        }

        return dto;
    }

    @Override
    public void deleteProject(Long id) {
        projectRepository.deleteById(id);
    }
}