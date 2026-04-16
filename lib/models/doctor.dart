class Doctor {
  final int? id;
  final String firstName;
  final String lastName;
  final String? middleName;
  final String specialty;
  final String? username;
  final String? password;

  Doctor({
    this.id,
    required this.firstName,
    required this.lastName,
    this.middleName,
    required this.specialty,
    this.username,
    this.password,
  });

  String get fullName => '$lastName $firstName ${middleName ?? ""}'.trim();

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      middleName: json['middleName'],
      specialty: json['specialty'],
      username: json['username'],
      // Password usually not returned from API
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'middleName': middleName,
      'specialty': specialty,
      if (username != null) 'username': username,
      if (password != null) 'password': password,
    };
  }
}
