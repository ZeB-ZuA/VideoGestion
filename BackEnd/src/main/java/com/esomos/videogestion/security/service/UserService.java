package com.esomos.videogestion.security.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;
import com.esomos.videogestion.security.entity.User;
import com.esomos.videogestion.security.repository.UserRepository;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    public Optional<User> findByName(String name) {
        return userRepository.findByName(name);
    }

    public Optional<User> findByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    public Optional<User> findByCedula(long cedula) {
        return userRepository.findByCedula(cedula);
    }

    public Optional<User> findById(Integer id) {
        return userRepository.findById(id);
    }

    public List<User> findAll() {
        return userRepository.findAll();
    }
    
    public Boolean existsByCedula(long cedula) {
        return userRepository.existsByCedula(cedula);
    }

    public Boolean existsByEmail(String email) {
        return userRepository.existsByEmail(email);
    }

    @Transactional
    public User save(User user) {
        return userRepository.save(user);
    }

    @Transactional
    public void deleteById(Integer id) {
        userRepository.deleteById(id);
    }

    @Transactional
    public void deleteByCedula(long cedula) {
        userRepository.deleteByCedula(cedula);
    }

    @Transactional
    public void deleteByEmail(String email) {
        userRepository.deleteByEmail(email);
    }

    @Transactional
    public boolean update(User user) {
        if (user.getIdUser() == 0 || !userRepository.existsById(user.getIdUser())) {
            return false;
        }
        userRepository.save(user);
        return true;
    }
}