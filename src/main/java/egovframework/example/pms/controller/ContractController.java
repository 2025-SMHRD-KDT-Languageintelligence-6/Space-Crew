package egovframework.example.pms.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import egovframework.example.pms.dto.ContractDTO;
import egovframework.example.pms.repository.UserRepository;
import egovframework.example.pms.service.ContractService;

@Controller
@RequiredArgsConstructor
public class ContractController {

    private final ContractService contractService;
    private final UserRepository userRepository;

    @GetMapping("/contracts")
    public String list(Model model,
                       @RequestParam(value = "page", defaultValue = "0") int page,
                       @RequestParam(value = "keyword", required = false) String keyword) {
        
        Page<ContractDTO> contractPage = contractService.getContractList(keyword, page);

        model.addAttribute("contracts", contractPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", contractPage.getTotalPages());
        model.addAttribute("keyword", keyword);

        return "pms/contractList";
    }

    @GetMapping("/contracts/new")
    public String createForm(Model model) {
        model.addAttribute("contract", new ContractDTO());
        model.addAttribute("users", userRepository.findAll());
        return "pms/createContractForm";
    }

    @PostMapping("/contracts/new")
    public String create(ContractDTO contractDTO) {
        contractService.saveContract(contractDTO);
        return "redirect:/contracts";
    }
    
    @GetMapping("/contracts/edit/{id}")
    public String editForm(@PathVariable("id") Long id, Model model) {
        ContractDTO dto = contractService.getContractById(id);
        model.addAttribute("contract", dto);
        model.addAttribute("users", userRepository.findAll());
        return "pms/editContractForm";
    }
    
    @PostMapping("/contracts/edit/{id}")
    public String update(@PathVariable("id") Long id, ContractDTO contractDTO) {
        contractDTO.setContId(id); 
        contractService.saveContract(contractDTO);
        return "redirect:/contracts";
    }
    
    @GetMapping("/contracts/delete/{id}")
    public String delete(@PathVariable("id") Long id) {
        contractService.deleteContract(id);
        return "redirect:/contracts";
    }
}