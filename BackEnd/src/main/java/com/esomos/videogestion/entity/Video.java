package com.esomos.videogestion.entity;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Time;


import jakarta.annotation.Nullable;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
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
@Table(name = "videos")
@Entity
public class Video implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idVideo;

    @NotNull
    private Date videoDate;

    @NotNull
    private Time startTime;

    @NotNull
    private Time endTime;

    @Nullable
    private String deliveryMethod;

    @Nullable
    private String size;

    @Nullable
    private String filePath;

    public Video(@NotNull Date videoDate, @NotNull Time startTime, @NotNull Time endTime) {

        this.videoDate = videoDate;
        this.startTime = startTime;
        this.endTime = endTime;
    }

}
