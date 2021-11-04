// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'otp_sms_start_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

OtpSmsStartRequest _$OtpSmsStartRequestFromJson(Map<String, dynamic> json) {
  return _OtpSmsStartRequest.fromJson(json);
}

/// @nodoc
class _$OtpSmsStartRequestTearOff {
  const _$OtpSmsStartRequestTearOff();

  _OtpSmsStartRequest call({required String phone}) {
    return _OtpSmsStartRequest(
      phone: phone,
    );
  }

  OtpSmsStartRequest fromJson(Map<String, Object?> json) {
    return OtpSmsStartRequest.fromJson(json);
  }
}

/// @nodoc
const $OtpSmsStartRequest = _$OtpSmsStartRequestTearOff();

/// @nodoc
mixin _$OtpSmsStartRequest {
  String get phone => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OtpSmsStartRequestCopyWith<OtpSmsStartRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OtpSmsStartRequestCopyWith<$Res> {
  factory $OtpSmsStartRequestCopyWith(
          OtpSmsStartRequest value, $Res Function(OtpSmsStartRequest) then) =
      _$OtpSmsStartRequestCopyWithImpl<$Res>;
  $Res call({String phone});
}

/// @nodoc
class _$OtpSmsStartRequestCopyWithImpl<$Res>
    implements $OtpSmsStartRequestCopyWith<$Res> {
  _$OtpSmsStartRequestCopyWithImpl(this._value, this._then);

  final OtpSmsStartRequest _value;
  // ignore: unused_field
  final $Res Function(OtpSmsStartRequest) _then;

  @override
  $Res call({
    Object? phone = freezed,
  }) {
    return _then(_value.copyWith(
      phone: phone == freezed
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$OtpSmsStartRequestCopyWith<$Res>
    implements $OtpSmsStartRequestCopyWith<$Res> {
  factory _$OtpSmsStartRequestCopyWith(
          _OtpSmsStartRequest value, $Res Function(_OtpSmsStartRequest) then) =
      __$OtpSmsStartRequestCopyWithImpl<$Res>;
  @override
  $Res call({String phone});
}

/// @nodoc
class __$OtpSmsStartRequestCopyWithImpl<$Res>
    extends _$OtpSmsStartRequestCopyWithImpl<$Res>
    implements _$OtpSmsStartRequestCopyWith<$Res> {
  __$OtpSmsStartRequestCopyWithImpl(
      _OtpSmsStartRequest _value, $Res Function(_OtpSmsStartRequest) _then)
      : super(_value, (v) => _then(v as _OtpSmsStartRequest));

  @override
  _OtpSmsStartRequest get _value => super._value as _OtpSmsStartRequest;

  @override
  $Res call({
    Object? phone = freezed,
  }) {
    return _then(_OtpSmsStartRequest(
      phone: phone == freezed
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_OtpSmsStartRequest implements _OtpSmsStartRequest {
  const _$_OtpSmsStartRequest({required this.phone});

  factory _$_OtpSmsStartRequest.fromJson(Map<String, dynamic> json) =>
      _$$_OtpSmsStartRequestFromJson(json);

  @override
  final String phone;

  @override
  String toString() {
    return 'OtpSmsStartRequest(phone: $phone)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OtpSmsStartRequest &&
            (identical(other.phone, phone) || other.phone == phone));
  }

  @override
  int get hashCode => Object.hash(runtimeType, phone);

  @JsonKey(ignore: true)
  @override
  _$OtpSmsStartRequestCopyWith<_OtpSmsStartRequest> get copyWith =>
      __$OtpSmsStartRequestCopyWithImpl<_OtpSmsStartRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OtpSmsStartRequestToJson(this);
  }
}

abstract class _OtpSmsStartRequest implements OtpSmsStartRequest {
  const factory _OtpSmsStartRequest({required String phone}) =
      _$_OtpSmsStartRequest;

  factory _OtpSmsStartRequest.fromJson(Map<String, dynamic> json) =
      _$_OtpSmsStartRequest.fromJson;

  @override
  String get phone;
  @override
  @JsonKey(ignore: true)
  _$OtpSmsStartRequestCopyWith<_OtpSmsStartRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
