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

-- Table videos

CREATE TABLE videos (
    id_Video INT,
    video_Date DATE,
    start_time TIME,
    end_time TIME,
    delibery_Method VARCHAR(255),
    size INT
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
    id_Video INT,
    reason_request LONGTEXT,
    glpi_Ticket INT,
    description LONGTEXT,
    receptor VARCHAR(255),
    emitter VARCHAR(255),
    status VARCHAR(255),
    download_Status VARCHAR(255),
    date_Difference TIME,
    delivery_Date DATE
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
ALTER TABLE videos ADD PRIMARY KEY (id_Video);
ALTER TABLE buses ADD PRIMARY KEY (id_Bus);
ALTER TABLE cameras ADD PRIMARY KEY (id_Camera);
ALTER TABLE requests ADD PRIMARY KEY (id_Request);
ALTER TABLE cameraRequests ADD PRIMARY KEY (id_CameraRequest);

-- autoincrement

ALTER TABLE users MODIFY id_User INT AUTO_INCREMENT;
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

ALTER TABLE cameras ADD CONSTRAINT fk_cameras_buses FOREIGN KEY (id_Bus) REFERENCES buses(id_Bus);
ALTER TABLE requests ADD CONSTRAINT fk_requests_users FOREIGN KEY (id_User) REFERENCES users(id_User);
ALTER TABLE requests ADD CONSTRAINT fk_requests_buses FOREIGN KEY (id_Bus) REFERENCES buses(id_Bus);
ALTER TABLE requests ADD CONSTRAINT fk_requests_videos FOREIGN KEY (id_Video) REFERENCES videos(id_Video);
ALTER TABLE cameraRequests ADD CONSTRAINT fk_cameraRequests_requests FOREIGN KEY (id_Request) REFERENCES requests(id_Request);
ALTER TABLE cameraRequests ADD CONSTRAINT fk_cameraRequests_cameras FOREIGN KEY (id_Camera) REFERENCES cameras(id_Camera);


-- Insert data











-- mysql -u root -p < C:\Users\DEVELOP\Desktop\VideoGestion\src\VideoGestion.sql
















































