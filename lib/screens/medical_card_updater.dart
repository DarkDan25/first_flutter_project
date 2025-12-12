import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:first_flutter_project/bloc/current_appointments/current_appointments_bloc.dart';
import 'package:first_flutter_project/bloc/history/history_bloc.dart';
import 'package:first_flutter_project/bloc/medical_card/medical_card_bloc.dart';
import 'package:first_flutter_project/models/appointment.dart';

class MedicalCardUpdater extends StatelessWidget {
  final Widget child;

  const MedicalCardUpdater({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CurrentAppointmentsBloc, CurrentAppointmentsState>(
          listener: (context, currentState) {
            if (currentState is CurrentAppointmentsLoaded) {
              _updateAppointmentsFromCurrent(context, currentState);
            }
          },
        ),
        BlocListener<HistoryBloc, HistoryState>(
          listener: (context, historyState) {
            if (historyState is HistoryLoaded) {
              _updateAppointmentsFromHistory(context, historyState);
            }
          },
        ),
      ],
      child: child,
    );
  }

  void _updateAppointmentsFromCurrent(BuildContext context, CurrentAppointmentsLoaded currentState) {
    final historyState = context.read<HistoryBloc>().state;
    Appointment? lastAppointment;
    Appointment? nextAppointment;

    if (currentState.appointments.isNotEmpty) {
      nextAppointment = _findNextAppointment(currentState.appointments);
    }

    if (historyState is HistoryLoaded && historyState.appointments.isNotEmpty) {
      lastAppointment = _findLastAppointment(historyState.appointments);
    }

    context.read<MedicalCardBloc>().add(UpdateAppointmentsInfo(
      lastAppointment: lastAppointment,
      nextAppointment: nextAppointment,
    ));
  }

  void _updateAppointmentsFromHistory(BuildContext context, HistoryLoaded historyState) {
    final currentState = context.read<CurrentAppointmentsBloc>().state;
    Appointment? lastAppointment;
    Appointment? nextAppointment;

    if (historyState.appointments.isNotEmpty) {
      lastAppointment = _findLastAppointment(historyState.appointments);
    }

    if (currentState is CurrentAppointmentsLoaded && currentState.appointments.isNotEmpty) {
      nextAppointment = _findNextAppointment(currentState.appointments);
    }

    context.read<MedicalCardBloc>().add(UpdateAppointmentsInfo(
      lastAppointment: lastAppointment,
      nextAppointment: nextAppointment,
    ));
  }

  Appointment? _findNextAppointment(List<Appointment> appointments) {
    if (appointments.isEmpty) return null;

    return appointments.first;
  }

  Appointment? _findLastAppointment(List<Appointment> appointments) {
    if (appointments.isEmpty) return null;

    return appointments.last;
  }
}