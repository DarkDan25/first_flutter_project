import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:first_flutter_project/bloc/prescriptions/prescriptions_bloc.dart';
import 'package:first_flutter_project/models/prescription.dart';

class PrescriptionsScreen extends StatelessWidget {
  const PrescriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Выписанные рецепты'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocBuilder<PrescriptionsBloc, PrescriptionsState>(
        builder: (context, state) {
          if (state is PrescriptionsLoaded) {
            return _buildPrescriptionsList(state.prescriptions);
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildPrescriptionsList(List<Prescription> prescriptions) {
    if (prescriptions.isEmpty) {
      return Center(
        child: Text(
          'Нет выписанных рецептов',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: prescriptions.length,
      itemBuilder: (context, index) {
        return _buildPrescriptionCard(prescriptions[index]);
      },
    );
  }

  Widget _buildPrescriptionCard(Prescription prescription) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  prescription.medicationName,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  prescription.date,
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: 8),
            _buildPrescriptionRow('Дозировка:', prescription.dosage),
            _buildPrescriptionRow('Частота:', prescription.frequency),
            _buildPrescriptionRow('Длительность:', prescription.duration),
            _buildPrescriptionRow('Врач:', prescription.doctorName),
            SizedBox(height: 8),
            Divider(),
            SizedBox(height: 8),
            Text(
              'Инструкции:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(prescription.instructions),
          ],
        ),
      ),
    );
  }

  Widget _buildPrescriptionRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(value),
          ),
        ],
      ),
    );
  }
}