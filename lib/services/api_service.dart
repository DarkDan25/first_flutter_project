import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/doctor.dart';
import '../models/patient.dart';
import '../models/appointment.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.1.78:8080/api';

  // Doctors
  static Future<List<Doctor>> getDoctors() async {
    final response = await http.get(Uri.parse('$baseUrl/doctors'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      return jsonResponse.map((data) => Doctor.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load doctors');
    }
  }

  static Future<Doctor> addDoctor(Doctor doctor) async {
    final response = await http.post(
      Uri.parse('$baseUrl/doctors'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(doctor.toJson()),
    );
    if (response.statusCode == 200) {
      return Doctor.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to add doctor');
    }
  }

  static Future<Doctor> updateDoctor(int id, Doctor doctor) async {
    final response = await http.put(
      Uri.parse('$baseUrl/doctors/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(doctor.toJson()),
    );
    if (response.statusCode == 200) {
      return Doctor.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to update doctor');
    }
  }

  static Future<void> deleteDoctor(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/doctors/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete doctor');
    }
  }

  // Patients
  static Future<List<Patient>> getPatients() async {
    final response = await http.get(Uri.parse('$baseUrl/patients'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      return jsonResponse.map((data) => Patient.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load patients');
    }
  }

  static Future<Patient> updatePatient(int id, Patient patient) async {
    final response = await http.put(
      Uri.parse('$baseUrl/patients/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(patient.toJson()),
    );
    if (response.statusCode == 200) {
      return Patient.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to update patient');
    }
  }

  static Future<void> deletePatient(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/patients/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete patient');
    }
  }

  // Appointments
  static Future<List<Appointment>> getAppointments() async {
    final response = await http.get(Uri.parse('$baseUrl/appointments'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      return jsonResponse.map((data) => Appointment.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load appointments');
    }
  }

  static Future<Appointment> addAppointment(Appointment appointment) async {
    final response = await http.post(
      Uri.parse('$baseUrl/appointments'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(appointment.toJson()),
    );
    if (response.statusCode == 200) {
      return Appointment.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to add appointment');
    }
  }

  static Future<Appointment> updateAppointment(int id, String status) async {
    final response = await http.put(
      Uri.parse('$baseUrl/appointments/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'status': status}),
    );
    if (response.statusCode == 200) {
      return Appointment.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to update appointment status');
    }
  }

  // Auth
  static Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'username': username, 'password': password}),
    );
    if (response.statusCode == 200) {
      return json.decode(utf8.decode(response.bodyBytes));
    } else {
      final error = utf8.decode(response.bodyBytes);
      throw Exception(error.isNotEmpty ? error : 'Ошибка входа');
    }
  }

  static Future<Map<String, dynamic>> register(String username, String password, String firstName, String lastName) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': username,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
      }),
    );
    if (response.statusCode == 200) {
      return json.decode(utf8.decode(response.bodyBytes));
    } else {
      final error = utf8.decode(response.bodyBytes);
      throw Exception(error.isNotEmpty ? error : 'Ошибка регистрации');
    }
  }
}
