class Patient {
  final int? id;
  final String firstName;
  final String lastName;
  final String? middleName;
  final String? username;
  final String? password;

  Patient({
    this.id,
    required this.firstName,
    required this.lastName,
    this.middleName,
    this.username,
    this.password,
  });

  String get fullName => '$lastName $firstName ${middleName ?? ""}'.trim();

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      middleName: json['middleName'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'middleName': middleName,
      if (username != null) 'username': username,
      if (password != null) 'password': password,
    };
  }
}
