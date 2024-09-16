package com.esomos.videogestion.security.controller;


import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.esomos.videogestion.dto.Message;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/home/admin")
@RequiredArgsConstructor
@PreAuthorize("hasAnyAuthority('ADMIN')")
public class AdminController {

    @GetMapping
    public ResponseEntity<?> getAdmin() {
        try {
            
            return new ResponseEntity<Message>(new Message("Hola admin de videos "), HttpStatus.OK);
        } catch (AccessDeniedException e) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).body("You do not have permission to access this resource" + e.getMessage());
        }
    }
}