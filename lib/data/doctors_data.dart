import '../models/doctor.dart';

class DoctorsData {
  static final List<Doctor> doctors = [
    Doctor(
      name: 'Иванов И.И.',
      specialty: 'Кардиолог',
      imageUrl: 'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=150&h=150&fit=crop&crop=face',
      localAsset: 'assets/images/cardiologist.png',
    ),
    Doctor(
      name: 'Петрова А.Д.',
      specialty: 'Невролог',
      imageUrl: 'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=150&h=150&fit=crop&crop=face',
      localAsset: 'assets/images/neurologist.png',
    ),
    Doctor(
      name: 'Сидоров Е.В.',
      specialty: 'Терапевт',
      imageUrl: 'https://images.unsplash.com/photo-1582750433449-648ed127bb54?w=150&h=150&fit=crop&crop=face',
      localAsset: 'assets/images/therapist.png',
    ),
    Doctor(
      name: 'Кузнецова К.Н.',
      specialty: 'Стоматолог',
      imageUrl: 'https://images.unsplash.com/photo-1622253692010-333f2da6031d?w=150&h=150&fit=crop&crop=face',
      localAsset: 'assets/images/dentist.png',
    ),
    Doctor(
      name: 'Кузин О.М.',
      specialty: 'Хирург',
      imageUrl: 'https://images.unsplash.com/photo-1537368910025-700350fe46c7?w=150&h=150&fit=crop&crop=face',
      localAsset: 'assets/images/surgeon.png',
    ),
  ];

  static Doctor getDoctorByName(String name) {
    return doctors.firstWhere((doctor) => doctor.name == name,
        orElse: () => doctors.first);
  }
}