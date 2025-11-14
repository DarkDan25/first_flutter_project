import 'package:flutter/material.dart';
import 'package:first_flutter_project/models/appointment.dart';
import 'package:first_flutter_project/screens/appointment_history_wrapper.dart';
import 'package:first_flutter_project/screens/login_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:first_flutter_project/services/app_state_service.dart';
import 'package:first_flutter_project/locator.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}
class _ProfileScreenState extends State<ProfileScreen> {
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
        title: Text('Профиль'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue,
                child: Icon(Icons.person, size: 50, color: Colors.white),
              ),
            ),
            SizedBox(height: 24),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Иванов Ф.П.',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Возраст: 25 лет',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Номер мед. карты: 1234567890',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                context.push('/history');
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text('Просмотреть завершенные записи (${_appStateService.historyAppointments.length})'),
            ),
            SizedBox(height: 16),
            OutlinedButton(
              onPressed: () {
                _showLogoutConfirmation(context);
              },
              style: OutlinedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                side: BorderSide(color: Colors.red),
              ),
              child: Text(
                'Выйти',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Выход из системы'),
        content: Text('Вы уверены, что хотите выйти?'),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              context.pop();
              context.go('/');
            },
            child: Text(
              'Выйти',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}