import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:first_flutter_project/models/prescription.dart';

part 'prescriptions_event.dart';
part 'prescriptions_state.dart';

class PrescriptionsBloc extends Bloc<PrescriptionsEvent, PrescriptionsState> {
  PrescriptionsBloc() : super(PrescriptionsInitial()) {
    on<LoadPrescriptions>(_onLoadPrescriptions);
  }

  void _onLoadPrescriptions(LoadPrescriptions event, Emitter<PrescriptionsState> emit) {
    // Здесь можно загружать данные из API, но пока используем фиксированные данные
    emit(PrescriptionsLoaded([
      Prescription(
        id: '1',
        medicationName: 'Сальбутамол',
        dosage: '100 мкг',
        frequency: '2 раза в день',
        duration: '30 дней',
        doctorName: 'Иванов И.И.',
        date: '01.12.2025',
        instructions: 'Ингаляционно, за 15 минут до физической нагрузки',
      ),
      Prescription(
        id: '2',
        medicationName: 'Лоратадин',
        dosage: '10 мг',
        frequency: '1 раз в день',
        duration: '14 дней',
        doctorName: 'Петрова А.Д.',
        date: '13.10.2025',
        instructions: 'Принимать вечером, независимо от приема пищи',
      ),
      Prescription(
        id: '3',
        medicationName: 'Ибупрофен',
        dosage: '200 мг',
        frequency: '3 раза в день после еды',
        duration: '7 дней',
        doctorName: 'Сидоров Е.В.',
        date: '9.11.2025',
        instructions: 'Принимать после еды, не более 3 таблеток в сутки',
      ),
    ]));
  }
}