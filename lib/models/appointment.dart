import 'package:first_flutter_project/models/doctor.dart';
import 'package:first_flutter_project/models/patient.dart';
import 'package:intl/intl.dart';

class Appointment {
  final int? id;
  final Patient? patient;
  final Doctor doctor;
  final String date;
  final String time;
  final String status;

  Appointment({
    this.id,
    this.patient,
    required this.doctor,
    required this.date,
    required this.time,
    required this.status,
  });

  String get formattedDate {
    try {
      // Input date is yyyy-MM-dd
      DateTime dt = DateFormat('yyyy-MM-dd').parse(date);
      return DateFormat('dd.MM.yyyy').format(dt);
    } catch (e) {
      return date;
    }
  }

  Appointment copyWith({
    int? id,
    Patient? patient,
    Doctor? doctor,
    String? date,
    String? time,
    String? status,
  }) {
    return Appointment(
      id: id ?? this.id,
      patient: patient ?? this.patient,
      doctor: doctor ?? this.doctor,
      date: date ?? this.date,
      time: time ?? this.time,
      status: status ?? this.status,
    );
  }

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      patient: json['patient'] != null ? Patient.fromJson(json['patient']) : null,
      doctor: Doctor.fromJson(json['doctor']),
      date: json['date'],
      time: json['time'] ?? '',
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (patient != null) 'patient': patient!.toJson(),
      'doctor': doctor.toJson(),
      'date': date,
      'time': time,
      'status': status,
    };
  }
}
