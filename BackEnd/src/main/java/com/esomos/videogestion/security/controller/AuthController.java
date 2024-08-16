package com.esomos.videogestion.security.controller;

import java.util.HashSet;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.esomos.videogestion.dto.Message;
import com.esomos.videogestion.security.dto.SignupRequest;
import com.esomos.videogestion.security.entity.User;
import com.esomos.videogestion.security.enums.RoleName;
import com.esomos.videogestion.security.service.RoleService;
import com.esomos.videogestion.security.service.UserService;
import com.esomos.videogestion.security.entity.Role;

import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/auth")
@CrossOrigin("*")

public class AuthController {


    @Autowired
    AuthenticationManager authenticatorManager;

    @Autowired
    UserService userService;

    @Autowired
    RoleService roleService;


    @PostMapping("/signup")
    public ResponseEntity<Message> registerUser(@Valid @RequestBody SignupRequest signupRequest, BindingResult bindingResult) {
        System.out.println("SignupRequest: " + signupRequest.toString());
   
        if (bindingResult.hasErrors()) {
            bindingResult.getAllErrors().forEach(error -> {
                log.error(error.getDefaultMessage());
            });
            return new ResponseEntity<>(new Message("Invalid data"), HttpStatus.BAD_REQUEST);
        }
        if (userService.existsByEmail(signupRequest.getEmail())) {
            return new ResponseEntity<>(new Message("Email already in use"), HttpStatus.BAD_REQUEST);
        }
        if (userService.existsByCedula(signupRequest.getCedula())) {
            return new ResponseEntity<>(new Message("Cedula already in use"), HttpStatus.BAD_REQUEST);
        }
    
        // Crear el usuario
        User user = new User(signupRequest.getCedula(), signupRequest.getName(), signupRequest.getArea(),
                signupRequest.getEmail(), signupRequest.getPassword(), signupRequest.getHeadquarter());
    
        // Obtener los roles de la solicitud
        Set<String> strRoles = signupRequest.getRoles();
        Set<Role> roles = new HashSet<>();
    
        if (strRoles == null || strRoles.isEmpty()) {
 
            Role userRole = roleService.findByRoleName(RoleName.USER)
                    .orElseThrow(() -> new RuntimeException("Error: Role is not found."));
            roles.add(userRole);
        } else {
   
            strRoles.forEach(role -> {
                if (role.equalsIgnoreCase("admin")) {
                    Role adminRole = roleService.findByRoleName(RoleName.ADMIN)
                            .orElseThrow(() -> new RuntimeException("Error: Role is not found."));
                    roles.add(adminRole);
                } else if (role.equalsIgnoreCase("user")) {
                    Role userRole = roleService.findByRoleName(RoleName.USER)
                            .orElseThrow(() -> new RuntimeException("Error: Role is not found."));
                    roles.add(userRole);
                } else {
                    throw new RuntimeException("Error: Role is not valid.");
                }
            });
        }
    
    
        user.setRoles(roles);
    
       
        userService.save(user);
    
        return new ResponseEntity<>(new Message("User registered successfully!"), HttpStatus.CREATED);
    }
    



}