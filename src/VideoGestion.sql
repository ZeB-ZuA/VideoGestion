DROP DATABASE IF EXISTS VideoGestion;
CREATE DATABASE VideoGestion;
USE VideoGestion;

-- Table users

CREATE TABLE users (
    id_User INT,
    cedula BIGINT,
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

-- Table cameraRequests

CREATE TABLE cameraRequests (
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
ALTER TABLE cameraRequests ADD PRIMARY KEY (id_CameraRequest);

-- autoincrement

ALTER TABLE users MODIFY id_User INT AUTO_INCREMENT;
ALTER TABLE roles MODIFY id_Role INT AUTO_INCREMENT;
ALTER TABLE videos MODIFY id_Video INT AUTO_INCREMENT;
ALTER TABLE buses MODIFY id_Bus INT AUTO_INCREMENT;
ALTER TABLE cameras MODIFY id_Camera INT AUTO_INCREMENT;
ALTER TABLE requests MODIFY id_Request INT AUTO_INCREMENT;
ALTER TABLE cameraRequests MODIFY id_CameraRequest INT AUTO_INCREMENT;

-- index

CREATE INDEX idx_cedula ON users (cedula);
CREATE INDEX idx_email ON users (email);
CREATE INDEX idx_no_Bus ON buses (no_Bus);
CREATE INDEX idx_record ON requests (record);

-- Foreign keys

ALTER TABLE users_roles ADD CONSTRAINT fk_users_roles_users FOREIGN KEY (id_User) REFERENCES users(id_User);
ALTER TABLE users_roles ADD CONSTRAINT fk_users_roles_roles FOREIGN KEY (id_Role) REFERENCES roles(id_Role);
ALTER TABLE cameras ADD CONSTRAINT fk_cameras_buses FOREIGN KEY (id_Bus) REFERENCES buses(id_Bus);
ALTER TABLE requests ADD CONSTRAINT fk_requests_users FOREIGN KEY (id_User) REFERENCES users(id_User);
ALTER TABLE requests ADD CONSTRAINT fk_requests_buses FOREIGN KEY (id_Bus) REFERENCES buses(id_Bus);
ALTER TABLE requests ADD CONSTRAINT fk_requests_videos FOREIGN KEY (id_Video) REFERENCES videos(id_Video);
ALTER TABLE cameraRequests ADD CONSTRAINT fk_cameraRequests_requests FOREIGN KEY (id_Request) REFERENCES requests(id_Request);
ALTER TABLE cameraRequests ADD CONSTRAINT fk_cameraRequests_cameras FOREIGN KEY (id_Camera) REFERENCES cameras(id_Camera);


-- Insert data

INSERT INTO roles (role) VALUES ('ADMIN'),
                              ('USER');

INSERT INTO users (cedula, name, area, email, password, headquarter) VALUES (12345, 'lucy', 'seguridad vial', 'seguridadvial@esomos.com', 'contraseña123', 'USME');
INSERT INTO users (cedula, name, area, email, password, headquarter) VALUES (12345, 'admin', 'ti its', 'mesati@esomos.com', 'contraseña123', 'USME');
INSERT INTO users_roles (id_User, id_Role) VALUES (1, 2),
                                                 (2, 1);

INSERT INTO buses (no_Bus, bus_Type) VALUES ('7900', 'PADRON'),
                                            ("7844", "PADRON"),
                                            ("4803", "BUSETON");
INSERT INTO cameras (id_Bus, camera_Type) VALUES (1, "CAMARA FRONTAL"),
                                                 (1, "CAMARA CONDUCTOR"),
                                                 (1, "VALIDACION FRONTAL"),
                                                 (1, "INTERNA 1"),
                                                 (1, "INTERNA 2"),
                                                 (1, "INTERNA 3"),
                                                 (1, "POSTERIOR"),
                                                 (1, "REVERSA");
INSERT INTO cameras (id_Bus, camera_Type) VALUES (2, "CAMARA FRONTAL"),
                                                 (2, "CAMARA CONDUCTOR"),
                                                 (2, "VALIDACION FRONTAL"),
                                                 (2, "INTERNA 1"),
                                                 (2, "INTERNA 2"),
                                                 (2, "INTERNA 3"),
                                                 (2, "POSTERIOR"),
                                                 (2, "REVERSA");
INSERT INTO cameras (id_Bus, camera_Type) VALUES (3, "CAMARA FRONTAL"),
                                                 (3, "CAMARA CONDUCTOR"),
                                                 (3, "VALIDACION FRONTAL"),
                                                 (3, "INTERNA 1"),
                                                 (3, "INTERNA 2"),
                                                 (3, "INTERNA 3"),
                                                 (3, "POSTERIOR"),
                                                 (3, "REVERSA");      
                                                                                          
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
INSERT INTO cameraRequests (id_Request, id_Camera, requested) 
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
INSERT INTO cameraRequests (id_Request, id_Camera, requested) 
VALUES 
    (@requestId2, 1, TRUE),  -- CAMARA FRONTAL
    (@requestId2, 2, TRUE),  -- CAMARA CONDUCTOR
    (@requestId2, 3, TRUE),  -- VALIDACION FRONTAL
    (@requestId2, 4, FALSE), -- INTERNA 1
    (@requestId2, 5, TRUE),  -- INTERNA 2
    (@requestId2, 6, FALSE), -- INTERNA 3
    (@requestId2, 7, TRUE),  -- POSTERIOR
    (@requestId2, 8, TRUE);  -- REVERSA

-- Cámaras solicitadas para la Solicitud 3
INSERT INTO cameraRequests (id_Request, id_Camera, requested) 
VALUES 
    (@requestId3, 1, FALSE), -- CAMARA FRONTAL
    (@requestId3, 2, TRUE),  -- CAMARA CONDUCTOR
    (@requestId3, 3, TRUE),  -- VALIDACION FRONTAL
    (@requestId3, 4, TRUE),  -- INTERNA 1
    (@requestId3, 5, FALSE), -- INTERNA 2
    (@requestId3, 6, TRUE),  -- INTERNA 3
    (@requestId3, 7, FALSE), -- POSTERIOR
    (@requestId3, 8, FALSE); -- REVERSA


/*

SELECT 
    r.record AS REGISTRO,
    r.request_Date AS FECHA_SOLICITUD,
    u.name AS PERSONA_QUIEN_SOLICITA,
    u.cedula AS CEDULA,
    u.area AS AREA_SOLICITA,
    u.headquarter AS SEDE,
    b.bus_Type AS TIPO_DE_BUS,
    b.no_Bus AS NO_BUS,
    r.reason_request AS MOTIVO_SOLICITUD,
    r.glpi_Ticket AS TICKET_GLPI,
    COALESCE(MAX(CASE WHEN c.camera_Type = 'CAMARA FRONTAL' AND cr.requested THEN 'SI' ELSE 'No' END), 'No') AS CAMARA_FRONTAL,
    COALESCE(MAX(CASE WHEN c.camera_Type = 'CAMARA CONDUCTOR' AND cr.requested THEN 'SI' ELSE 'No' END), 'No') AS CAMARA_CONDUCTOR,
    COALESCE(MAX(CASE WHEN c.camera_Type = 'VALIDACION FRONTAL' AND cr.requested THEN 'SI' ELSE 'No' END), 'No') AS VALIDACION_FRONTAL,
    COALESCE(MAX(CASE WHEN c.camera_Type = 'INTERNA 1' AND cr.requested THEN 'SI' ELSE 'No' END), 'No') AS INTERNA1,
    COALESCE(MAX(CASE WHEN c.camera_Type = 'INTERNA 2' AND cr.requested THEN 'SI' ELSE 'No' END), 'No') AS INTERNA_2,
    COALESCE(MAX(CASE WHEN c.camera_Type = 'INTERNA 3' AND cr.requested THEN 'SI' ELSE 'No' END), 'No') AS INTERNA_3,
    COALESCE(MAX(CASE WHEN c.camera_Type = 'POSTERIOR' AND cr.requested THEN 'SI' ELSE 'No' END), 'No') AS POSTERIOR,
    COALESCE(MAX(CASE WHEN c.camera_Type = 'REVERSA' AND cr.requested THEN 'SI' ELSE 'No' END), 'No') AS REVERSA,
    r.description AS DESCRIPCION,
    v.video_Date AS FECHA_GRABACION,
    CONCAT(v.start_time, ' - ', v.end_time) AS FRANJA_HORARIA_SOLICITADA,
    v.delivery_Method AS MEDIO_MAGNETICO_ENTREGA,
    v.size AS TAMANO_VIDEO,
    r.receptor AS PERSONA_QUIEN_RECIBE,
    r.emitter AS TECNICO_QUE_ENTREGA,
    r.delivery_Status AS ESTADO_DE_ENTREGA,
    r.delivery_Date AS FECHA_DE_ENTREGA,
    r.download_Status AS ESTADO_DESCARGA,
    DATEDIFF(r.delivery_Date, r.request_Date) AS DIFERENCIA_DIAS_ENTREGA
FROM requests r
JOIN users u ON r.id_User = u.id_User
JOIN buses b ON r.id_Bus = b.id_Bus
LEFT JOIN cameraRequests cr ON r.id_Request = cr.id_Request
LEFT JOIN cameras c ON cr.id_Camera = c.id_Camera
LEFT JOIN videos v ON r.id_Video = v.id_Video
GROUP BY r.record, r.request_Date, u.name, u.email, u.cedula, u.area, u.headquarter, b.bus_Type, b.no_Bus, r.reason_request, r.glpi_Ticket, r.description, v.video_Date, v.start_time, v.end_time, v.delivery_Method, v.size, r.receptor, r.emitter, r.delivery_Status, r.delivery_Date, r.download_Status;



*/








-- mysql -u root -p < C:\Users\DEVELOP\Desktop\VideoGestion\src\VideoGestion.sql
















































