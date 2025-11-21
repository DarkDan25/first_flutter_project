import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:first_flutter_project/models/appointment.dart';

part 'current_appointments_event.dart';
part 'current_appointments_state.dart';

class CurrentAppointmentsBloc extends Bloc<CurrentAppointmentsEvent, CurrentAppointmentsState> {
  CurrentAppointmentsBloc() : super(CurrentAppointmentsInitial()) {
    on<LoadCurrentAppointments>(_onLoadCurrentAppointments);
    on<CancelAppointment>(_onCancelAppointment);
    on<CompleteAppointment>(_onCompleteAppointment);
    on<AddAppointment>(_onAddAppointment);
  }

  void _onLoadCurrentAppointments(LoadCurrentAppointments event, Emitter<CurrentAppointmentsState> emit) {
    emit(CurrentAppointmentsLoaded(_currentAppointments));
  }

  void _onCancelAppointment(CancelAppointment event, Emitter<CurrentAppointmentsState> emit) {
    _currentAppointments = _currentAppointments.where((appointment) => appointment.id != event.appointmentId).toList();
    emit(CurrentAppointmentsLoaded(_currentAppointments));
  }

  void _onCompleteAppointment(CompleteAppointment event, Emitter<CurrentAppointmentsState> emit) {
    final appointment = _currentAppointments.firstWhere((appt) => appt.id == event.appointmentId);
    _currentAppointments = _currentAppointments.where((appt) => appt.id != event.appointmentId).toList();
    // Здесь можно отправить событие в HistoryBloc для добавления в историю
    emit(CurrentAppointmentsLoaded(_currentAppointments));
  }
  void _onAddAppointment(AddAppointment event, Emitter<CurrentAppointmentsState> emit) {
    _currentAppointments = [..._currentAppointments, event.appointment];
    emit(CurrentAppointmentsLoaded(_currentAppointments));
  }

  List<Appointment> _currentAppointments = [];
}