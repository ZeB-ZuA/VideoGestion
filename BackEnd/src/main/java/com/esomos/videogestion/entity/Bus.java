package com.esomos.videogestion.entity;

import java.io.Serializable;

import com.esomos.videogestion.emuns.BusTypes;

import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Index;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor

@Table(name = "buses", indexes = { @Index(columnList = "NoBus", name = "idx_no_Bus") })
@Entity
public class Bus implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idBus;

    @NotBlank
    private String NoBus;


    @NotNull
    @Enumerated(EnumType.STRING)
    private BusTypes busType;

    public Bus(@NotBlank String NoBus, @NotNull BusTypes busType) {
        this.NoBus = NoBus;
        this.busType = busType;
    }

}
