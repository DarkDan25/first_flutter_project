import 'package:first_flutter_project/models/doctor.dart';

class Appointment {
  final int? id;
  final Doctor doctor;
  final String date;
  final String status;

  Appointment({
    this.id,
    required this.doctor,
    required this.date,
    required this.status,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      doctor: Doctor.fromJson(json['doctor']),
      date: json['date'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'doctor': doctor.toJson(),
      'date': date,
      'status': status,
    };
  }
}
