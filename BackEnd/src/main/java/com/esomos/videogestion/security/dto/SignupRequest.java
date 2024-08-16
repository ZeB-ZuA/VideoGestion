package com.esomos.videogestion.security.dto;

import java.util.HashSet;
import java.util.Set;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class SignupRequest {

    @NotNull
    private long cedula;

    @NotBlank
    private String name;

    @NotBlank
    private String area;

    @NotBlank
    @Email
    private String email;

    @NotBlank
    private String password;

    @NotBlank
    private String headquarter;

    private Set<String> roles = new HashSet<>();

    @Override
    public String toString() {
        return "SignupRequest{" +
                "area='" + area + '\'' +
                ", email='" + email + '\'' +
                ", password='" + password + '\'' +
                ", headquarter='" + headquarter + '\'' +
                ", roles=" + roles +
                '}';
    }

}
