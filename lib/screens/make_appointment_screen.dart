import 'package:flutter/material.dart';
import 'package:first_flutter_project/models/appointment.dart';

class MakeAppointmentScreen extends StatefulWidget {
  final Function(Appointment) onAddAppointment;

  const MakeAppointmentScreen({Key? key, required this.onAddAppointment}) : super(key: key);

  @override
  _MakeAppointmentScreenState createState() => _MakeAppointmentScreenState();
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
                items: _doctorSpecialties.keys
                    .map((doctor) => DropdownMenuItem(
                  value: doctor,
                  child: Text('$doctor - ${_doctorSpecialties[doctor]}'),
                ))
                    .toList(),
                onChanged: (value) => setState(() => _selectedDoctor = value!),
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
      final newAppointment = Appointment(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        doctorName: _selectedDoctor,
        specialty: _doctorSpecialties[_selectedDoctor] ?? 'Врач',
        date: _selectedDate,
        time: _selectedTime,
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