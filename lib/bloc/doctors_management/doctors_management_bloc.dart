import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:first_flutter_project/models/doctor.dart';
import 'package:first_flutter_project/data/doctors_data.dart';

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

  void _onLoadDoctors(LoadDoctors event, Emitter<DoctorsManagementState> emit) {
    _doctors = List.from(DoctorsData.doctors);
    emit(DoctorsLoaded(_doctors));
  }

  void _onAddDoctor(AddDoctor event, Emitter<DoctorsManagementState> emit) {
    _doctors = [..._doctors, event.doctor];

    DoctorsData.doctors.add(event.doctor);

    emit(DoctorsLoaded(List.from(_doctors)));
  }

  void _onUpdateDoctor(UpdateDoctor event, Emitter<DoctorsManagementState> emit) {
    final index = _doctors.indexWhere((d) => d.name == event.oldDoctor.name);
    if (index != -1) {
      final newDoctors = List<Doctor>.from(_doctors);
      newDoctors[index] = event.newDoctor;
      _doctors = newDoctors;

      final staticIndex = DoctorsData.doctors.indexWhere((d) => d.name == event.oldDoctor.name);
      if (staticIndex != -1) {
        DoctorsData.doctors[staticIndex] = event.newDoctor;
      }
    }
    emit(DoctorsLoaded(List.from(_doctors)));
  }

  void _onDeleteDoctor(DeleteDoctor event, Emitter<DoctorsManagementState> emit) {
    _doctors = _doctors.where((doctor) => doctor.name != event.doctorName).toList();

    DoctorsData.doctors.removeWhere((doctor) => doctor.name == event.doctorName);

    emit(DoctorsLoaded(List.from(_doctors)));
  }
}