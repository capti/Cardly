class UserModel {
  final String id;
  final String email;
  final String? name;
  final bool isEmailVerified;

  UserModel({
    required this.id,
    required this.email,
    this.name,
    this.isEmailVerified = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'],
      isEmailVerified: json['isEmailVerified'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'isEmailVerified': isEmailVerified,
    };
  }
} 