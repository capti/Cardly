class UserModel {
  final String email;
  final String? username;
  final String? token;
  final bool isEmailVerified;

  UserModel({
    required this.email,
    this.username,
    this.token,
    this.isEmailVerified = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'] ?? '',
      username: json['username'],
      token: json['token'],
      isEmailVerified: true, // Если пользователь успешно вошел, считаем, что почта подтверждена
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'username': username,
      'token': token,
      'isEmailVerified': isEmailVerified,
    };
  }
} 