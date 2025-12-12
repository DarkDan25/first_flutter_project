import 'package:first_flutter_project/screens/clinic_info_screen.dart';
import 'package:first_flutter_project/screens/medical_card_screen.dart';
import 'package:first_flutter_project/screens/prescriptions_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:first_flutter_project/screens/login_screen.dart';
import 'package:first_flutter_project/screens/current_appointments_wrapper.dart';
import 'package:first_flutter_project/screens/make_appointment_screen.dart';
import 'package:first_flutter_project/screens/profile_screen.dart';
import 'package:first_flutter_project/screens/appointment_history_wrapper.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: '/current',
        builder: (context, state) => CurrentAppointmentsWrapper(),
      ),
      GoRoute(
        path: '/make',
        builder: (context, state) => MakeAppointmentScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => ProfileScreen(),
      ),
      GoRoute(
        path: '/history',
        builder: (context, state) => AppointmentHistoryWrapper(),
      ),
      GoRoute(
        path: '/clinic_info',
        builder: (context, state) => ClinicInfoScreen(),
      ),
      GoRoute(
        path: '/medical_card',
        builder: (context, state) => MedicalCardScreen(),
      ),
      GoRoute(
        path: '/prescriptions',
        builder: (context, state) => PrescriptionsScreen(),
      ),
    ],
  );
}