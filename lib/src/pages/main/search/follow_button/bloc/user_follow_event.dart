import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_follow_event.freezed.dart';
part 'user_follow_event.g.dart';

UserFollowEvent userFollowEventFromJson(String str) => UserFollowEvent.fromJson(json.decode(str));

String userFollowEventToJson(UserFollowEvent data) => json.encode(data.toJson());

@freezed
class UserFollowEvent with _$UserFollowEvent {
  const factory UserFollowEvent.buttonPressed({
    String? userId,
    bool? wasFollowing,
    int? followersCntWas,
  }) = UserFollowButtonPressedEvent;

  factory UserFollowEvent.fromJson(Map<String, dynamic> json) => _$UserFollowEventFromJson(json);
}

