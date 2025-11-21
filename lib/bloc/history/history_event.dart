part of 'history_bloc.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

class LoadHistory extends HistoryEvent {}

class AddToHistory extends HistoryEvent {
  final Appointment appointment;

  const AddToHistory(this.appointment);

  @override
  List<Object> get props => [appointment];
}