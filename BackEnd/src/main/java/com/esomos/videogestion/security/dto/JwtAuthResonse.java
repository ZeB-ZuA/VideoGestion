package com.esomos.videogestion.security.dto;

import lombok.Data;

@Data

public class JwtAuthResonse {
    private String token;
    private String RefreshToken;
}
