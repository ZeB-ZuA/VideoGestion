package com.esomos.videogestion.security.entity;

import com.esomos.videogestion.security.enums.RoleName;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.io.Serializable;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;

@Entity
@Table(name = "roles")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor

public class Role implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id_Role;
    @NotNull
    @Enumerated(EnumType.STRING)
    private RoleName role;

    public Role(@NotNull RoleName role) {
        this.role = role;
    }

}
