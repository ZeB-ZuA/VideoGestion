package com.esomos.videogestion.entity;

import java.io.Serializable;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Null;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor

@Table(name = "camera_requests")
@Entity
public class CameraRequest implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id_CameraRequest;

    @ManyToOne
    @JoinColumn(name = "id_Camera", referencedColumnName = "idCamera")
    @NotNull
    private Camera camera;

    @ManyToOne
    @JoinColumn(name = "id_Request", referencedColumnName = "idRequest")
    @NotNull
    private Request request;

    @Null
    private Boolean requested = false;

    public CameraRequest(@NotNull Camera camera, @NotNull Request request) {
        this.camera = camera;
        this.request = request;

    }
}