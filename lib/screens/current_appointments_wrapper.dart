import 'package:flutter/material.dart';
import 'package:first_flutter_project/screens/current_appointments_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:first_flutter_project/bloc/current_appointments/current_appointments_bloc.dart';
import 'package:first_flutter_project/bloc/history/history_bloc.dart';
import 'package:first_flutter_project/bloc/make_appointment/make_appointment_bloc.dart';

class CurrentAppointmentsWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<MakeAppointmentBloc, MakeAppointmentState>(
      listener: (context, state) {
        if (state is AppointmentSubmitted) {
          context.read<CurrentAppointmentsBloc>().add(AddAppointment(state.appointment));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Текущие записи'),
          actions: [
            IconButton(
              icon: Icon(Icons.info),
              onPressed: () {
                context.push('/clinic_info');
              },
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                context.push('/profile');
              },
            ),
          ],
        ),
        body: BlocBuilder<CurrentAppointmentsBloc, CurrentAppointmentsState>(
          builder: (context, state) {
            if (state is CurrentAppointmentsLoaded) {
              return CurrentAppointmentsScreen(
                appointments: state.appointments,
                onCancelAppointment: (appointmentId) {
                  context.read<CurrentAppointmentsBloc>().add(CancelAppointment(appointmentId));
                },
                onCompleteAppointment: (appointmentId) {
                  final appointment = state.appointments.firstWhere((appt) => appt.id == appointmentId);
                  context.read<CurrentAppointmentsBloc>().add(CompleteAppointment(appointmentId));
                  context.read<HistoryBloc>().add(AddToHistory(appointment));
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.push('/make');
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}