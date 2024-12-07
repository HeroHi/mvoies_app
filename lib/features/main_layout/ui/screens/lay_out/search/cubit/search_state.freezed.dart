// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SearchState<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() moviesLoading,
    required TResult Function(T data) moviesSuccess,
    required TResult Function(ApiErrorModel error) moviesFailure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? moviesLoading,
    TResult? Function(T data)? moviesSuccess,
    TResult? Function(ApiErrorModel error)? moviesFailure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? moviesLoading,
    TResult Function(T data)? moviesSuccess,
    TResult Function(ApiErrorModel error)? moviesFailure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial<T> value) initial,
    required TResult Function(MoviesLoading<T> value) moviesLoading,
    required TResult Function(MoviesSuccess<T> value) moviesSuccess,
    required TResult Function(MoviesFailure<T> value) moviesFailure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial<T> value)? initial,
    TResult? Function(MoviesLoading<T> value)? moviesLoading,
    TResult? Function(MoviesSuccess<T> value)? moviesSuccess,
    TResult? Function(MoviesFailure<T> value)? moviesFailure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial<T> value)? initial,
    TResult Function(MoviesLoading<T> value)? moviesLoading,
    TResult Function(MoviesSuccess<T> value)? moviesSuccess,
    TResult Function(MoviesFailure<T> value)? moviesFailure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchStateCopyWith<T, $Res> {
  factory $SearchStateCopyWith(
          SearchState<T> value, $Res Function(SearchState<T>) then) =
      _$SearchStateCopyWithImpl<T, $Res, SearchState<T>>;
}

/// @nodoc
class _$SearchStateCopyWithImpl<T, $Res, $Val extends SearchState<T>>
    implements $SearchStateCopyWith<T, $Res> {
  _$SearchStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<T, $Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl<T> value, $Res Function(_$InitialImpl<T>) then) =
      __$$InitialImplCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<T, $Res>
    extends _$SearchStateCopyWithImpl<T, $Res, _$InitialImpl<T>>
    implements _$$InitialImplCopyWith<T, $Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl<T> _value, $Res Function(_$InitialImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl<T> implements Initial<T> {
  const _$InitialImpl();

  @override
  String toString() {
    return 'SearchState<$T>.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() moviesLoading,
    required TResult Function(T data) moviesSuccess,
    required TResult Function(ApiErrorModel error) moviesFailure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? moviesLoading,
    TResult? Function(T data)? moviesSuccess,
    TResult? Function(ApiErrorModel error)? moviesFailure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? moviesLoading,
    TResult Function(T data)? moviesSuccess,
    TResult Function(ApiErrorModel error)? moviesFailure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial<T> value) initial,
    required TResult Function(MoviesLoading<T> value) moviesLoading,
    required TResult Function(MoviesSuccess<T> value) moviesSuccess,
    required TResult Function(MoviesFailure<T> value) moviesFailure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial<T> value)? initial,
    TResult? Function(MoviesLoading<T> value)? moviesLoading,
    TResult? Function(MoviesSuccess<T> value)? moviesSuccess,
    TResult? Function(MoviesFailure<T> value)? moviesFailure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial<T> value)? initial,
    TResult Function(MoviesLoading<T> value)? moviesLoading,
    TResult Function(MoviesSuccess<T> value)? moviesSuccess,
    TResult Function(MoviesFailure<T> value)? moviesFailure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class Initial<T> implements SearchState<T> {
  const factory Initial() = _$InitialImpl<T>;
}

/// @nodoc
abstract class _$$MoviesLoadingImplCopyWith<T, $Res> {
  factory _$$MoviesLoadingImplCopyWith(_$MoviesLoadingImpl<T> value,
          $Res Function(_$MoviesLoadingImpl<T>) then) =
      __$$MoviesLoadingImplCopyWithImpl<T, $Res>;
}

