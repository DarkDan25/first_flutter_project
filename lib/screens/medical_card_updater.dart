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
          listener: (context, state) {
            if (state is CurrentAppointmentsLoaded) {
              final nextAppointment = _findNextAppointment(state.appointments);
              context.read<MedicalCardBloc>().add(UpdateAppointmentsInfo(
                nextAppointment: nextAppointment,
              ));
            }
          },
        ),
        BlocListener<HistoryBloc, HistoryState>(
          listener: (context, state) {
            if (state is HistoryLoaded) {
              final lastAppointment = _findLastAppointment(state.appointments);
              context.read<MedicalCardBloc>().add(UpdateAppointmentsInfo(
                lastAppointment: lastAppointment,
              ));
            }
          },
        ),
      ],
      child: child,
    );
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