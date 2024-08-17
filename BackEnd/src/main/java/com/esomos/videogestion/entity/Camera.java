package com.esomos.videogestion.entity;

import java.io.Serializable;

import com.esomos.videogestion.emuns.CameraTypes;

import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor

@Table(name = "cameras")
@Entity
public class Camera implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idCamera;

    @ManyToOne
    @JoinColumn(name = "idBus", referencedColumnName = "idBus")
    @NotNull
    private Bus bus;

    @Enumerated(EnumType.STRING)
    @NotNull
    private CameraTypes cameraTypes;

    public Camera(@NotNull Bus bus, @NotNull CameraTypes cameraTypes) {
        this.bus = bus;
        this.cameraTypes = cameraTypes;

    }

}
