package com.esomos.videogestion.entity;

import java.io.Serializable;
import java.sql.Date;

import com.esomos.videogestion.security.entity.User;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Index;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotBlank;
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

@Table(name = "requests", indexes = { @Index(columnList = "record", name = "idx_record") })
@Entity
public class Request implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idRequest;

    @NotNull
    private Date requestDate;

    @Null
    private String record;

    @NotNull
    @ManyToOne
    @JoinColumn(name = "id_User", referencedColumnName = "idUser")
    private User user;

    @NotNull
    @ManyToOne
    @JoinColumn(name = "id_Bus", referencedColumnName = "idBus")
    private Bus bus;

    @Null
    @ManyToOne
    @JoinColumn(name = "id_Video", referencedColumnName = "idVideo")
    private Video video;

    @NotBlank
    private String reasonRequest;

    @Null
    private int glpiTicket;

    @NotBlank
    private String description;

    @Null
    private String receptor;

    @Null
    private String emitter;

    @Null
    private String deliveryStatus;

    @Null
    private String downloadStatus;

    @Null
    private Date dateDifference;

    @Null
    private String delivery_Date;

    public Request(@NotNull Date requestDate, @NotNull User user, @NotNull Bus bus,
            @Null Video video, @NotBlank String reasonRequest, @NotBlank String description

    ) {
        this.requestDate = requestDate;
        this.user = user;
        this.bus = bus;
        this.video = video;
        this.reasonRequest = reasonRequest;
        this.description = description;

    }

}
