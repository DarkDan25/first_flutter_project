import 'package:first_flutter_project/screens/clinic_info_screen.dart';
import 'package:first_flutter_project/screens/doctors_management_screen.dart';
import 'package:first_flutter_project/screens/registration_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:first_flutter_project/screens/login_screen.dart';
import 'package:first_flutter_project/screens/home_screen.dart';
import 'package:first_flutter_project/screens/make_appointment_screen.dart';
import 'package:first_flutter_project/screens/profile_screen.dart';
import 'package:first_flutter_project/screens/appointment_history_wrapper.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => LoginScreen(key: state.pageKey),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => RegistrationScreen(key: state.pageKey),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => HomeScreen(key: state.pageKey),
      ),
      GoRoute(
        path: '/current',
        builder: (context, state) => HomeScreen(key: state.pageKey),
      ),
      GoRoute(
        path: '/make',
        builder: (context, state) => MakeAppointmentScreen(key: state.pageKey),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => ProfileScreen(key: state.pageKey),
      ),
      GoRoute(
        path: '/history',
        builder: (context, state) => AppointmentHistoryWrapper(key: state.pageKey),
      ),
      GoRoute(
        path: '/clinic_info',
        builder: (context, state) => ClinicInfoScreen(key: state.pageKey),
      ),
      GoRoute(
        path: '/doctors_management',
        builder: (context, state) => DoctorsManagementScreen(key: state.pageKey),
      ),
    ],
  );
}