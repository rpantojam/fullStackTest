package com.example.demo.service;

import com.example.demo.dto.UserDTO;
import com.example.demo.entity.Users;

public interface UserService {

    UserDTO createUser(UserDTO userDTO);

    String getPasswordByUsername(String username);

    Users findByUserName(String username);

}
