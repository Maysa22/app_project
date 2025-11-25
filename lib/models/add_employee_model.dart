class AddEmployee {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String? phone;
  final String role;
  final String organizationId;
  final DateTime emailVerifiedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  AddEmployee({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phone,
    required this.role,
    required this.organizationId,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AddEmployee.fromJson(Map<String, dynamic> json) {
    return AddEmployee(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phone: json['phone'],
      role: json['role'],
      organizationId: json['organization_id'].toString(),
      emailVerifiedAt: DateTime.parse(json['email_verified_at']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "phone": phone,
      "role": role,
      "organization_id": organizationId,
      "email_verified_at": emailVerifiedAt.toIso8601String(),
      "created_at": createdAt.toIso8601String(),
      "updated_at": updatedAt.toIso8601String(),
    };
  }
}
