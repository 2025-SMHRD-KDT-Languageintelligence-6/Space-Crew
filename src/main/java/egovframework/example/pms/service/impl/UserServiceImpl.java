package egovframework.example.pms.service.impl;

import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.example.pms.domain.User;
import egovframework.example.pms.dto.UserDTO;
import egovframework.example.pms.repository.UserRepository;
import egovframework.example.pms.service.UserService;

@Service
@RequiredArgsConstructor
@Transactional
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;

    @Override
    @Transactional(readOnly = true)
    public Page<UserDTO> getUserList(String keyword, int page) {
        Pageable pageable = PageRequest.of(page, 10, Sort.by("userId").ascending());
        Page<User> entities;

        if (keyword != null && !keyword.isEmpty()) {
            entities = userRepository.findByUserNmContaining(keyword, pageable);
        } else {
            entities = userRepository.findAll(pageable);
        }

        return entities.map(entity -> {
            UserDTO dto = new UserDTO();
            dto.setUserId(entity.getUserId());
            dto.setUserNm(entity.getUserNm());
            dto.setDeptNm(entity.getDeptNm());
            dto.setJobRole(entity.getJobRole());
            dto.setPositionNm(entity.getPositionNm());
            dto.setUseYn(entity.getUseYn());
            dto.setCareerYears(entity.getCareerYears());
            dto.setJobField(entity.getJobField());
            dto.setCurrentLoad(entity.getCurrentLoad());
            dto.setJoinDt(entity.getJoinDt());
            dto.setAuthLevel(entity.getAuthLevel());
            return dto;
        });
    }

    @Override
    public void saveUser(UserDTO dto) {
        User user = new User();
        
        if (dto.getUserId() != null) {
             user = userRepository.findById(dto.getUserId()).orElse(new User());
             user.setUserId(dto.getUserId());
        }

        user.setUserNm(dto.getUserNm());
        user.setUserPwd(dto.getUserPwd());
        user.setDeptNm(dto.getDeptNm());
        user.setJobRole(dto.getJobRole());
        user.setPositionNm(dto.getPositionNm());
        user.setCareerYears(dto.getCareerYears());
        user.setJobField(dto.getJobField());
        user.setCurrentLoad(dto.getCurrentLoad());
        user.setJoinDt(dto.getJoinDt());
        user.setAuthLevel(dto.getAuthLevel());
        user.setUseYn(dto.getUseYn());

        userRepository.save(user);
    }

    @Override
    @Transactional(readOnly = true)
    public UserDTO getUserById(String id) {
        User entity = userRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Invalid user Id: " + id));
        
        UserDTO dto = new UserDTO();
        dto.setUserId(entity.getUserId());
        dto.setUserNm(entity.getUserNm());
        dto.setUserPwd(entity.getUserPwd());
        dto.setDeptNm(entity.getDeptNm());
        dto.setJobRole(entity.getJobRole());
        dto.setPositionNm(entity.getPositionNm());
        dto.setCareerYears(entity.getCareerYears());
        dto.setJobField(entity.getJobField());
        dto.setCurrentLoad(entity.getCurrentLoad());
        dto.setJoinDt(entity.getJoinDt());
        dto.setAuthLevel(entity.getAuthLevel());
        dto.setUseYn(entity.getUseYn());
        
        return dto;
    }

    @Override
    public void deleteUser(String id) {
        userRepository.deleteById(id);
    }
}