

import 'package:json_annotation/json_annotation.dart';
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
}