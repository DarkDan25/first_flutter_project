import 'package:get_it/get_it.dart';
import 'services/app_state_service.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<AppStateService>(() => AppStateService());
}