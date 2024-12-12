


import 'package:freezed_annotation/freezed_annotation.dart';
part 'update_profile_state.freezed.dart';

@freezed
class UpdateProfileState with _$UpdateProfileState{
  const factory UpdateProfileState.initial() = Initial;


  const factory UpdateProfileState.loading() = Loading;
  const factory UpdateProfileState.success() = Success;
  const factory UpdateProfileState.failure(String errorMsg) = Failure;
}


