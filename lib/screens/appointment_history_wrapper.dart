import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'appointment_history_screen.dart';
import 'package:first_flutter_project/models/appointment.dart';
import 'package:first_flutter_project/services/app_state_service.dart';
import 'package:first_flutter_project/locator.dart';


class AppointmentHistoryWrapper extends StatefulWidget {
  @override
  _AppointmentHistoryWrapperState createState() => _AppointmentHistoryWrapperState();
}
class _AppointmentHistoryWrapperState extends State<AppointmentHistoryWrapper> {
  final AppStateService _appStateService = getIt<AppStateService>();

  @override
  void initState() {
    super.initState();
    _appStateService.addListener(_onStateChanged);
  }

  @override
  void dispose() {
    _appStateService.removeListener(_onStateChanged);
    super.dispose();
  }

  void _onStateChanged() {
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('История записей (${_appStateService.historyAppointments.length})'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: AppointmentHistoryScreen(historyAppointments: _appStateService.historyAppointments),
    );
  }
}