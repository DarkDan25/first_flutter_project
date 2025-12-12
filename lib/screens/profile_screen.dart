import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:first_flutter_project/bloc/history/history_bloc.dart';
import 'package:first_flutter_project/bloc/profile/profile_bloc.dart';
import 'package:first_flutter_project/bloc/medical_card/medical_card_bloc.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLogoutSuccess) {
          context.go('/');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Профиль'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
        ),
        body: BlocBuilder<MedicalCardBloc, MedicalCardState>(
          builder: (context, medicalCardState) {
            return BlocBuilder<HistoryBloc, HistoryState>(
              builder: (context, historyState) {
                String name = 'Ошибка загрузки';
                String age = 'Ошибка загрузки';
                String medCardId = 'ошибка загрузки';

                if (medicalCardState is MedicalCardLoaded) {
                  name = medicalCardState.patientName;
                  age = medicalCardState.age;
                  medCardId = medicalCardState.medCardId;
                }
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
                                'Возраст: $age',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Номер мед. карты: $medCardId',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          context.push('/medical_card');
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),
                        ),
                        child: Text('Медицинская карта'),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          context.push('/prescriptions');
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),
                        ),
                        child: Text('Выписанные рецепты'),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          context.push('/history');
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),
                        ),
                        child: Text('Просмотреть завершенные записи ($historyCount)'),
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
                );
              },
            );
          },
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
              context.read<ProfileBloc>().add(ProfileLogoutRequested());
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