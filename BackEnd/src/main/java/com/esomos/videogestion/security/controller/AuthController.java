package com.esomos.videogestion.security.controller;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.esomos.videogestion.dto.Message;
import com.esomos.videogestion.security.dto.JwtAuthResonse;
import com.esomos.videogestion.security.dto.LogInRequest;
import com.esomos.videogestion.security.dto.SignUpRequest;
import com.esomos.videogestion.security.dto.refreshTokenRequest;
import com.esomos.videogestion.security.entity.User;
import com.esomos.videogestion.security.enums.RoleName;
import com.esomos.videogestion.security.service.JwtService;
import com.esomos.videogestion.security.service.RoleService;
import com.esomos.videogestion.security.service.UserService;
import com.esomos.videogestion.security.entity.Role;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/auth")
@CrossOrigin("*")
@RequiredArgsConstructor
public class AuthController {
    private static final Logger logger = LoggerFactory.getLogger(AuthController.class);

    @Autowired
    AuthenticationManager authenticatorManager;

    @Autowired
    UserService userService;

    @Autowired
    RoleService roleService;

    private final JwtService jwtService;

    @PostMapping("/signup")
    public ResponseEntity<Message> registerUser(@Valid @RequestBody SignUpRequest signupRequest,
            BindingResult bindingResult) {
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

        User user = new User(signupRequest.getCedula(), signupRequest.getName(), signupRequest.getArea(),
                signupRequest.getEmail(), signupRequest.getPassword(), signupRequest.getHeadquarter());

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

    @PostMapping("/login")
    public ResponseEntity<?> loginUser(@Valid @RequestBody LogInRequest loginRequest,
            BindingResult bindingResult) {
        logger.info("Login attempt with email: {} and password: {}", loginRequest.getEmail(),
                loginRequest.getPassword());

        if (bindingResult.hasErrors()) {
            bindingResult.getAllErrors().forEach(error -> log.error(error.getDefaultMessage()));
            return new ResponseEntity<>(new Message("Invalid data"), HttpStatus.BAD_REQUEST);
        }

        try {
            
            logger.info("Attempting to authenticate user: {}", loginRequest.getEmail());
            
            authenticatorManager.authenticate(
                    new UsernamePasswordAuthenticationToken(loginRequest.getEmail(), loginRequest.getPassword()));

            UserDetails userDetails = userService.loadUserByUsername(loginRequest.getEmail());

            logger.info("User authenticated. Generating token...");
            String token = jwtService.generateToken(userDetails);
            String refresToken = jwtService.generateRefreshToken(new HashMap<>(), userDetails);

            JwtAuthResonse jwtAuthResonse = new JwtAuthResonse();
            jwtAuthResonse.setToken(token);
            jwtAuthResonse.setRefreshToken(refresToken);
            
            return new ResponseEntity<>(jwtAuthResonse, HttpStatus.OK);

        } catch (Exception e) {
            logger.error("Authentication failed for user: {}. Reason: {}", loginRequest.getEmail(), e.getMessage());
            return new ResponseEntity<>(new Message("Invalid credentials"), HttpStatus.UNAUTHORIZED);
        }
    }


    @PostMapping("/refresh")
    public ResponseEntity<?> refreshToken(BindingResult bindingResult, refreshTokenRequest refreshTokenRequest) {
        String userEmail = jwtService.extractUserName(refreshTokenRequest.getToken());
        UserDetails user = userService.loadUserByUsername(userEmail);
    
        try {
            if (jwtService.isTokenValid(refreshTokenRequest.getToken(), user)) {
                String jwt = jwtService.generateToken(user);
                JwtAuthResonse jwtAuthResonse = new JwtAuthResonse();
                jwtAuthResonse.setToken(jwt);
                jwtAuthResonse.setRefreshToken(refreshTokenRequest.getToken());
    
                return ResponseEntity.ok(jwtAuthResonse);
            } else {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(new Message("Invalid credentials"));
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(new Message("Error at refreshing token => "+ e.getMessage()));
        }
    }





    

    @GetMapping("/test")
    public ResponseEntity<String> testEndpoint() {
        return ResponseEntity.ok("Test endpoint is working");
    }

}