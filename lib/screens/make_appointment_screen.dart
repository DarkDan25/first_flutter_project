import 'package:flutter/material.dart';
import 'package:first_flutter_project/models/doctor.dart';
import 'package:go_router/go_router.dart';
import 'package:first_flutter_project/bloc/make_appointment/make_appointment_bloc.dart';
import 'package:first_flutter_project/bloc/doctors_management/doctors_management_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:first_flutter_project/bloc/login/login_bloc.dart';
import 'package:first_flutter_project/models/patient.dart';
import 'package:intl/intl.dart';

class MakeAppointmentScreen extends StatefulWidget {
  const MakeAppointmentScreen({super.key});

  @override
  State<MakeAppointmentScreen> createState() => _MakeAppointmentScreenState();
}

class _MakeAppointmentScreenState extends State<MakeAppointmentScreen> {
  final _formKey = GlobalKey<FormState>();
  Doctor? _selectedDoctor;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<DoctorsManagementBloc>().add(LoadDoctors());
  }

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      useRootNavigator: true,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      locale: const Locale('ru', 'RU'),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        final now = DateTime.now();
        final dt = DateTime(now.year, now.month, now.day, picked.hour, picked.minute);
        _timeController.text = DateFormat('HH:mm').format(dt);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MakeAppointmentBloc, MakeAppointmentState>(
      listener: (context, state) {
        if (state is AppointmentSubmitted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Запись к ${_selectedDoctor?.fullName} успешно создана!')),
          );
          _clearForm();
          context.pop();
        } else if (state is MakeAppointmentFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Ошибка: ${state.error}'), backgroundColor: Colors.red),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Запись к врачу'),
          automaticallyImplyLeading: false,
        ),
        body: BlocBuilder<DoctorsManagementBloc, DoctorsManagementState>(
          builder: (context, doctorsState) {
            if (doctorsState is! DoctorsLoaded) {
              return const Center(child: CircularProgressIndicator());
            }

            final availableDoctors = doctorsState.doctors;

            return BlocBuilder<MakeAppointmentBloc, MakeAppointmentState>(
              builder: (context, appointmentState) {
                final isLoading = appointmentState is MakeAppointmentLoading;

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
                          onChanged: isLoading ? null : (value) {
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
                          controller: _dateController,
                          readOnly: true,
                          onTap: isLoading ? null : () => _selectDate(context),
                          decoration: const InputDecoration(
                            labelText: 'Дата',
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Выберите дату';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _timeController,
                          readOnly: true,
                          onTap: isLoading ? null : () => _selectTime(context),
                          decoration: const InputDecoration(
                            labelText: 'Время',
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.access_time),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Выберите время';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: isLoading ? null : () {
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
                                onPressed: isLoading ? null : _submitForm,
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(0, 50),
                                ),
                                child: isLoading 
                                  ? const SizedBox(
                                      width: 20, 
                                      height: 20, 
                                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)
                                    )
                                  : const Text('Записаться'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _clearForm() {
    _formKey.currentState?.reset();
    setState(() {
      _selectedDoctor = null;
      _selectedDate = null;
      _selectedTime = null;
      _dateController.clear();
      _timeController.clear();
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_selectedDoctor == null || _selectedDate == null || _selectedTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Пожалуйста, заполните все поля')),
        );
        return;
      }
      
      final fullDateTime = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );

      final loginState = context.read<LoginBloc>().state;
      if (loginState is! LoginSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ошибка авторизации')),
        );
        return;
      }

      final patient = Patient.fromJson(loginState.userData);

      context.read<MakeAppointmentBloc>().add(SubmitAppointment(
        doctor: _selectedDoctor!,
        patient: patient,
        date: DateFormat("yyyy-MM-dd").format(fullDateTime),
        time: DateFormat("HH:mm").format(fullDateTime),
      ));
    }
  }
}
