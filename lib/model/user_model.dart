import 'package:fe_financial_manager/constants/enum.dart';

class UserModel{
  String id;
  String name;
  String email;
  String verify;
  String role;
  String ? avatar;

  UserModel ({
    required this.id,
    required this.name,
    required this.email,
    required this.verify,
    required this.role,
    this.avatar
  });
  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
      id: json['id'] ?? '0',
      name: json['name'] ?? 'unknow@gmail.com',
      email: json['email'] ?? 'unknow@gmail.com' ,
      verify: json['verify'] ?? IsVerify.unVerified,
      role: json['role'] ?? UserRole.user,
      avatar: json['avatar'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'verify': verify,
      'role': role,
      'avatar': avatar,
    };
  }
}