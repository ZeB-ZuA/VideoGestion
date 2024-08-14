package com.esomos.videogestion.security.controller;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.validation.BindingResult;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.esomos.videogestion.dto.Message;
import com.esomos.videogestion.security.dto.SignupRequest;
import com.esomos.videogestion.security.service.RoleService;
import com.esomos.videogestion.security.service.UserService;

import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/auth")
@CrossOrigin("*")


public class AuthController {


@Autowired
PasswordEncoder passwordEncoder;

@Autowired
AuthenticationManager authenticatorManager;

@Autowired
UserService userService;

@Autowired
RoleService roleService;


@PostMapping("/signup")
public ResponseEntity<Message> registerUser(@Valid SignupRequest signupRequest, BindingResult bindingResult){


return new ResponseEntity<>(new Message("User registered successfully!"), HttpStatus.CREATED);
}








    
}
