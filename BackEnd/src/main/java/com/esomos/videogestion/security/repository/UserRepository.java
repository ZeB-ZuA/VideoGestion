package com.esomos.videogestion.security.repository;

import com.esomos.videogestion.security.entity.User;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User, Integer> {
    Optional<User> findByCedula(long cedula);

    Optional<User> findByName(String name);

    Optional<User> findByEmail(String email);

    Boolean existsByCedula(long cedula);

    Boolean existsByEmail(String email);

    void deleteByCedula(long cedula);

    void deleteByEmail(String email);



}
