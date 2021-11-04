import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User(final String id, {
    @Default('-') String name,
    @Default(0) int age,
    @Default(0) int coolness,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  String toString() {
    return "Name = $name";
  }

  static const empty = User('-', name: '');
}