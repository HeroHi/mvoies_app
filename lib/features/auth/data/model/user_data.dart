

import 'package:json_annotation/json_annotation.dart';
import 'package:movies_app/features/profile/domain/entities/user_entity.dart';
part 'user_data.g.dart';
@JsonSerializable()
class UserData{
  String name;
  String phoneNumber;
  String email;
  String avatarCode;
  UserData({required this.name, required this.phoneNumber,required this.email,required this.avatarCode});
  factory UserData.fromJson(Map<String, dynamic> json) => _$UserDataFromJson(json);
  Map<String, dynamic> toJson() => _$UserDataToJson(this);
  UserEntity toEntity(){
    return UserEntity(avatarCode: avatarCode, name: name, email: email, phone: phoneNumber);
  }
}