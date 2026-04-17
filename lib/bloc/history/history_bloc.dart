import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:first_flutter_project/models/appointment.dart';
import 'package:first_flutter_project/services/api_service.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc() : super(HistoryInitial()) {
    on<LoadHistory>(_onLoadHistory);
    on<AddToHistory>(_onAddToHistory);
  }

  List<Appointment> _historyAppointments = [];

  Future<void> _onLoadHistory(LoadHistory event, Emitter<HistoryState> emit) async {
    try {
      final allAppointments = await ApiService.getAppointments();
      _historyAppointments = allAppointments.where((a) => a.status == 'Завершено' || a.status == 'Отменено').toList();
      emit(HistoryLoaded(_historyAppointments));
    } catch (e) {
      emit(const HistoryLoaded([]));
    }
  }

  void _onAddToHistory(AddToHistory event, Emitter<HistoryState> emit) {
    _historyAppointments = [..._historyAppointments, event.appointment];
    emit(HistoryLoaded(_historyAppointments));
  }
}
