// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'otp_sms_login_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

OtpSmsLoginRequest _$OtpSmsLoginRequestFromJson(Map<String, dynamic> json) {
  return _OtpSmsLoginRequest.fromJson(json);
}

/// @nodoc
class _$OtpSmsLoginRequestTearOff {
  const _$OtpSmsLoginRequestTearOff();

  _OtpSmsLoginRequest call({required String phone, required String code}) {
    return _OtpSmsLoginRequest(
      phone: phone,
      code: code,
    );
  }

  OtpSmsLoginRequest fromJson(Map<String, Object?> json) {
    return OtpSmsLoginRequest.fromJson(json);
  }
}

/// @nodoc
const $OtpSmsLoginRequest = _$OtpSmsLoginRequestTearOff();

/// @nodoc
mixin _$OtpSmsLoginRequest {
  String get phone => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OtpSmsLoginRequestCopyWith<OtpSmsLoginRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OtpSmsLoginRequestCopyWith<$Res> {
  factory $OtpSmsLoginRequestCopyWith(
          OtpSmsLoginRequest value, $Res Function(OtpSmsLoginRequest) then) =
      _$OtpSmsLoginRequestCopyWithImpl<$Res>;
  $Res call({String phone, String code});
}

/// @nodoc
class _$OtpSmsLoginRequestCopyWithImpl<$Res>
    implements $OtpSmsLoginRequestCopyWith<$Res> {
  _$OtpSmsLoginRequestCopyWithImpl(this._value, this._then);

  final OtpSmsLoginRequest _value;
  // ignore: unused_field
  final $Res Function(OtpSmsLoginRequest) _then;

  @override
  $Res call({
    Object? phone = freezed,
    Object? code = freezed,
  }) {
    return _then(_value.copyWith(
      phone: phone == freezed
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$OtpSmsLoginRequestCopyWith<$Res>
    implements $OtpSmsLoginRequestCopyWith<$Res> {
  factory _$OtpSmsLoginRequestCopyWith(
          _OtpSmsLoginRequest value, $Res Function(_OtpSmsLoginRequest) then) =
      __$OtpSmsLoginRequestCopyWithImpl<$Res>;
  @override
  $Res call({String phone, String code});
}

/// @nodoc
class __$OtpSmsLoginRequestCopyWithImpl<$Res>
    extends _$OtpSmsLoginRequestCopyWithImpl<$Res>
    implements _$OtpSmsLoginRequestCopyWith<$Res> {
  __$OtpSmsLoginRequestCopyWithImpl(
      _OtpSmsLoginRequest _value, $Res Function(_OtpSmsLoginRequest) _then)
      : super(_value, (v) => _then(v as _OtpSmsLoginRequest));

  @override
  _OtpSmsLoginRequest get _value => super._value as _OtpSmsLoginRequest;

  @override
  $Res call({
    Object? phone = freezed,
    Object? code = freezed,
  }) {
    return _then(_OtpSmsLoginRequest(
      phone: phone == freezed
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      code: code == freezed
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_OtpSmsLoginRequest implements _OtpSmsLoginRequest {
  const _$_OtpSmsLoginRequest({required this.phone, required this.code});

  factory _$_OtpSmsLoginRequest.fromJson(Map<String, dynamic> json) =>
      _$$_OtpSmsLoginRequestFromJson(json);

  @override
  final String phone;
  @override
  final String code;

  @override
  String toString() {
    return 'OtpSmsLoginRequest(phone: $phone, code: $code)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OtpSmsLoginRequest &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.code, code) || other.code == code));
  }

  @override
  int get hashCode => Object.hash(runtimeType, phone, code);

  @JsonKey(ignore: true)
  @override
  _$OtpSmsLoginRequestCopyWith<_OtpSmsLoginRequest> get copyWith =>
      __$OtpSmsLoginRequestCopyWithImpl<_OtpSmsLoginRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OtpSmsLoginRequestToJson(this);
  }
}

abstract class _OtpSmsLoginRequest implements OtpSmsLoginRequest {
  const factory _OtpSmsLoginRequest(
      {required String phone, required String code}) = _$_OtpSmsLoginRequest;

  factory _OtpSmsLoginRequest.fromJson(Map<String, dynamic> json) =
      _$_OtpSmsLoginRequest.fromJson;

  @override
  String get phone;
  @override
  String get code;
  @override
  @JsonKey(ignore: true)
  _$OtpSmsLoginRequestCopyWith<_OtpSmsLoginRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
