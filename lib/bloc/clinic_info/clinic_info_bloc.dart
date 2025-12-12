import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'clinic_info_event.dart';
part 'clinic_info_state.dart';

class ClinicInfoBloc extends Bloc<ClinicInfoEvent, ClinicInfoState> {
  ClinicInfoBloc() : super(ClinicInfoInitial()) {
    on<LoadClinicInfo>(_onLoadClinicInfo);
  }

  void _onLoadClinicInfo(LoadClinicInfo event, Emitter<ClinicInfoState> emit) {
    emit(ClinicInfoLoaded(
      name: 'Клиника "Healthy bird"',
      address: 'г. Москва, проспект Вернадского, 78',
      phone: '+7 (495) 123-45-67',
      email: 'healthybird@clinic.ru',
      workingHours: 'Пн-Пт: 8:00-20:00, Сб-Вс: 9:00-18:00',
      description: 'Современный медицинский центр с широким спектром услуг. '
          'Высококвалифицированные врачи, современное оборудование, '
          'индивидуальный подход к каждому пациенту.',
    ));
  }
}