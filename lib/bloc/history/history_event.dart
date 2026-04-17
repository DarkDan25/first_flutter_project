part of 'history_bloc.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

class LoadHistory extends HistoryEvent {
  final String role;
  final int userId;

  const LoadHistory({required this.role, required this.userId});

  @override
  List<Object> get props => [role, userId];
}

class AddToHistory extends HistoryEvent {
  final Appointment appointment;

  const AddToHistory(this.appointment);

  @override
  List<Object> get props => [appointment];
}