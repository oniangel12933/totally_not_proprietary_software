// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'otp_sms_start_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

OtpSmsStartResponse _$OtpSmsStartResponseFromJson(Map<String, dynamic> json) {
  return _OtpSmsStartResponse.fromJson(json);
}

/// @nodoc
class _$OtpSmsStartResponseTearOff {
  const _$OtpSmsStartResponseTearOff();

  _OtpSmsStartResponse call(
      {String? phoneNumber,
      bool? phoneVerified,
      String? requestLanguage,
      String? error}) {
    return _OtpSmsStartResponse(
      phoneNumber: phoneNumber,
      phoneVerified: phoneVerified,
      requestLanguage: requestLanguage,
      error: error,
    );
  }

  OtpSmsStartResponse fromJson(Map<String, Object?> json) {
    return OtpSmsStartResponse.fromJson(json);
  }
}

/// @nodoc
const $OtpSmsStartResponse = _$OtpSmsStartResponseTearOff();

/// @nodoc
mixin _$OtpSmsStartResponse {
  String? get phoneNumber => throw _privateConstructorUsedError;
  bool? get phoneVerified => throw _privateConstructorUsedError;
  String? get requestLanguage => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OtpSmsStartResponseCopyWith<OtpSmsStartResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OtpSmsStartResponseCopyWith<$Res> {
  factory $OtpSmsStartResponseCopyWith(
          OtpSmsStartResponse value, $Res Function(OtpSmsStartResponse) then) =
      _$OtpSmsStartResponseCopyWithImpl<$Res>;
  $Res call(
      {String? phoneNumber,
      bool? phoneVerified,
      String? requestLanguage,
      String? error});
}

/// @nodoc
class _$OtpSmsStartResponseCopyWithImpl<$Res>
    implements $OtpSmsStartResponseCopyWith<$Res> {
  _$OtpSmsStartResponseCopyWithImpl(this._value, this._then);

  final OtpSmsStartResponse _value;
  // ignore: unused_field
  final $Res Function(OtpSmsStartResponse) _then;

  @override
  $Res call({
    Object? phoneNumber = freezed,
    Object? phoneVerified = freezed,
    Object? requestLanguage = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      phoneNumber: phoneNumber == freezed
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneVerified: phoneVerified == freezed
          ? _value.phoneVerified
          : phoneVerified // ignore: cast_nullable_to_non_nullable
              as bool?,
      requestLanguage: requestLanguage == freezed
          ? _value.requestLanguage
          : requestLanguage // ignore: cast_nullable_to_non_nullable
              as String?,
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$OtpSmsStartResponseCopyWith<$Res>
    implements $OtpSmsStartResponseCopyWith<$Res> {
  factory _$OtpSmsStartResponseCopyWith(_OtpSmsStartResponse value,
          $Res Function(_OtpSmsStartResponse) then) =
      __$OtpSmsStartResponseCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? phoneNumber,
      bool? phoneVerified,
      String? requestLanguage,
      String? error});
}

/// @nodoc
class __$OtpSmsStartResponseCopyWithImpl<$Res>
    extends _$OtpSmsStartResponseCopyWithImpl<$Res>
    implements _$OtpSmsStartResponseCopyWith<$Res> {
  __$OtpSmsStartResponseCopyWithImpl(
      _OtpSmsStartResponse _value, $Res Function(_OtpSmsStartResponse) _then)
      : super(_value, (v) => _then(v as _OtpSmsStartResponse));

  @override
  _OtpSmsStartResponse get _value => super._value as _OtpSmsStartResponse;

  @override
  $Res call({
    Object? phoneNumber = freezed,
    Object? phoneVerified = freezed,
    Object? requestLanguage = freezed,
    Object? error = freezed,
  }) {
    return _then(_OtpSmsStartResponse(
      phoneNumber: phoneNumber == freezed
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneVerified: phoneVerified == freezed
          ? _value.phoneVerified
          : phoneVerified // ignore: cast_nullable_to_non_nullable
              as bool?,
      requestLanguage: requestLanguage == freezed
          ? _value.requestLanguage
          : requestLanguage // ignore: cast_nullable_to_non_nullable
              as String?,
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_OtpSmsStartResponse implements _OtpSmsStartResponse {
  const _$_OtpSmsStartResponse(
      {this.phoneNumber, this.phoneVerified, this.requestLanguage, this.error});

  factory _$_OtpSmsStartResponse.fromJson(Map<String, dynamic> json) =>
      _$$_OtpSmsStartResponseFromJson(json);

  @override
  final String? phoneNumber;
  @override
  final bool? phoneVerified;
  @override
  final String? requestLanguage;
  @override
  final String? error;

  @override
  String toString() {
    return 'OtpSmsStartResponse(phoneNumber: $phoneNumber, phoneVerified: $phoneVerified, requestLanguage: $requestLanguage, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OtpSmsStartResponse &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.phoneVerified, phoneVerified) ||
                other.phoneVerified == phoneVerified) &&
            (identical(other.requestLanguage, requestLanguage) ||
                other.requestLanguage == requestLanguage) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, phoneNumber, phoneVerified, requestLanguage, error);

  @JsonKey(ignore: true)
  @override
  _$OtpSmsStartResponseCopyWith<_OtpSmsStartResponse> get copyWith =>
      __$OtpSmsStartResponseCopyWithImpl<_OtpSmsStartResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OtpSmsStartResponseToJson(this);
  }
}

abstract class _OtpSmsStartResponse implements OtpSmsStartResponse {
  const factory _OtpSmsStartResponse(
      {String? phoneNumber,
      bool? phoneVerified,
      String? requestLanguage,
      String? error}) = _$_OtpSmsStartResponse;

  factory _OtpSmsStartResponse.fromJson(Map<String, dynamic> json) =
      _$_OtpSmsStartResponse.fromJson;

  @override
  String? get phoneNumber;
  @override
  bool? get phoneVerified;
  @override
  String? get requestLanguage;
  @override
  String? get error;
  @override
  @JsonKey(ignore: true)
  _$OtpSmsStartResponseCopyWith<_OtpSmsStartResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
