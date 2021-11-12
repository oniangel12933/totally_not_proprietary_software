// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'sign_up_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SignUpRequest _$SignUpRequestFromJson(Map<String, dynamic> json) {
  return _SignUpRequest.fromJson(json);
}

/// @nodoc
class _$SignUpRequestTearOff {
  const _$SignUpRequestTearOff();

  _SignUpRequest call(
      {String? email,
      required String username,
      required String phone,
      required String name,
      required String birthdate}) {
    return _SignUpRequest(
      email: email,
      username: username,
      phone: phone,
      name: name,
      birthdate: birthdate,
    );
  }

  SignUpRequest fromJson(Map<String, Object?> json) {
    return SignUpRequest.fromJson(json);
  }
}

/// @nodoc
const $SignUpRequest = _$SignUpRequestTearOff();

/// @nodoc
mixin _$SignUpRequest {
  String? get email => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get birthdate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SignUpRequestCopyWith<SignUpRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignUpRequestCopyWith<$Res> {
  factory $SignUpRequestCopyWith(
          SignUpRequest value, $Res Function(SignUpRequest) then) =
      _$SignUpRequestCopyWithImpl<$Res>;
  $Res call(
      {String? email,
      String username,
      String phone,
      String name,
      String birthdate});
}

/// @nodoc
class _$SignUpRequestCopyWithImpl<$Res>
    implements $SignUpRequestCopyWith<$Res> {
  _$SignUpRequestCopyWithImpl(this._value, this._then);

  final SignUpRequest _value;
  // ignore: unused_field
  final $Res Function(SignUpRequest) _then;

  @override
  $Res call({
    Object? email = freezed,
    Object? username = freezed,
    Object? phone = freezed,
    Object? name = freezed,
    Object? birthdate = freezed,
  }) {
    return _then(_value.copyWith(
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      username: username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      phone: phone == freezed
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      birthdate: birthdate == freezed
          ? _value.birthdate
          : birthdate // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$SignUpRequestCopyWith<$Res>
    implements $SignUpRequestCopyWith<$Res> {
  factory _$SignUpRequestCopyWith(
          _SignUpRequest value, $Res Function(_SignUpRequest) then) =
      __$SignUpRequestCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? email,
      String username,
      String phone,
      String name,
      String birthdate});
}

/// @nodoc
class __$SignUpRequestCopyWithImpl<$Res>
    extends _$SignUpRequestCopyWithImpl<$Res>
    implements _$SignUpRequestCopyWith<$Res> {
  __$SignUpRequestCopyWithImpl(
      _SignUpRequest _value, $Res Function(_SignUpRequest) _then)
      : super(_value, (v) => _then(v as _SignUpRequest));

  @override
  _SignUpRequest get _value => super._value as _SignUpRequest;

  @override
  $Res call({
    Object? email = freezed,
    Object? username = freezed,
    Object? phone = freezed,
    Object? name = freezed,
    Object? birthdate = freezed,
  }) {
    return _then(_SignUpRequest(
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      username: username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      phone: phone == freezed
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      birthdate: birthdate == freezed
          ? _value.birthdate
          : birthdate // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SignUpRequest implements _SignUpRequest {
  const _$_SignUpRequest(
      {this.email,
      required this.username,
      required this.phone,
      required this.name,
      required this.birthdate});

  factory _$_SignUpRequest.fromJson(Map<String, dynamic> json) =>
      _$$_SignUpRequestFromJson(json);

  @override
  final String? email;
  @override
  final String username;
  @override
  final String phone;
  @override
  final String name;
  @override
  final String birthdate;

  @override
  String toString() {
    return 'SignUpRequest(email: $email, username: $username, phone: $phone, name: $name, birthdate: $birthdate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SignUpRequest &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.birthdate, birthdate) ||
                other.birthdate == birthdate));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, email, username, phone, name, birthdate);

  @JsonKey(ignore: true)
  @override
  _$SignUpRequestCopyWith<_SignUpRequest> get copyWith =>
      __$SignUpRequestCopyWithImpl<_SignUpRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SignUpRequestToJson(this);
  }
}

abstract class _SignUpRequest implements SignUpRequest {
  const factory _SignUpRequest(
      {String? email,
      required String username,
      required String phone,
      required String name,
      required String birthdate}) = _$_SignUpRequest;

  factory _SignUpRequest.fromJson(Map<String, dynamic> json) =
      _$_SignUpRequest.fromJson;

  @override
  String? get email;
  @override
  String get username;
  @override
  String get phone;
  @override
  String get name;
  @override
  String get birthdate;
  @override
  @JsonKey(ignore: true)
  _$SignUpRequestCopyWith<_SignUpRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
