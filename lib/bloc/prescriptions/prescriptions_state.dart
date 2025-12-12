part of 'prescriptions_bloc.dart';

abstract class PrescriptionsState extends Equatable {
  const PrescriptionsState();

  @override
  List<Object> get props => [];
}

class PrescriptionsInitial extends PrescriptionsState {}

class PrescriptionsLoaded extends PrescriptionsState {
  final List<Prescription> prescriptions;

  const PrescriptionsLoaded(this.prescriptions);

  @override
  List<Object> get props => [prescriptions];
}