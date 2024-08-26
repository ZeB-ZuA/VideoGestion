package com.esomos.videogestion.security.config;

import java.io.IOException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import com.esomos.videogestion.security.service.JwtService;
import com.esomos.videogestion.security.service.UserService;

import io.micrometer.common.util.StringUtils;
import lombok.RequiredArgsConstructor;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
@RequiredArgsConstructor

public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private final JwtService jwtService;

    private final UserService userService;

    private static final Logger logger = LoggerFactory.getLogger(JwtAuthenticationFilter.class);

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {
        final String authorizationHeader = request.getHeader("Authorization");
        final String jwt;
        final String userEmail;
        logger.info("Authorization Header: {}" + authorizationHeader);

        if (StringUtils.isEmpty(authorizationHeader)) {
            logger.warn("Authorization header is missing");
            filterChain.doFilter(request, response);
            return;
        }
    
       
        if (!authorizationHeader.startsWith("Bearer ")) {
            logger.warn("Authorization header does not start with 'Bearer '");
            filterChain.doFilter(request, response);
            return;
        }
    
        jwt = authorizationHeader.substring(7);
        userEmail = jwtService.extractUserName(jwt);

        logger.info("Extracted user email: {}", userEmail);

        if (StringUtils.isNotEmpty(userEmail) && SecurityContextHolder.getContext().getAuthentication() == null) {

            UserDetails userDetails = userService.loadUserByUsername(userEmail);

            if (jwtService.isTokenValid(jwt, userDetails)) {
                SecurityContext securityContext = SecurityContextHolder.createEmptyContext();
                UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(userDetails, null,
                        userDetails.getAuthorities());

                token.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
                securityContext.setAuthentication(token);

                SecurityContextHolder.setContext(securityContext);
                logger.info("User {} authenticated successfully", userEmail);
            }else{
                logger.warn("JWT token is invalid for user {}", userEmail);
            }

        }

        filterChain.doFilter(request, response);

    }

}
