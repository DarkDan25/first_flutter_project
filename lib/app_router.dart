import 'package:first_flutter_project/models/appointment.dart';
import 'package:go_router/go_router.dart';
import 'screens/login_screen.dart';
import 'screens/current_appointments_wrapper.dart';
import 'screens/make_appointment_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/appointment_history_wrapper.dart';

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
        builder: (context, state) => MakeAppointmentScreen(
          onAddAppointment: state.extra as Function(Appointment),
        ),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => ProfileScreen(
          historyAppointments: state.extra as List<Appointment>,
        ),
      ),
      GoRoute(
        path: '/history',
        builder: (context, state) => AppointmentHistoryWrapper(
          historyAppointments: state.extra as List<Appointment>,
        ),
      ),
    ],
  );
}