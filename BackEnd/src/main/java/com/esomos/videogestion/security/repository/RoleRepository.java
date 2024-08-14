package com.esomos.videogestion.security.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.esomos.videogestion.security.entity.Role;
import com.esomos.videogestion.security.enums.RoleName;

public interface RoleRepository extends JpaRepository<Role, Integer> {

    Optional<Role> findByRole(RoleName roleName);
}
