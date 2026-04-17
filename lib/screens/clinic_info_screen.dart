import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:first_flutter_project/bloc/clinic_info/clinic_info_bloc.dart';

class ClinicInfoScreen extends StatelessWidget {
  const ClinicInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Информация о клинике'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocBuilder<ClinicInfoBloc, ClinicInfoState>(
        builder: (context, state) {
          if (state is ClinicInfoLoaded) {
            return _buildLoadedState(context, state);
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildLoadedState(BuildContext context, ClinicInfoLoaded state) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            state.name,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          _buildInfoCard(
            icon: Icons.location_on,
            title: 'Адрес',
            content: state.address,
          ),
          _buildInfoCard(
            icon: Icons.phone,
            title: 'Телефон',
            content: state.phone,
          ),
          _buildInfoCard(
            icon: Icons.email,
            title: 'Email',
            content: state.email,
          ),
          _buildInfoCard(
            icon: Icons.access_time,
            title: 'Режим работы',
            content: state.workingHours,
          ),
          SizedBox(height: 20),
          Text(
            'О нас',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            state.description,
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({required IconData icon, required String title, required String content}) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.blue, size: 24),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    content,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}