/// @nodoc
class __$$MoviesLoadingImplCopyWithImpl<T, $Res>
    extends _$SearchStateCopyWithImpl<T, $Res, _$MoviesLoadingImpl<T>>
    implements _$$MoviesLoadingImplCopyWith<T, $Res> {
  __$$MoviesLoadingImplCopyWithImpl(_$MoviesLoadingImpl<T> _value,
      $Res Function(_$MoviesLoadingImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$MoviesLoadingImpl<T> implements MoviesLoading<T> {
  const _$MoviesLoadingImpl();

  @override
  String toString() {
    return 'SearchState<$T>.moviesLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MoviesLoadingImpl<T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() moviesLoading,
    required TResult Function(T data) moviesSuccess,
    required TResult Function(ApiErrorModel error) moviesFailure,
  }) {
    return moviesLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? moviesLoading,
    TResult? Function(T data)? moviesSuccess,
    TResult? Function(ApiErrorModel error)? moviesFailure,
  }) {
    return moviesLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? moviesLoading,
    TResult Function(T data)? moviesSuccess,
    TResult Function(ApiErrorModel error)? moviesFailure,
    required TResult orElse(),
  }) {
    if (moviesLoading != null) {
      return moviesLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial<T> value) initial,
    required TResult Function(MoviesLoading<T> value) moviesLoading,
    required TResult Function(MoviesSuccess<T> value) moviesSuccess,
    required TResult Function(MoviesFailure<T> value) moviesFailure,
  }) {
    return moviesLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial<T> value)? initial,
    TResult? Function(MoviesLoading<T> value)? moviesLoading,
    TResult? Function(MoviesSuccess<T> value)? moviesSuccess,
    TResult? Function(MoviesFailure<T> value)? moviesFailure,
  }) {
    return moviesLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial<T> value)? initial,
    TResult Function(MoviesLoading<T> value)? moviesLoading,
    TResult Function(MoviesSuccess<T> value)? moviesSuccess,
    TResult Function(MoviesFailure<T> value)? moviesFailure,
    required TResult orElse(),
  }) {
    if (moviesLoading != null) {
      return moviesLoading(this);
    }
    return orElse();
  }
}

abstract class MoviesLoading<T> implements SearchState<T> {
  const factory MoviesLoading() = _$MoviesLoadingImpl<T>;
}

/// @nodoc
abstract class _$$MoviesSuccessImplCopyWith<T, $Res> {
  factory _$$MoviesSuccessImplCopyWith(_$MoviesSuccessImpl<T> value,
          $Res Function(_$MoviesSuccessImpl<T>) then) =
      __$$MoviesSuccessImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({T data});
}

/// @nodoc
class __$$MoviesSuccessImplCopyWithImpl<T, $Res>
    extends _$SearchStateCopyWithImpl<T, $Res, _$MoviesSuccessImpl<T>>
    implements _$$MoviesSuccessImplCopyWith<T, $Res> {
  __$$MoviesSuccessImplCopyWithImpl(_$MoviesSuccessImpl<T> _value,
      $Res Function(_$MoviesSuccessImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$MoviesSuccessImpl<T>(
      freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$MoviesSuccessImpl<T> implements MoviesSuccess<T> {
  const _$MoviesSuccessImpl(this.data);

  @override
  final T data;

  @override
  String toString() {
    return 'SearchState<$T>.moviesSuccess(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MoviesSuccessImpl<T> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MoviesSuccessImplCopyWith<T, _$MoviesSuccessImpl<T>> get copyWith =>
      __$$MoviesSuccessImplCopyWithImpl<T, _$MoviesSuccessImpl<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() moviesLoading,
    required TResult Function(T data) moviesSuccess,
    required TResult Function(ApiErrorModel error) moviesFailure,
  }) {
    return moviesSuccess(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? moviesLoading,
    TResult? Function(T data)? moviesSuccess,
    TResult? Function(ApiErrorModel error)? moviesFailure,
  }) {
    return moviesSuccess?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? moviesLoading,
    TResult Function(T data)? moviesSuccess,
    TResult Function(ApiErrorModel error)? moviesFailure,
    required TResult orElse(),
  }) {
    if (moviesSuccess != null) {
      return moviesSuccess(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial<T> value) initial,
    required TResult Function(MoviesLoading<T> value) moviesLoading,
    required TResult Function(MoviesSuccess<T> value) moviesSuccess,
    required TResult Function(MoviesFailure<T> value) moviesFailure,
  }) {
    return moviesSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial<T> value)? initial,
    TResult? Function(MoviesLoading<T> value)? moviesLoading,
    TResult? Function(MoviesSuccess<T> value)? moviesSuccess,
    TResult? Function(MoviesFailure<T> value)? moviesFailure,
  }) {
    return moviesSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial<T> value)? initial,
    TResult Function(MoviesLoading<T> value)? moviesLoading,
    TResult Function(MoviesSuccess<T> value)? moviesSuccess,
    TResult Function(MoviesFailure<T> value)? moviesFailure,
    required TResult orElse(),
  }) {
    if (moviesSuccess != null) {
      return moviesSuccess(this);
    }
    return orElse();
  }
}

