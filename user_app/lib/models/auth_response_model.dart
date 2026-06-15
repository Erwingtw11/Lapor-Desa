import 'user_model.dart';

class AuthResponseModel {
  final String message;
  final String accessToken;
  final UserModel user;

  const AuthResponseModel({
    required this.message,
    required this.accessToken,
    required this.user,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      message: json['message'] as String,
      accessToken: json['accessToken'] as String,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );
  }
}

