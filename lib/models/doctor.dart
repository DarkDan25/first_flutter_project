class Doctor {
  final int? id;
  final String firstName;
  final String lastName;
  final String? middleName;
  final String specialty;

  Doctor({
    this.id,
    required this.firstName,
    required this.lastName,
    this.middleName,
    required this.specialty,
  });

  String get fullName => '$lastName $firstName ${middleName ?? ""}'.trim();

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      middleName: json['middleName'],
      specialty: json['specialty'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'middleName': middleName,
      'specialty': specialty,
    };
  }
}
