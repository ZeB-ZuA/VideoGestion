DROP DATABASE IF EXISTS VideoGestion;
CREATE DATABASE VideoGestion;
USE VideoGestion;

-- Table users

CREATE TABLE users (
    id_User INT,
    cedula BIGINT,
    name VARCHAR(255),
    email VARCHAR(255),
    password VARCHAR(255),
    headquarter VARCHAR(255)
);