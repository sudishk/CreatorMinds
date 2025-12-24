
import '../../domain/entities/user.dart';

class UserModel extends User{
  UserModel({required super.id, required super.name,required super.email});

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
      id: "${json['data']['user_id']}",
      name: json['data']['first_name'],
      email: "${json['data']['email']}",
    );
  }
}