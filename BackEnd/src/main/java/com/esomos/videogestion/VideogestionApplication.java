package com.esomos.videogestion;

import java.util.HashSet;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import com.esomos.videogestion.security.entity.Role;
import com.esomos.videogestion.security.entity.User;
import com.esomos.videogestion.security.enums.RoleName;
import com.esomos.videogestion.security.repository.UserRepository;

@SpringBootApplication
public class VideogestionApplication implements CommandLineRunner{




	@Autowired
	private UserRepository userRepository;
	public static void main(String[] args) {
		SpringApplication.run(VideogestionApplication.class, args);
	}

	public void run(String... args){
User adminAccount = userRepository.findUserByRole(RoleName.ADMIN);
if (null == adminAccount) {
	User user = new User();

	user.setCedula(1324566655);
	user.setName("LUCY");
	user.setArea("Seguridad Vial");
	user.setEmail("seguridadVial@esomos.com");

	Set<RoleName> roles = new HashSet<>();
	roles.add(RoleName.ADMIN);
	user.setRoles(roles);



}






	}




}
