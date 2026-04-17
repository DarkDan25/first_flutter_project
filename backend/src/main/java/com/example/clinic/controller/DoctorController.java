package com.example.clinic.controller;

import com.example.clinic.entity.Doctor;
import com.example.clinic.repository.DoctorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/doctors")
@CrossOrigin(origins = "*")
public class DoctorController {

    @Autowired
    private DoctorRepository doctorRepository;

    @GetMapping
    public List<Doctor> getAllDoctors() {
        return doctorRepository.findAll();
    }

    @PostMapping
    public Doctor addDoctor(@RequestBody Doctor doctor) {
        return doctorRepository.save(doctor);
    }

    @PutMapping("/{id}")
    public Doctor updateDoctor(@PathVariable Integer id, @RequestBody Doctor doctor) {
        Optional<Doctor> existingDoctor = doctorRepository.findById(id);
        if (existingDoctor.isPresent()) {
            Doctor updatedDoctor = existingDoctor.get();
            updatedDoctor.setFirstName(doctor.getFirstName());
            updatedDoctor.setLastName(doctor.getLastName());
            updatedDoctor.setMiddleName(doctor.getMiddleName());
            updatedDoctor.setSpecialty(doctor.getSpecialty());
            updatedDoctor.setUsername(doctor.getUsername());
            
            // Only update password if a new one is provided
            if (doctor.getPassword() != null && !doctor.getPassword().isEmpty()) {
                updatedDoctor.setPassword(doctor.getPassword());
            }
            
            return doctorRepository.save(updatedDoctor);
        }
        doctor.setId(id);
        return doctorRepository.save(doctor);
    }

    @DeleteMapping("/{id}")
    public void deleteDoctor(@PathVariable Integer id) {
        doctorRepository.deleteById(id);
    }
}
