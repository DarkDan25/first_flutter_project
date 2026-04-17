package com.example.clinic.controller;

import com.example.clinic.entity.Admin;
import com.example.clinic.entity.Doctor;
import com.example.clinic.entity.Patient;
import com.example.clinic.repository.AdminRepository;
import com.example.clinic.repository.DoctorRepository;
import com.example.clinic.repository.PatientRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/auth")
@CrossOrigin(origins = "*")
public class AuthController {

    @Autowired
    private PatientRepository patientRepository;

    @Autowired
    private DoctorRepository doctorRepository;

    @Autowired
    private AdminRepository adminRepository;

    @PostMapping("/register")
    public ResponseEntity<?> register(@RequestBody Patient patient) {
        if (patientRepository.findByUsernameIgnoreCase(patient.getUsername()).isPresent() ||
            doctorRepository.findByUsernameIgnoreCase(patient.getUsername()).isPresent() ||
            adminRepository.findByUsernameIgnoreCase(patient.getUsername()).isPresent()) {
            return ResponseEntity.badRequest().body("Логин уже занят");
        }
        return ResponseEntity.ok(patientRepository.save(patient));
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody Map<String, String> credentials) {
        String username = credentials.get("username");
        String password = credentials.get("password");

        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            return ResponseEntity.badRequest().body("Введите логин и пароль");
        }

        username = username.trim();
        password = password.trim();

        // Check Patients
        Optional<Patient> patient = patientRepository.findByUsernameIgnoreCase(username);
        if (patient.isPresent() && patient.get().getPassword().equals(password)) {
            return ResponseEntity.ok(createResponse(patient.get(), "PATIENT"));
        }

        // Check Doctors
        Optional<Doctor> doctor = doctorRepository.findByUsernameIgnoreCase(username);
        if (doctor.isPresent() && doctor.get().getPassword().equals(password)) {
            return ResponseEntity.ok(createResponse(doctor.get(), "DOCTOR"));
        }

        // Check Admins
        Optional<Admin> admin = adminRepository.findByUsernameIgnoreCase(username);
        if (admin.isPresent() && admin.get().getPassword().equals(password)) {
            return ResponseEntity.ok(createResponse(admin.get(), "ADMIN"));
        }

        return ResponseEntity.status(401).body("Неверный логин или пароль");
    }

    private Map<String, Object> createResponse(Object user, String role) {
        Map<String, Object> response = new HashMap<>();
        response.put("user", user);
        response.put("role", role);
        return response;
    }
}
