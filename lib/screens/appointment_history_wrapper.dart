import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'appointment_history_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:first_flutter_project/bloc/history/history_bloc.dart';


class AppointmentHistoryWrapper extends StatelessWidget {
  const AppointmentHistoryWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<HistoryBloc, HistoryState>(
          builder: (context, state) {
            int count = 0;
            if (state is HistoryLoaded) {
              count = state.appointments.length;
            }
            return Text('История записей ($count)');
          },
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          if (state is HistoryLoaded) {
            return AppointmentHistoryScreen(historyAppointments: state.appointments);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}