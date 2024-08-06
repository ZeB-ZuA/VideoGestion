package com.esomos.videogestion;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.GetMapping;


@RestController
public class TestController {

    @GetMapping("/hello")
   public String hello(){
        return "Hello World First Spring Boot Application";
    }
}
