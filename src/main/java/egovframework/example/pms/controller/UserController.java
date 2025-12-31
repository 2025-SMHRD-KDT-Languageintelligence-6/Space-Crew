package egovframework.example.pms.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import egovframework.example.pms.dto.UserDTO;
import egovframework.example.pms.service.UserService;

@Controller
@RequiredArgsConstructor
public class UserController {
    
    private final UserService userService;

    @GetMapping("/users")
    public String list(Model model, 
                       @RequestParam(value = "page", defaultValue = "0") int page,
                       @RequestParam(value = "keyword", required = false) String keyword) {
        
        Page<UserDTO> userPage = userService.getUserList(keyword, page);
        
        model.addAttribute("users", userPage.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", userPage.getTotalPages());
        model.addAttribute("keyword", keyword);
        
        return "pms/userList";
    }

    @GetMapping("/users/new")
    public String createForm(Model model) {
        model.addAttribute("user", new UserDTO());
        return "pms/createUserForm";
    }

    @PostMapping("/users/new")
    public String create(UserDTO userDTO) {
        userService.saveUser(userDTO);
        return "redirect:/users";
    }
    
    @GetMapping("/users/edit/{id}")
    public String editForm(@PathVariable("id") String id, Model model) {
        UserDTO dto = userService.getUserById(id);
        model.addAttribute("user", dto);
        return "pms/editUserForm";
    }

    @PostMapping("/users/edit/{id}")
    public String update(@PathVariable("id") String id, UserDTO userDTO) {
        userDTO.setUserId(id); 
        userService.saveUser(userDTO);
        return "redirect:/users";
    }

    @GetMapping("/users/delete/{id}")
    public String delete(@PathVariable("id") String id) {
        userService.deleteUser(id);
        return "redirect:/users";
    }
}