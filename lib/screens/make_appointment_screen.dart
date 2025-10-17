import 'package:flutter/material.dart';

class MakeAppointmentScreen extends StatefulWidget {
  @override
  _MakeAppointmentScreenState createState() => _MakeAppointmentScreenState();
}

class _MakeAppointmentScreenState extends State<MakeAppointmentScreen> {
  final _formKey = GlobalKey<FormState>();
  String _selectedDoctor = '';
  String _selectedDate = '';
  String _selectedTime = '';

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
              DropdownButtonFormField(
                items: ['Др. Иванов', 'Др. Петрова', 'Др. Сидоров']
                    .map((doctor) => DropdownMenuItem(
                  value: doctor,
                  child: Text(doctor),
                ))
                    .toList(),
                onChanged: (value) => setState(() => _selectedDoctor = value!),
                decoration: InputDecoration(labelText: 'Выберите врача'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Дата (дд.мм.гггг)'),
                onChanged: (value) => _selectedDate = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Время (чч:мм)'),
                onChanged: (value) => _selectedTime = value,
              ),
              SizedBox(height: 20),
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
      // Логика сохранения записи
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Запись успешно создана!')),
      );
    }
  }
}