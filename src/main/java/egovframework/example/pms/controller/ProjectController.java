package egovframework.example.pms.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import egovframework.example.pms.dto.ProjectDTO;
import egovframework.example.pms.repository.ContractRepository;
import egovframework.example.pms.repository.UserRepository;
import egovframework.example.pms.service.ProjectService;

@Controller
@RequiredArgsConstructor
public class ProjectController {

    private final ProjectService projectService;
    private final UserRepository userRepository;
    private final ContractRepository contractRepository;

    @GetMapping("/projects")
    public String list(Model model, 
                       @RequestParam(value = "page", defaultValue = "0") int page,
                       @RequestParam(value = "keyword", required = false) String keyword) {
        
        Page<ProjectDTO> projectPage = projectService.getProjectList(keyword, page);
        
        model.addAttribute("projects", projectPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", projectPage.getTotalPages());
        model.addAttribute("keyword", keyword);
        
        return "pms/projectList";
    }
    
    @GetMapping("/projects/new")
    public String createForm(Model model) {
        model.addAttribute("project", new ProjectDTO());
        model.addAttribute("userList", userRepository.findAll());
        model.addAttribute("contractList", contractRepository.findAll());
        return "pms/createProjectForm";
    }

    @PostMapping("/projects/new")
    public String create(ProjectDTO projectDTO) {
        projectService.saveProject(projectDTO);
        return "redirect:/projects";
    }
    
    @GetMapping("/projects/edit/{id}")
    public String editForm(@PathVariable("id") Long id, Model model) {
        ProjectDTO dto = projectService.getProjectById(id);
        model.addAttribute("project", dto);
        model.addAttribute("userList", userRepository.findAll());
        model.addAttribute("contractList", contractRepository.findAll());
        return "pms/editProjectForm";
    }

    @PostMapping("/projects/edit/{id}")
    public String update(@PathVariable("id") Long id, ProjectDTO projectDTO) {
        projectDTO.setProjId(id);
        projectService.saveProject(projectDTO);
        return "redirect:/projects";
    }
    
    @GetMapping("/projects/delete/{id}")
    public String delete(@PathVariable("id") Long id) {
        projectService.deleteProject(id);
        return "redirect:/projects";
    }
}