import 'package:flutter/material.dart';
import 'package:first_flutter_project/models/appointment.dart';
import 'package:first_flutter_project/models/doctor.dart';
import 'package:first_flutter_project/data/doctors_data.dart';

class MakeAppointmentScreen extends StatefulWidget {
  final Function(Appointment) onAddAppointment;

  const MakeAppointmentScreen({super.key, required this.onAddAppointment});

  @override
  State<MakeAppointmentScreen> createState() => _MakeAppointmentScreenState();
}

class _MakeAppointmentScreenState extends State<MakeAppointmentScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedDoctor;
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
      appBar: AppBar(
        title: Text('Запись к врачу'),
        // Убираем кнопку назад
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: _selectedDoctor,
                items: _availableDoctors.keys.map((doctorName) {
                  final doctor = _availableDoctors[doctorName]!;
                  return DropdownMenuItem(
                    value: doctorName,
                    child: Row(
                      children: [
                        Text('${doctor.name} - ${doctor.specialty}'),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => _selectedDoctor = value);
                },
                decoration: InputDecoration(
                  labelText: 'Выберите врача',
                  border: OutlineInputBorder(),
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
                  border: OutlineInputBorder(),
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
                  border: OutlineInputBorder(),
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
              Row(
                children: [
                  // Кнопка Отмена
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // Просто возвращаемся назад без сохранения
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(0, 50),
                      ),
                      child: Text('Отмена'),
                    ),
                  ),
                  SizedBox(width: 16),
                  // Кнопка Записаться
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(0, 50),
                      ),
                      child: Text('Записаться'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_selectedDoctor == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Пожалуйста, выберите врача')),
        );
        return;
      }

      final doctor = _availableDoctors[_selectedDoctor!]!;
      final newAppointment = Appointment(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        doctorName: _selectedDoctor!,
        specialty: doctor.specialty,
        date: _selectedDate,
        time: _selectedTime,
        imageUrl: doctor.imageUrl,
      );

      widget.onAddAppointment(newAppointment);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Запись к $_selectedDoctor успешно создана!')),
      );

      _formKey.currentState!.reset();
      setState(() {
        _selectedDoctor = null;
        _selectedDate = '';
        _selectedTime = '';
      });

      // Возврат к списку записей после успешного создания
      Navigator.pop(context);
    }
  }
}