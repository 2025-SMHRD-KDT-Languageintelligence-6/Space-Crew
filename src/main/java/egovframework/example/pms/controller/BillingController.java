package egovframework.example.pms.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import egovframework.example.pms.dto.BillingDTO;
import egovframework.example.pms.repository.ProjectRepository; // 드롭다운용 (간소화를 위해 유지)
import egovframework.example.pms.service.BillingService;

@Controller
@RequiredArgsConstructor
public class BillingController {

    private final BillingService billingService;
    private final ProjectRepository projectRepository;

    @GetMapping("/billing")
    public String list(Model model,
                       @RequestParam(value = "page", defaultValue = "0") int page,
                       @RequestParam(value = "keyword", required = false) String keyword) {
        
        Page<BillingDTO> billingPage = billingService.getBillingList(keyword, page);

        model.addAttribute("billings", billingPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", billingPage.getTotalPages());
        model.addAttribute("keyword", keyword);

        return "pms/billingList";
    }

    @GetMapping("/billing/new")
    public String createForm(Model model) {
        model.addAttribute("billing", new BillingDTO());
        model.addAttribute("projects", projectRepository.findAll());
        return "pms/createBillingForm";
    }

    @PostMapping("/billing/new")
    public String create(BillingDTO billingDTO) {
        billingService.saveBilling(billingDTO);
        return "redirect:/billing";
    }

    @GetMapping("/billing/edit/{id}")
    public String editForm(@PathVariable("id") Long id, Model model) {
        BillingDTO dto = billingService.getBillingById(id);
        model.addAttribute("billing", dto);
        model.addAttribute("projects", projectRepository.findAll());
        return "pms/editBillingForm";
    }

    @PostMapping("/billing/edit/{id}")
    public String update(@PathVariable("id") Long id, BillingDTO billingDTO) {
        billingDTO.setBillId(id);
        billingService.saveBilling(billingDTO);
        return "redirect:/billing";
    }

    @GetMapping("/billing/delete/{id}")
    public String delete(@PathVariable("id") Long id) {
        billingService.deleteBilling(id);
        return "redirect:/billing";
    }
}