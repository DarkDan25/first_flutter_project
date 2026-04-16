package com.example.clinic.entity;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "appointments")
public class Appointment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_записи")
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_пациента", nullable = false)
    private Patient patient;

    @ManyToOne
    @JoinColumn(name = "id_врача", nullable = false)
    private Doctor doctor;

    @Column(name = "дата")
    private LocalDate date;

    @Column(name = "статус", nullable = false, length = 20)
    private String status;

    public Appointment() {}

    public Appointment(Integer id, Patient patient, Doctor doctor, LocalDate date, String status) {
        this.id = id;
        this.patient = patient;
        this.doctor = doctor;
        this.date = date;
        this.status = status;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Patient getPatient() {
        return patient;
    }

    public void setPatient(Patient patient) {
        this.patient = patient;
    }

    public Doctor getDoctor() {
        return doctor;
    }

    public void setDoctor(Doctor doctor) {
        this.doctor = doctor;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
