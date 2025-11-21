import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:first_flutter_project/models/appointment.dart';
import 'package:first_flutter_project/data/doctors_data.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(HistoryInitial()) {
    on<LoadHistory>(_onLoadHistory);
    on<AddToHistory>(_onAddToHistory);
  }

  void _onLoadHistory(LoadHistory event, Emitter<HistoryState> emit) {
    emit(HistoryLoaded(_historyAppointments));
  }

  void _onAddToHistory(AddToHistory event, Emitter<HistoryState> emit) {
    _historyAppointments = [..._historyAppointments, event.appointment];
    emit(HistoryLoaded(_historyAppointments));
  }

  List<Appointment> _historyAppointments = [];
}