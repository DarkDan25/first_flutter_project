import 'package:first_flutter_project/models/doctor.dart';

class DoctorsData {
  static final List<Doctor> doctors = [
    Doctor(
      name: 'Иванов И.И.',
      specialty: 'Кардиолог',
      imageUrl: 'https://th.bing.com/th/id/R.9dae0eedbe8906edc82842714e98f5d0?rik=9M7OqrjRzNNKUQ&riu=http%3a%2f%2fstatic.wixstatic.com%2fmedia%2f095632_461ab111988a4121b8e53331070b67d4~mv2.jpg&ehk=HwAXIIkghyQUyz0GN9Pv5eOmGc0w04l9tOERr%2bYxIqM%3d&risl=&pid=ImgRaw&r=0',
    ),
    Doctor(
      name: 'Петрова А.Д.',
      specialty: 'Невролог',
      imageUrl: 'https://th.bing.com/th/id/R.a286f386db62bda990679447651a2e26?rik=l%2focmVKfl%2fc2ew&riu=http%3a%2f%2fstatic.scientificamerican.com%2fsciam%2fcache%2ffile%2fF6FF3DF2-A99D-4BE0-99595C9E4717FEF4_source.jpg&ehk=QCq1Bg063T1WlmT7fmxnFeL6dMWGlM56jqjUhs2fvkg%3d&risl=&pid=ImgRaw&r=0',
    ),
    Doctor(
      name: 'Сидоров Е.В.',
      specialty: 'Терапевт',
      imageUrl: 'https://th.bing.com/th/id/R.6313a0b7f4b9d06b42a864b3eabddf86?rik=Jy6Bm2vQiamdtw&riu=http%3a%2f%2ffactinate.com%2fwp-content%2fuploads%2f2019%2f01%2fshutterstock_718159351.jpg&ehk=ypmvIyzfCR4PJTukwWsWnwhEFewIONfv5l9A3ZkPcV8%3d&risl=&pid=ImgRaw&r=0',
    ),
    Doctor(
      name: 'Кузнецова К.Н.',
      specialty: 'Стоматолог',
      imageUrl: 'https://cdnn21.img.ria.ru/images/07e7/04/18/1867278481_185:24:789:628_1920x0_80_0_0_4e0a087eda1ddddedee0ca48772748c8.jpg',
    ),
    Doctor(
      name: 'Кузин О.М.',
      specialty: 'Хирург',
      imageUrl: 'https://tse4.mm.bing.net/th/id/OIP.ncZkfwsLevJF1Lq69gKsSAHaE8?w=1023&h=682&rs=1&pid=ImgDetMain&o=7&rm=3',
    ),
  ];

  static Doctor getDoctorByName(String name) {
    return doctors.firstWhere((doctor) => doctor.name == name,
        orElse: () => doctors.first);
  }
}