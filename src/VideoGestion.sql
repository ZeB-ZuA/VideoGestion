DROP DATABASE IF EXISTS VideoGestion;
CREATE DATABASE VideoGestion;
USE VideoGestion;

-- Table users

CREATE TABLE users (
    id_User INT,
    cedula BIGINT NOT NULL UNIQUE,
    name VARCHAR(255),
    area VARCHAR(255),
    email VARCHAR(255),
    password VARCHAR(255),
    headquarter VARCHAR(255)
);

-- Table roles
CREATE TABLE roles (
    id_Role INT,
    role VARCHAR(255)
);

-- table users_roles
CREATE TABLE users_roles (
    id_User INT,
    id_Role INT
);

-- Table videos

CREATE TABLE videos (
    id_Video INT,
    video_Date DATE,
    start_time TIME,
    end_time TIME,
    delivery_Method VARCHAR(255),
    size INT,
    file_Path VARCHAR(255)
);

-- Table buses

CREATE TABLE buses (
    id_Bus INT,
    no_Bus VARCHAR(255),
    bus_Type VARCHAR(255)

);

-- Table cameras

CREATE TABLE cameras (
    id_Camera INT,
    id_Bus INT,
    camera_Type VARCHAR(255)
);

-- Table requests

CREATE TABLE requests (
    id_Request INT,
    request_Date DATE,
    record VARCHAR(255),
    id_User INT,
    id_Bus INT,
    id_Video INT NULL,
    reason_request LONGTEXT,
    glpi_Ticket INT,
    description LONGTEXT,
    receptor VARCHAR(255),
    emitter VARCHAR(255),
    delivery_Status VARCHAR(255),
    download_Status VARCHAR(255),
    date_Difference TIME NULL,
    delivery_Date DATE NULL
);

-- Table camera_Requests

CREATE TABLE camera_Requests (
    id_CameraRequest INT,
    id_Request INT,
    id_Camera INT,
    requested BOOLEAN DEFAULT FALSE
);


-- Primary keys

ALTER TABLE users ADD PRIMARY KEY (id_User);
ALTER TABLE roles ADD PRIMARY KEY (id_Role);
ALTER TABLE users_roles ADD PRIMARY KEY (id_User, id_Role);
ALTER TABLE videos ADD PRIMARY KEY (id_Video);
ALTER TABLE buses ADD PRIMARY KEY (id_Bus);
ALTER TABLE cameras ADD PRIMARY KEY (id_Camera);
ALTER TABLE requests ADD PRIMARY KEY (id_Request);
ALTER TABLE camera_Requests ADD PRIMARY KEY (id_CameraRequest);

-- autoincrement

ALTER TABLE users MODIFY id_User INT AUTO_INCREMENT;
ALTER TABLE roles MODIFY id_Role INT AUTO_INCREMENT;
ALTER TABLE videos MODIFY id_Video INT AUTO_INCREMENT;
ALTER TABLE buses MODIFY id_Bus INT AUTO_INCREMENT;
ALTER TABLE cameras MODIFY id_Camera INT AUTO_INCREMENT;
ALTER TABLE requests MODIFY id_Request INT AUTO_INCREMENT;
ALTER TABLE camera_Requests MODIFY id_CameraRequest INT AUTO_INCREMENT;

-- index

CREATE UNIQUE INDEX idx_cedula ON users (cedula);
CREATE UNIQUE INDEX idx_email ON users (email);
CREATE UNIQUE INDEX idx_no_Bus ON buses (no_Bus);
CREATE UNIQUE INDEX idx_record ON requests (record);

-- Foreign keys

ALTER TABLE users_roles 
    ADD CONSTRAINT fk_users_roles_users 
    FOREIGN KEY (id_User) 
    REFERENCES users(id_User) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE;

ALTER TABLE users_roles 
    ADD CONSTRAINT fk_users_roles_roles 
    FOREIGN KEY (id_Role) 
    REFERENCES roles(id_Role) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE;

ALTER TABLE cameras 
    ADD CONSTRAINT fk_cameras_buses 
    FOREIGN KEY (id_Bus) 
    REFERENCES buses(id_Bus) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE;

ALTER TABLE requests 
    ADD CONSTRAINT fk_requests_users 
    FOREIGN KEY (id_User) 
    REFERENCES users(id_User) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE;

