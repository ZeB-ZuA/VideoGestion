package com.esomos.videogestion.security.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.esomos.videogestion.security.entity.Role;
import com.esomos.videogestion.security.enums.RoleName;
import com.esomos.videogestion.security.repository.RoleRepository;

@Service
@Transactional

public class RoleService {

    @Autowired
    RoleRepository roleRepository;

    public Optional<Role> findByRoleName(RoleName roleName){
        return roleRepository.findByRole(roleName);
    }
}
