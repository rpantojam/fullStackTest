package com.example.demo.security;

import com.example.demo.service.UserService;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {

    private final UserService userService;

    public UserDetailsServiceImpl(UserService userService) {
        this.userService = userService;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        String encodedPassword = userService.getPasswordByUsername(username);
        if (encodedPassword == null) {
            throw new UsernameNotFoundException("Usuario no encontrado: " + username);
        }
        return User.builder()
                .username(username)
                .password(encodedPassword)
                .roles("ADMIN")
                .build();
    }
}
