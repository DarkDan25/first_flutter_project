import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:first_flutter_project/models/appointment.dart';
import 'package:first_flutter_project/data/doctors_data.dart';

part 'make_appointment_event.dart';
part 'make_appointment_state.dart';

class MakeAppointmentBloc extends Bloc<MakeAppointmentEvent, MakeAppointmentState> {
  MakeAppointmentBloc() : super(MakeAppointmentInitial()) {
    on<SubmitAppointment>(_onSubmitAppointment);
  }

  void _onSubmitAppointment(SubmitAppointment event, Emitter<MakeAppointmentState> emit) {
    final newAppointment = Appointment(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      doctorName: event.doctorName,
      specialty: event.specialty,
      date: event.date,
      time: event.time,
      imageUrl: event.imageUrl,
    );

    emit(AppointmentSubmitted(newAppointment));
  }
}