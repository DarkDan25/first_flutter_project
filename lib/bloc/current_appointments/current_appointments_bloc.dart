import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:first_flutter_project/models/appointment.dart';
import 'package:first_flutter_project/services/api_service.dart';

part 'current_appointments_event.dart';
part 'current_appointments_state.dart';

class CurrentAppointmentsBloc extends Bloc<CurrentAppointmentsEvent, CurrentAppointmentsState> {
  CurrentAppointmentsBloc() : super(CurrentAppointmentsInitial()) {
    on<LoadCurrentAppointments>(_onLoadCurrentAppointments);
    on<CancelAppointment>(_onCancelAppointment);
    on<CompleteAppointment>(_onCompleteAppointment);
    on<AddAppointment>(_onAddAppointment);
  }

  List<Appointment> _currentAppointments = [];

  Future<void> _onLoadCurrentAppointments(LoadCurrentAppointments event, Emitter<CurrentAppointmentsState> emit) async {
    try {
      _currentAppointments = await ApiService.getAppointments();
      // Filter for current appointments (status: Ожидается)
      _currentAppointments = _currentAppointments.where((a) => a.status == 'Ожидается').toList();
      emit(CurrentAppointmentsLoaded(_currentAppointments));
    } catch (e) {
      emit(const CurrentAppointmentsLoaded([]));
    }
  }

  Future<void> _onCancelAppointment(CancelAppointment event, Emitter<CurrentAppointmentsState> emit) async {
    try {
      await ApiService.updateAppointment(event.appointmentId, 'Отменено');
      _currentAppointments = _currentAppointments.where((appointment) => appointment.id != event.appointmentId).toList();
      emit(CurrentAppointmentsLoaded(_currentAppointments));
    } catch (e) {
      // Keep existing state or emit error
    }
  }

  Future<void> _onCompleteAppointment(CompleteAppointment event, Emitter<CurrentAppointmentsState> emit) async {
    try {
      await ApiService.updateAppointment(event.appointmentId, 'Завершено');
      _currentAppointments = _currentAppointments.where((appt) => appt.id != event.appointmentId).toList();
      emit(CurrentAppointmentsLoaded(_currentAppointments));
    } catch (e) {
      // Keep existing state or emit error
    }
  }

  void _onAddAppointment(AddAppointment event, Emitter<CurrentAppointmentsState> emit) {
    _currentAppointments = [..._currentAppointments, event.appointment];
    emit(CurrentAppointmentsLoaded(_currentAppointments));
  }
}
