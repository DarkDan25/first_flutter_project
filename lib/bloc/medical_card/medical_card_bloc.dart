import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:first_flutter_project/models/appointment.dart';

part 'medical_card_event.dart';
part 'medical_card_state.dart';

class MedicalCardBloc extends Bloc<MedicalCardEvent, MedicalCardState> {
  MedicalCardBloc() : super(MedicalCardInitial()) {
    on<LoadMedicalCard>(_onLoadMedicalCard);
    on<UpdateAppointmentsInfo>(_onUpdateAppointmentsInfo);
  }

  void _onLoadMedicalCard(LoadMedicalCard event, Emitter<MedicalCardState> emit) {
    emit(MedicalCardLoaded(
      medCardId: '09876544321',
      patientName: 'Павлов Д.Е.',
      age: '30 лет',
      bloodType: 'A(II) Rh+',
      allergies: 'Пыльца, антибиотики',
      chronicDiseases: 'Бронхиальная астма (легкая форма)',
      notes: 'Пациент регулярно проходит профилактические осмотры.',
      lastAppointment: null,
      nextAppointment: null,
    ));
  }

  void _onUpdateAppointmentsInfo(UpdateAppointmentsInfo event, Emitter<MedicalCardState> emit) {
    if (state is MedicalCardLoaded) {
      final currentState = state as MedicalCardLoaded;
      emit(MedicalCardLoaded(
        medCardId: currentState.medCardId,
        patientName: currentState.patientName,
        age: currentState.age,
        bloodType: currentState.bloodType,
        allergies: currentState.allergies,
        chronicDiseases: currentState.chronicDiseases,
        notes: currentState.notes,
        lastAppointment: event.lastAppointment,
        nextAppointment: event.nextAppointment,
      ));
    }
  }
}