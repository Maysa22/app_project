class ShowEmployees {
  final List<Employee> data;
  final bool success;
  final String? message;

  ShowEmployees({
    required this.data,
    required this.success,
    this.message,
  });

  factory ShowEmployees.fromJson(Map<String, dynamic> json) {
    return ShowEmployees(
      data: (json['data'] as List)
          .map((item) => Employee.fromJson(item))
          .toList(),
      success: json['success'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() => {
    'data': data.map((employee) => employee.toJson()).toList(),
    'success': success,
    'message': message,
  };
}

class Employee {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String? phone;
  final String? emailVerifiedAt;
  final String? phoneVerifiedAt;
  final String role;
  final int organizationId;
  final String createdAt;
  final String updatedAt;
  final Organization organization;

  Employee({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phone,
    this.emailVerifiedAt,
    this.phoneVerifiedAt,
    required this.role,
    required this.organizationId,
    required this.createdAt,
    required this.updatedAt,
    required this.organization,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phone: json['phone'],
      emailVerifiedAt: json['email_verified_at'],
      phoneVerifiedAt: json['phone_verified_at'],
      role: json['role'],
      organizationId: json['organization_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      organization: Organization.fromJson(json['organization']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'first_name': firstName,
    'last_name': lastName,
    'email': email,
    'phone': phone,
    'email_verified_at': emailVerifiedAt,
    'phone_verified_at': phoneVerifiedAt,
    'role': role,
    'organization_id': organizationId,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'organization': organization.toJson(),
  };
}

class Organization {
  final int id;
  final String name;
  final String createdAt;
  final String updatedAt;

  Organization({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      id: json['id'],
      name: json['name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}
