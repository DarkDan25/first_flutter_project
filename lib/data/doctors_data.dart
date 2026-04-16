import 'package:first_flutter_project/models/doctor.dart';

class DoctorsData {
  static final List<Doctor> doctors = [
    Doctor(
      name: 'Иванов И.И.',
      specialty: 'Кардиолог',
    ),
    Doctor(
      name: 'Петрова А.Д.',
      specialty: 'Невролог',
    ),
    Doctor(
      name: 'Сидоров Е.В.',
      specialty: 'Терапевт',
    ),
    Doctor(
      name: 'Кузнецова К.Н.',
      specialty: 'Стоматолог',
    ),
    Doctor(
      name: 'Кузин О.М.',
      specialty: 'Хирург',
    ),
  ];

  static Doctor getDoctorByName(String name) {
    return doctors.firstWhere((doctor) => doctor.name == name,
        orElse: () => doctors.first);
  }
}