


import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movies_app/core/networking/api_error_model.dart';
part 'profile_state.freezed.dart';

@freezed
class ProfileState<T> with _$ProfileState<T>{

  const factory ProfileState.initial() = Initial;


  const factory ProfileState.loading() = Loading;
  const factory ProfileState.success(T data) = Success<T>;
  const factory ProfileState.failure(String errorMsg) = Failure;
}