ALTER TABLE requests 
    ADD CONSTRAINT fk_requests_buses 
    FOREIGN KEY (id_Bus) 
    REFERENCES buses(id_Bus) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE;

ALTER TABLE requests 
    ADD CONSTRAINT fk_requests_videos 
    FOREIGN KEY (id_Video) 
    REFERENCES videos(id_Video) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE;

ALTER TABLE camera_Requests 
    ADD CONSTRAINT fk_camera_Requests_requests 
    FOREIGN KEY (id_Request) 
    REFERENCES requests(id_Request) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE;

ALTER TABLE camera_Requests 
    ADD CONSTRAINT fk_camera_Requests_cameras 
    FOREIGN KEY (id_Camera) 
    REFERENCES cameras(id_Camera) 
    ON DELETE CASCADE 
    ON UPDATE CASCADE;


-- Insert data

INSERT INTO roles (role) VALUES ('ADMIN'),
                              ('USER');

INSERT INTO users (cedula, name, area, email, password, headquarter) VALUES (12345, 'lucy', 'seguridad vial', 'seguridadvial@esomos.com', 'contraseni123', 'USME');
INSERT INTO users (cedula, name, area, email, password, headquarter) VALUES (54321, 'admin', 'ti its', 'mesati@esomos.com', 'contrasenia123', 'USME');
INSERT INTO users_roles (id_User, id_Role) VALUES (1, 2),
                                                 (2, 1);

DELIMITER //

CREATE TRIGGER after_bus_insert
AFTER INSERT ON buses
FOR EACH ROW
BEGIN
    INSERT INTO cameras (id_Bus, camera_Type) VALUES 
        (NEW.id_Bus, 'CAMARA FRONTAL'),
        (NEW.id_Bus, 'CAMARA CONDUCTOR'),
        (NEW.id_Bus, 'VALIDACION FRONTAL'),
        (NEW.id_Bus, 'INTERNA 1'),
        (NEW.id_Bus, 'INTERNA 2'),
        (NEW.id_Bus, 'INTERNA 3'),
        (NEW.id_Bus, 'POSTERIOR'),
        (NEW.id_Bus, 'REVERSA');
END;
//

DELIMITER ;


INSERT INTO buses (no_Bus, bus_Type) VALUES ('7900', 'PADRON'),
                                            ("7844", "PADRON"),
                                            ("4803", "BUSETON");
                                                                                          
INSERT INTO videos (video_Date, start_time, end_time, delivery_Method, size, file_Path) VALUES   ('2021-06-01', '08:00:00', '09:00:00', 'DISCO DURO', 100, 'C:ftp/videos/7861 E-2323'),
                                                                                                 ('2021-06-01', '09:00:00', '10:00:00', 'DISCO DURO', 100, 'C:ftp/videos/7862 E-2323'),
                                                                                                 ('2021-06-01', '10:00:00', '11:00:00', 'DISCO DURO', 100, 'C:ftp/videos/7863 E-2324'),
                                                                                                 ('2021-06-01', '11:00:00', '12:00:00', 'DISCO DURO', 100, 'C:ftp/videos/7864 E-2325'),
                                                                                                 ('2021-06-01', '12:00:00', '13:00:00', 'DISCO DURO', 100, 'C:ftp/videos/7865 E-2326'),
                                                                                                 ('2021-06-01', '13:00:00', '14:00:00', 'DISCO DURO', 100, 'C:ftp/videos/7866 E-2327'),
                                                                                                 ('2021-06-01', '14:00:00', '15:00:00', 'DISCO DURO', 100, 'C:ftp/videos/7867 E-2328'),
                                                                                                 ('2021-06-01', '15:00:00', '16:00:00', 'DISCO DURO', 100, 'C:ftp/videos/7868 E-2329'),
                                                                                                 ('2021-06-01', '16:00:00', '17:00:00', 'DISCO DURO', 100, 'C:ftp/videos/7869 E-2330'),
                                                                                                 ('2021-06-01', '17:00:00', '18:00:00', 'DISCO DURO', 100, 'C:ftp/videos/7861 E-2331');
