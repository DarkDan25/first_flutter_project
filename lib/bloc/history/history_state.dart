part of 'history_bloc.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object> get props => [];
}

class HistoryInitial extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<Appointment> appointments;

  const HistoryLoaded(this.appointments);

  @override
  List<Object> get props => [appointments];
}