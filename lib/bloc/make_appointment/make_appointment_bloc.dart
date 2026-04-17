import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:first_flutter_project/models/appointment.dart';
import 'package:first_flutter_project/models/doctor.dart';
import 'package:first_flutter_project/services/api_service.dart';

import '../../models/patient.dart';

part 'make_appointment_event.dart';
part 'make_appointment_state.dart';

class MakeAppointmentBloc extends Bloc<MakeAppointmentEvent, MakeAppointmentState> {
  MakeAppointmentBloc() : super(MakeAppointmentInitial()) {
    on<SubmitAppointment>(_onSubmitAppointment);
  }

  Future<void> _onSubmitAppointment(SubmitAppointment event, Emitter<MakeAppointmentState> emit) async {
    emit(MakeAppointmentLoading());
    try {
      final newAppointment = Appointment(
        doctor: event.doctor,
        patient: event.patient,
        date: event.date,
        time: event.time,
        status: 'Ожидается',
      );

      final savedAppointment = await ApiService.addAppointment(newAppointment);
      emit(AppointmentSubmitted(savedAppointment));
    } catch (e) {
      emit(MakeAppointmentFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }
}
