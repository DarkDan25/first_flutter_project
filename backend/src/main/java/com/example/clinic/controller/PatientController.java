package com.example.clinic.controller;

import com.example.clinic.entity.Patient;
import com.example.clinic.repository.PatientRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/patients")
@CrossOrigin(origins = "*")
public class PatientController {

    @Autowired
    private PatientRepository patientRepository;

    @GetMapping
    public List<Patient> getAllPatients() {
        return patientRepository.findAll();
    }

    @PutMapping("/{id}")
    public Patient updatePatient(@PathVariable Integer id, @RequestBody Patient patient) {
        Optional<Patient> existingPatient = patientRepository.findById(id);
        if (existingPatient.isPresent()) {
            Patient updatedPatient = existingPatient.get();
            updatedPatient.setFirstName(patient.getFirstName());
            updatedPatient.setLastName(patient.getLastName());
            updatedPatient.setMiddleName(patient.getMiddleName());
            updatedPatient.setUsername(patient.getUsername());
            
            if (patient.getPassword() != null && !patient.getPassword().isEmpty()) {
                updatedPatient.setPassword(patient.getPassword());
            }
            
            return patientRepository.save(updatedPatient);
        }
        patient.setId(id);
        return patientRepository.save(patient);
    }

    @DeleteMapping("/{id}")
    public void deletePatient(@PathVariable Integer id) {
        patientRepository.deleteById(id);
    }
}
