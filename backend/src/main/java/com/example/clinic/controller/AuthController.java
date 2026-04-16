package com.example.clinic.controller;

import com.example.clinic.entity.Patient;
import com.example.clinic.repository.PatientRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequestMapping("/api/auth")
@CrossOrigin(origins = "*")
public class AuthController {

    @Autowired
    private PatientRepository patientRepository;

    @PostMapping("/register")
    public ResponseEntity<?> register(@RequestBody Patient patient) {
        if (patientRepository.findByUsername(patient.getUsername()).isPresent()) {
            return ResponseEntity.badRequest().body("Пользователь уже существует");
        }
        return ResponseEntity.ok(patientRepository.save(patient));
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody Patient patient) {
        Optional<Patient> dbPatient = patientRepository.findByUsername(patient.getUsername());
        if (dbPatient.isPresent() && dbPatient.get().getPassword().equals(patient.getPassword())) {
            return ResponseEntity.ok(dbPatient.get());
        }
        return ResponseEntity.status(401).body("Неверный логин или пароль");
    }
}
