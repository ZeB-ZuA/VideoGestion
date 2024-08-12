package com.esomos.videogestion.entity;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import jakarta.persistence.*;
import jakarta.persistence.Id;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "users")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor

public class User implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id_User;

    @NotNull
    private long cedula;

    @NotNull
    private String name;

    @NotNull
    private String area;

    @NotNull
    @Column(unique = true)
    private String email;

    @NotNull
    private String password;

    @NotNull
    private String headquarter;

    @jakarta.validation.constraints.NotNull
    @ManyToMany(fetch = FetchType.EAGER)
    @JoinTable(name = "users_roles", joinColumns = @JoinColumn(name = "id_User"), inverseJoinColumns = @JoinColumn(name = "id_Role"))
    private Set<Role> roles = new HashSet<>();

    private User(@NotNull long cedula, @NotNull String name, @NotNull String area, @NotNull String email,
            @NotNull String password, @NotNull String headquarter) {
        this.cedula = cedula;
        this.name = name;
        this.area = area;
        this.email = email;
        this.password = password;
        this.headquarter = headquarter;
    }

}
