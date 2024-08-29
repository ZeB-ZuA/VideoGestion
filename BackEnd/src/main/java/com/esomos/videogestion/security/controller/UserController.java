package com.esomos.videogestion.security.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/home/user")
@RequiredArgsConstructor
@PreAuthorize("hasAnyAuthority('ADMIN', 'USER')")
public class UserController {

    
    @GetMapping
    public ResponseEntity<String> getUser(){
        try {
            // Aquí puedes agregar cualquier lógica adicional si es necesario
            return ResponseEntity.ok("HI USER");
        } catch (AccessDeniedException e) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body("You do not have permission to access this resource" + e.getMessage());
        }
      
    }
    
}
