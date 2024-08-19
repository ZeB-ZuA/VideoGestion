
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


SELECT u.id_User AS user_id, u.name AS user_name, u.email AS user_email, r.role AS role_name
FROM users u
JOIN users_roles ur ON u.id_User = ur.id_User
JOIN roles r ON ur.id_Role = r.id_Role
ORDER BY u.name, r.role;