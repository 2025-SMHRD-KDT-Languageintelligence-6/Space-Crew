package egovframework.example.pms.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import egovframework.example.pms.dto.CustomerDTO;
import egovframework.example.pms.service.CustomerService;

@Controller
@RequiredArgsConstructor
public class CustomerController {
    
    private final CustomerService customerService;
    
    @GetMapping("/customers")
    public String list(Model model,
                       @RequestParam(value = "page", defaultValue = "0") int page,
                       @RequestParam(value = "keyword", required = false) String keyword) {
        
        Page<CustomerDTO> customerPage = customerService.getCustomerList(keyword, page);
        
        model.addAttribute("customers", customerPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", customerPage.getTotalPages());
        model.addAttribute("keyword", keyword);
        
        return "pms/customerList";
    }
    
    @GetMapping("/customers/new")
    public String createForm(Model model) {
        model.addAttribute("customer", new CustomerDTO());
        return "pms/createCustomerForm";
    }

    @PostMapping("/customers/new")
    public String create(CustomerDTO customerDTO) {
        customerService.saveCustomer(customerDTO);
        return "redirect:/customers";
    }
    
    @GetMapping("/customers/edit/{id}")
    public String editForm(@PathVariable("id") Long id, Model model) {
        CustomerDTO dto = customerService.getCustomerById(id);
        model.addAttribute("customer", dto);
        return "pms/editCustomerForm";
    }

    @PostMapping("/customers/edit/{id}")
    public String update(@PathVariable("id") Long id, CustomerDTO customerDTO) {
        customerDTO.setCustId(id); 
        customerService.saveCustomer(customerDTO);
        return "redirect:/customers";
    }
    
    @GetMapping("/customers/delete/{id}")
    public String delete(@PathVariable("id") Long id) {
        customerService.deleteCustomer(id);
        return "redirect:/customers";
    }
}