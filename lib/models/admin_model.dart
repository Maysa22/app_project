class AdminResponse {
  final AdminData? data;
  final bool? success;
  final String? message;

  AdminResponse({
    this.data,
    this.success,
    this.message,
  });

  factory AdminResponse.fromJson(Map<String, dynamic> json) {
    return AdminResponse(
      data: json['data'] != null ? AdminData.fromJson(json['data']) : null,
      success: json['success'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.toJson(),
      'success': success,
      'message': message,
    };
  }
}

class AdminData {
  final Admin? user;
  final String? token;

  AdminData({
    this.user,
    this.token,
  });

  factory AdminData.fromJson(Map<String, dynamic> json) {
    return AdminData(
      user: json['user'] != null ? Admin.fromJson(json['user']) : null,
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user?.toJson(),
      'token': token,
    };
  }
}

class Admin {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? emailVerifiedAt;
  final String? phoneVerifiedAt;
  final String? role;
  final int? organizationId;
  final String? createdAt;
  final String? updatedAt;

  Admin({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.emailVerifiedAt,
    this.phoneVerifiedAt,
    this.role,
    this.organizationId,
    this.createdAt,
    this.updatedAt,
  });

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
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
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
    };
  }
}
