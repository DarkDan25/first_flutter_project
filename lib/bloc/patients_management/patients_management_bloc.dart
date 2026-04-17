import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:first_flutter_project/models/patient.dart';
import 'package:first_flutter_project/services/api_service.dart';

part 'patients_management_event.dart';
part 'patients_management_state.dart';

class PatientsManagementBloc extends Bloc<PatientsManagementEvent, PatientsManagementState> {
  PatientsManagementBloc() : super(PatientsManagementInitial()) {
    on<LoadPatients>(_onLoadPatients);
    on<UpdatePatient>(_onUpdatePatient);
    on<DeletePatient>(_onDeletePatient);
  }

  Future<void> _onLoadPatients(LoadPatients event, Emitter<PatientsManagementState> emit) async {
    emit(PatientsLoading());
    try {
      final patients = await ApiService.getPatients();
      emit(PatientsLoaded(patients: patients));
    } catch (e) {
      emit(PatientsError(message: e.toString()));
    }
  }

  Future<void> _onUpdatePatient(UpdatePatient event, Emitter<PatientsManagementState> emit) async {
    try {
      await ApiService.updatePatient(event.patient.id!, event.patient);
      add(LoadPatients());
    } catch (e) {
      emit(PatientsError(message: e.toString()));
    }
  }

  Future<void> _onDeletePatient(DeletePatient event, Emitter<PatientsManagementState> emit) async {
    try {
      await ApiService.deletePatient(event.id);
      add(LoadPatients());
    } catch (e) {
      emit(PatientsError(message: e.toString()));
    }
  }
}
