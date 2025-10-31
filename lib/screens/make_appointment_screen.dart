import 'package:flutter/material.dart';
import 'package:first_flutter_project/models/appointment.dart';
import 'package:first_flutter_project/models/doctor.dart';
import 'package:first_flutter_project/data/doctors_data.dart';
import 'package:first_flutter_project/widgets/cached_doctor_image.dart';

class MakeAppointmentScreen extends StatefulWidget {
  final Function(Appointment) onAddAppointment;

  const MakeAppointmentScreen({super.key, required this.onAddAppointment});

  @override
  State<MakeAppointmentScreen> createState() => _MakeAppointmentScreenState();
}

class _MakeAppointmentScreenState extends State<MakeAppointmentScreen> {
  final _formKey = GlobalKey<FormState>();
  String _selectedDoctor = '';
  String _selectedDate = '';
  String _selectedTime = '';

  final Map<String, String> _doctorSpecialties = {
    'Иванов И.И.': 'Кардиолог',
    'Петрова А.Д.': 'Невролог',
    'Сидоров Е.В.': 'Терапевт',
    'Кузнецова К.Н.': 'Стоматолог',
    'Симанович В.Г.': 'Хирург',
    'Кузин О.М.': 'Хирург',
  };

  final Map<String, Doctor> _availableDoctors = {
    for (var doctor in DoctorsData.doctors) doctor.name: doctor
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Запись к врачу')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                items: _availableDoctors.keys
                    .map((doctorName) {
                  final doctor = _availableDoctors[doctorName]!;
                  return DropdownMenuItem(
                    value: doctorName,
                    child: Row(
                      children: [
                        // CachedDoctorImage(
                        //   imageUrl: doctor.imageUrl,
                        //   //localAsset: doctor.localAsset,
                        //   width: 40,
                        //   height: 40,
                        // ),
                        // SizedBox(width: 12),
                        Text('${doctor.name} - ${doctor.specialty}'),
                      ],
                    ),
                  );
                })
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedDoctor = value);
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Выберите врача',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Выберите врача';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Дата (дд.мм.гггг)',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите дату';
                  }
                  return null;
                },
                onChanged: (value) => _selectedDate = value,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Время (чч:мм)',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите время';
                  }
                  return null;
                },
                onChanged: (value) => _selectedTime = value,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Записаться'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final doctor = _availableDoctors[_selectedDoctor]!;
      final newAppointment = Appointment(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        doctorName: _selectedDoctor,
        specialty: _doctorSpecialties[_selectedDoctor] ?? 'Врач',
        date: _selectedDate,
        time: _selectedTime,
        imageUrl: doctor.imageUrl,
        //localAsset: doctor.localAsset,
      );

      widget.onAddAppointment(newAppointment);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Запись к $_selectedDoctor успешно создана!')),
      );

      _formKey.currentState!.reset();
      setState(() {
        _selectedDoctor = '';
        _selectedDate = '';
        _selectedTime = '';
      });
    }
  }
}