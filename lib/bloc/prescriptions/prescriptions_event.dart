part of 'prescriptions_bloc.dart';

abstract class PrescriptionsEvent extends Equatable {
  const PrescriptionsEvent();

  @override
  List<Object> get props => [];
}

class LoadPrescriptions extends PrescriptionsEvent {}