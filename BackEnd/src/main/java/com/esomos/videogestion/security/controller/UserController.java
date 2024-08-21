package com.esomos.videogestion.security.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/USER")
@RequiredArgsConstructor
@PreAuthorize("hasAnyAuthority('ADMIN', 'USER')")
public class UserController {

    
    
}