abstract class MoviesSuccess<T> implements SearchState<T> {
  const factory MoviesSuccess(final T data) = _$MoviesSuccessImpl<T>;

  T get data;

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MoviesSuccessImplCopyWith<T, _$MoviesSuccessImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$MoviesFailureImplCopyWith<T, $Res> {
  factory _$$MoviesFailureImplCopyWith(_$MoviesFailureImpl<T> value,
          $Res Function(_$MoviesFailureImpl<T>) then) =
      __$$MoviesFailureImplCopyWithImpl<T, $Res>;
  @useResult
  $Res call({ApiErrorModel error});
}

/// @nodoc
class __$$MoviesFailureImplCopyWithImpl<T, $Res>
    extends _$SearchStateCopyWithImpl<T, $Res, _$MoviesFailureImpl<T>>
    implements _$$MoviesFailureImplCopyWith<T, $Res> {
  __$$MoviesFailureImplCopyWithImpl(_$MoviesFailureImpl<T> _value,
      $Res Function(_$MoviesFailureImpl<T>) _then)
      : super(_value, _then);

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$MoviesFailureImpl<T>(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as ApiErrorModel,
    ));
  }
}

/// @nodoc

class _$MoviesFailureImpl<T> implements MoviesFailure<T> {
  const _$MoviesFailureImpl(this.error);

  @override
  final ApiErrorModel error;

  @override
  String toString() {
    return 'SearchState<$T>.moviesFailure(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MoviesFailureImpl<T> &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MoviesFailureImplCopyWith<T, _$MoviesFailureImpl<T>> get copyWith =>
      __$$MoviesFailureImplCopyWithImpl<T, _$MoviesFailureImpl<T>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() moviesLoading,
    required TResult Function(T data) moviesSuccess,
    required TResult Function(ApiErrorModel error) moviesFailure,
  }) {
    return moviesFailure(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? moviesLoading,
    TResult? Function(T data)? moviesSuccess,
    TResult? Function(ApiErrorModel error)? moviesFailure,
  }) {
    return moviesFailure?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? moviesLoading,
    TResult Function(T data)? moviesSuccess,
    TResult Function(ApiErrorModel error)? moviesFailure,
    required TResult orElse(),
  }) {
    if (moviesFailure != null) {
      return moviesFailure(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial<T> value) initial,
    required TResult Function(MoviesLoading<T> value) moviesLoading,
    required TResult Function(MoviesSuccess<T> value) moviesSuccess,
    required TResult Function(MoviesFailure<T> value) moviesFailure,
  }) {
    return moviesFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial<T> value)? initial,
    TResult? Function(MoviesLoading<T> value)? moviesLoading,
    TResult? Function(MoviesSuccess<T> value)? moviesSuccess,
    TResult? Function(MoviesFailure<T> value)? moviesFailure,
  }) {
    return moviesFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial<T> value)? initial,
    TResult Function(MoviesLoading<T> value)? moviesLoading,
    TResult Function(MoviesSuccess<T> value)? moviesSuccess,
    TResult Function(MoviesFailure<T> value)? moviesFailure,
    required TResult orElse(),
  }) {
    if (moviesFailure != null) {
      return moviesFailure(this);
    }
    return orElse();
  }
}

abstract class MoviesFailure<T> implements SearchState<T> {
  const factory MoviesFailure(final ApiErrorModel error) =
      _$MoviesFailureImpl<T>;

  ApiErrorModel get error;

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MoviesFailureImplCopyWith<T, _$MoviesFailureImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
