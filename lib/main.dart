import 'package:first_flutter_project/app_router.dart';
import 'package:first_flutter_project/screens/medical_card_updater.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:first_flutter_project/bloc/current_appointments/current_appointments_bloc.dart';
import 'package:first_flutter_project/bloc/history/history_bloc.dart';
import 'package:first_flutter_project/bloc/make_appointment/make_appointment_bloc.dart';
import 'package:first_flutter_project/bloc/login/login_bloc.dart';
import 'package:first_flutter_project/bloc/profile/profile_bloc.dart';
import 'package:first_flutter_project/bloc/clinic_info/clinic_info_bloc.dart';
import 'package:first_flutter_project/bloc/medical_card/medical_card_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<CurrentAppointmentsBloc>(
            create: (context) => CurrentAppointmentsBloc()..add(LoadCurrentAppointments()),
          ),
          BlocProvider<HistoryBloc>(
            create: (context) => HistoryBloc()..add(LoadHistory()),
          ),
          BlocProvider<MakeAppointmentBloc>(
            create: (context) => MakeAppointmentBloc(),
          ),
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(),
          ),
          BlocProvider<ProfileBloc>(
            create: (context) => ProfileBloc(),
          ),
          BlocProvider<ClinicInfoBloc>(
            create: (context) => ClinicInfoBloc()..add(LoadClinicInfo()),
          ),
          BlocProvider<MedicalCardBloc>(
            create: (context) => MedicalCardBloc()..add(LoadMedicalCard()),
          ),
        ],
        child: MedicalCardUpdater(
          child: MaterialApp.router(
            routerConfig: AppRouter.router,
            title: 'Запись к врачу',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            debugShowCheckedModeBanner: false,
          ),
        ),
    );
  }
}