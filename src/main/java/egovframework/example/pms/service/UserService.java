package egovframework.example.pms.service;

import org.springframework.data.domain.Page;
import egovframework.example.pms.dto.UserDTO;

public interface UserService {
    Page<UserDTO> getUserList(String keyword, int page);
    UserDTO getUserById(String id);
    void saveUser(UserDTO dto);
    void deleteUser(String id);
}