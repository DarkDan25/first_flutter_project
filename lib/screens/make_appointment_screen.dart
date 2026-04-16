import 'package:flutter/material.dart';
import 'package:first_flutter_project/models/doctor.dart';
import 'package:go_router/go_router.dart';
import 'package:first_flutter_project/bloc/make_appointment/make_appointment_bloc.dart';
import 'package:first_flutter_project/bloc/doctors_management/doctors_management_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MakeAppointmentScreen extends StatefulWidget {
  const MakeAppointmentScreen({super.key});

  @override
  State<MakeAppointmentScreen> createState() => _MakeAppointmentScreenState();
}

class _MakeAppointmentScreenState extends State<MakeAppointmentScreen> {
  final _formKey = GlobalKey<FormState>();
  Doctor? _selectedDoctor;
  String _selectedDate = '';
  String _selectedTime = '';

  @override
  void initState() {
    super.initState();
    context.read<DoctorsManagementBloc>().add(LoadDoctors());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MakeAppointmentBloc, MakeAppointmentState>(
      listener: (context, state) {
        if (state is AppointmentSubmitted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Запись к ${_selectedDoctor?.fullName} успешно создана!')),
          );
          context.pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Запись к врачу'),
          automaticallyImplyLeading: false,
        ),
        body: BlocBuilder<DoctorsManagementBloc, DoctorsManagementState>(
          builder: (context, state) {
            if (state is! DoctorsLoaded) {
              return const Center(child: CircularProgressIndicator());
            }

            final availableDoctors = state.doctors;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    DropdownButtonFormField<Doctor>(
                      value: _selectedDoctor,
                      items: availableDoctors.map((doctor) {
                        return DropdownMenuItem(
                          value: doctor,
                          child: Text('${doctor.fullName} - ${doctor.specialty}'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() => _selectedDoctor = value);
                      },
                      decoration: const InputDecoration(
                        labelText: 'Выберите врача',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null) {
                          return 'Выберите врача';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Дата (гггг-мм-дд)',
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
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: const InputDecoration(
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
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              context.pop();
                            },
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size(0, 50),
                            ),
                            child: const Text('Отмена'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _submitForm,
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(0, 50),
                            ),
                            child: const Text('Записаться'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_selectedDoctor == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Пожалуйста, выберите врача')),
        );
        return;
      }
      
      context.read<MakeAppointmentBloc>().add(SubmitAppointment(
        doctor: _selectedDoctor!,
        date: '$_selectedDate $_selectedTime',
      ));

      _formKey.currentState!.reset();
      setState(() {
        _selectedDoctor = null;
        _selectedDate = '';
        _selectedTime = '';
      });
    }
  }
}
