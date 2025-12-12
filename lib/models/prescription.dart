class Prescription {
  final String id;
  final String medicationName;
  final String dosage;
  final String frequency;
  final String duration;
  final String doctorName;
  final String date;
  final String instructions;

  Prescription({
    required this.id,
    required this.medicationName,
    required this.dosage,
    required this.frequency,
    required this.duration,
    required this.doctorName,
    required this.date,
    required this.instructions,
  });
}