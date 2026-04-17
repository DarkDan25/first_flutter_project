import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:first_flutter_project/models/doctor.dart';
import 'package:first_flutter_project/services/api_service.dart';

part 'doctors_management_event.dart';
part 'doctors_management_state.dart';

class DoctorsManagementBloc extends Bloc<DoctorsManagementEvent, DoctorsManagementState> {
  DoctorsManagementBloc() : super(DoctorsManagementInitial()) {
    on<LoadDoctors>(_onLoadDoctors);
    on<AddDoctor>(_onAddDoctor);
    on<UpdateDoctor>(_onUpdateDoctor);
    on<DeleteDoctor>(_onDeleteDoctor);
  }

  List<Doctor> _doctors = [];

  Future<void> _onLoadDoctors(LoadDoctors event, Emitter<DoctorsManagementState> emit) async {
    try {
      _doctors = await ApiService.getDoctors();
      emit(DoctorsLoaded(_doctors));
    } catch (e) {
      // For simplicity, just emit empty list or handle error
      emit(const DoctorsLoaded([]));
    }
  }

  Future<void> _onAddDoctor(AddDoctor event, Emitter<DoctorsManagementState> emit) async {
    try {
      final newDoctor = await ApiService.addDoctor(event.doctor);
      _doctors = [..._doctors, newDoctor];
      emit(DoctorsLoaded(List.from(_doctors)));
    } catch (e) {
      // Handle error
    }
  }

  Future<void> _onUpdateDoctor(UpdateDoctor event, Emitter<DoctorsManagementState> emit) async {
    try {
      if (event.doctor.id != null) {
        final updatedDoctor = await ApiService.updateDoctor(event.doctor.id!, event.doctor);
        final index = _doctors.indexWhere((d) => d.id == event.doctor.id);
        if (index != -1) {
          _doctors[index] = updatedDoctor;
          emit(DoctorsLoaded(List.from(_doctors)));
        }
      }
    } catch (e) {
      // Handle error
    }
  }

  Future<void> _onDeleteDoctor(DeleteDoctor event, Emitter<DoctorsManagementState> emit) async {
    try {
      await ApiService.deleteDoctor(event.doctorId);
      _doctors = _doctors.where((doctor) => doctor.id != event.doctorId).toList();
      emit(DoctorsLoaded(List.from(_doctors)));
    } catch (e) {
      // Handle error
    }
  }
}
