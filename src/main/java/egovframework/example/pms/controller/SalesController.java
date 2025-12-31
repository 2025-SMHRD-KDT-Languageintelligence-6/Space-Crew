package egovframework.example.pms.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import egovframework.example.pms.dto.SalesDTO;
import egovframework.example.pms.repository.CustomerRepository;
import egovframework.example.pms.repository.UserRepository;
import egovframework.example.pms.service.SalesService;

@Controller
@RequiredArgsConstructor
public class SalesController {

    private final SalesService salesService;
    private final CustomerRepository customerRepository;
    private final UserRepository userRepository;

    @GetMapping("/sales")
    public String list(Model model,
                       @RequestParam(value = "page", defaultValue = "0") int page,
                       @RequestParam(value = "keyword", required = false) String keyword) {
        
        Page<SalesDTO> salesPage = salesService.getSalesList(keyword, page);

        model.addAttribute("sales", salesPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", salesPage.getTotalPages());
        model.addAttribute("keyword", keyword);

        return "pms/salesList";
    }

    @GetMapping("/sales/new")
    public String createForm(Model model) {
        model.addAttribute("sales", new SalesDTO());
        model.addAttribute("customers", customerRepository.findAll());
        model.addAttribute("users", userRepository.findAll());
        return "pms/createSalesForm";
    }

    @PostMapping("/sales/new")
    public String create(SalesDTO salesDTO) {
        salesService.saveSales(salesDTO);
        return "redirect:/sales";
    }

    @GetMapping("/sales/edit/{id}")
    public String editForm(@PathVariable("id") Long id, Model model) {
        SalesDTO dto = salesService.getSalesById(id);
        model.addAttribute("sales", dto);
        model.addAttribute("customers", customerRepository.findAll());
        model.addAttribute("users", userRepository.findAll());
        return "pms/editSalesForm";
    }

    @PostMapping("/sales/edit/{id}")
    public String update(@PathVariable("id") Long id, SalesDTO salesDTO) {
        salesDTO.setSalesId(id);
        salesService.saveSales(salesDTO);
        return "redirect:/sales";
    }

    @GetMapping("/sales/delete/{id}")
    public String delete(@PathVariable("id") Long id) {
        salesService.deleteSales(id);
        return "redirect:/sales";
    }
}