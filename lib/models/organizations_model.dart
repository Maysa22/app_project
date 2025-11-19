class OrganizationsResponse {
  final List<Organization> data;
  final bool success;
  final String message;

  OrganizationsResponse({
    required this.data,
    required this.success,
    required this.message,
  });

  factory OrganizationsResponse.fromJson(Map<String, dynamic> json) {
    return OrganizationsResponse(
      data: (json['data'] as List)
          .map((item) => Organization.fromJson(item))
          .toList(),
      success: json['success'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((e) => e.toJson()).toList(),
      'success': success,
      'message': message,
    };
  }
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
