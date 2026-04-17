import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:first_flutter_project/bloc/history/history_bloc.dart';
import 'package:first_flutter_project/bloc/profile/profile_bloc.dart';
import 'package:first_flutter_project/bloc/login/login_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, loginState) {
          String name = 'Пользователь';
          String role = 'Неизвестно';
          
          if (loginState is LoginSuccess) {
            final userData = loginState.userData;
            final firstName = userData['firstName'] ?? '';
            final lastName = userData['lastName'] ?? '';
            final middleName = userData['middleName'] ?? '';
            name = '$lastName $firstName $middleName'.trim();
            role = loginState.role;
          }

          return BlocBuilder<HistoryBloc, HistoryState>(
            builder: (context, historyState) {
              int historyCount = 0;
              if (historyState is HistoryLoaded) {
                historyCount = historyState.appointments.length;
              }
              return Padding(
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
                              name,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Роль: $role',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (role == 'PATIENT' || role == 'DOCTOR') ...[
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          context.push('/history');
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),
                        ),
                        child: Text('Просмотреть историю записей ($historyCount)'),
                      ),
                    ],
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
              );
            },
          );
        },
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Выход'),
        content: Text('Вы уверены, что хотите выйти?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              context.read<LoginBloc>().add(LoginLogoutRequested());
              context.read<ProfileBloc>().add(ProfileLogoutRequested());
              context.go('/'); // Force navigation to login screen
            },
            child: Text('Выйти', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}