-- Solicitud 1
INSERT INTO requests (
    request_Date, 
    record, 
    id_User, 
    id_Bus,
    id_Video, 
    reason_request, 
    glpi_Ticket, 
    description, 
    receptor, 
    emitter, 
    delivery_Status, 
    download_Status
) 
VALUES (
    CURDATE(),                   -- Fecha de la solicitud
    'E-2323',                    -- Registro
    1,                           -- id_User (suponiendo que el usuario con id 1 está haciendo la solicitud)
    1,                           -- id_Bus (bus con id 1)
    4,                           -- id_Video (video con id 4)
    'Revisión de incidentes',     -- Motivo de la solicitud
    1234,                        -- Ticket GLPI
    'Descripción del incidente',  -- Descripción
    'Juan Pérez',                 -- Receptor
    'Admin',                      -- Emisor
    'PENDIENTE',                  -- Estado de la solicitud
    'PENDIENTE'                   -- Estado de la descarga
);

SET @requestId1 = LAST_INSERT_ID();

-- Solicitud 2
INSERT INTO requests (
    request_Date, 
    record, 
    id_User, 
    id_Bus,
    id_Video, 
    reason_request, 
    glpi_Ticket, 
    description, 
    receptor, 
    emitter, 
    delivery_Status, 
    download_Status
) 
VALUES (
    CURDATE(), 
    'E-2324', 
    1, 
    3, 
    5,
    'Revisión de incidentes', 
    5678, 
    'Descripción del incidente', 
    'Laura González', 
    'Admin', 
    'PENDIENTE', 
    'PENDIENTE'
);

SET @requestId2 = LAST_INSERT_ID();

-- Solicitud 3
INSERT INTO requests (
    request_Date, 
    record, 
    id_User, 
    id_Bus,
    id_Video, 
    reason_request, 
    glpi_Ticket, 
    description, 
    receptor, 
    emitter, 
    delivery_Status, 
    download_Status
) 
VALUES (
    CURDATE(), 
    'E-2325', 
    1, 
    1, 
    6,
    'Revisión de incidentes', 
    91011, 
    'Descripción del incidente', 
    'María Pérez', 
    'Admin', 
    'PENDIENTE', 
    'PENDIENTE'
);

SET @requestId3 = LAST_INSERT_ID();

-- Cámaras solicitadas para la Solicitud 1
INSERT INTO camera_Requests (id_Request, id_Camera, requested) 
VALUES 
    (@requestId1, 1, TRUE),  -- CAMARA FRONTAL
    (@requestId1, 2, TRUE),  -- CAMARA CONDUCTOR
    (@requestId1, 3, FALSE), -- VALIDACION FRONTAL
    (@requestId1, 4, TRUE),  -- INTERNA 1
    (@requestId1, 5, FALSE), -- INTERNA 2
    (@requestId1, 6, TRUE),  -- INTERNA 3
    (@requestId1, 7, TRUE),  -- POSTERIOR
    (@requestId1, 8, FALSE); -- REVERSA

-- Cámaras solicitadas para la Solicitud 2
INSERT INTO camera_Requests (id_Request, id_Camera, requested) 
VALUES 
    (@requestId2, 1, TRUE),  -- CAMARA FRONTAL
    (@requestId2, 2, TRUE),  -- CAMARA CONDUCTOR
    (@requestId2, 3, TRUE),  -- VALIDACION FRONTAL
    (@requestId2, 4, FALSE), -- INTERNA 1
    (@requestId2, 5, TRUE),  -- INTERNA 2
    (@requestId2, 6, FALSE), -- INTERNA 3
    (@requestId2, 7, TRUE),  -- POSTERIOR
    (@requestId2, 8, TRUE);  -- REVERSAz

-- Cámaras solicitadas para la Solicitud 3
INSERT INTO camera_Requests (id_Request, id_Camera, requested) 
VALUES 
    (@requestId3, 1, FALSE), -- CAMARA FRONTAL
    (@requestId3, 2, TRUE),  -- CAMARA CONDUCTOR
    (@requestId3, 3, TRUE),  -- VALIDACION FRONTAL
    (@requestId3, 4, TRUE),  -- INTERNA 1
    (@requestId3, 5, FALSE), -- INTERNA 2
    (@requestId3, 6, TRUE),  -- INTERNA 3
    (@requestId3, 7, FALSE), -- POSTERIOR
    (@requestId3, 8, FALSE); -- REVERSA








-- mysql -u root -p < C:\Users\User\Desktop\VideoGestion\src\VideoGestion.sql
-- mysql -u root -p -b videoGestion
