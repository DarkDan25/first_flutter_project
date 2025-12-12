import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:first_flutter_project/bloc/doctors_management/doctors_management_bloc.dart';

class DoctorsDataUpdater extends StatelessWidget {
  final Widget child;

  const DoctorsDataUpdater({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DoctorsManagementBloc, DoctorsManagementState>(
      listener: (context, state) {
        if (state is DoctorsLoaded) {
        }
      },
      child: child,
    );
  }
}