package com.example.demo.service.impl;

import com.example.demo.dto.UserDTO;
import com.example.demo.entity.Users;
import com.example.demo.exception.ResourceNotCreatedException;
import com.example.demo.exception.ResourceNotFoundException;
import com.example.demo.repository.UserRepository;
import com.example.demo.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Slf4j
@Service
public class UserServiceImpl implements UserService {

    private final UserRepository repository;
    private final PasswordEncoder pwdEncoder;

    public UserServiceImpl(UserRepository repository, PasswordEncoder pwdEncoder) {
        this.repository = repository;
        this.pwdEncoder = pwdEncoder;
    }

    @Override
    public UserDTO createUser(UserDTO userDTO) {
        var user = Users.builder()
                .username(userDTO.getUsername())
                .password(pwdEncoder.encode(userDTO.getPassword()))
                .build();

        try {
            var created = repository.save(user);
            return UserDTO.builder()
                    .id(created.getId())
                    .username(created.getUsername())
                    .build();
        } catch (Exception ex) {
            log.error(ex.getMessage());
            throw new ResourceNotCreatedException("User saving failed...");
        }
    }

    @Override
    public String getPasswordByUsername(String username) {
        var user = repository.findByUsername(username);
        if (user != null) {
            return user.getPassword();
        } else {
            throw new ResourceNotFoundException("User not found");
        }
    }

    @Override
    public Users findByUserName(String username) {
        return repository.findByUsername(username);
    }

}
