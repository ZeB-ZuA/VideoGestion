package com.esomos.videogestion.security.dto;

import lombok.Data;


@Data
public class LogInRequest {

    private String email;

    private String password;
    
}
