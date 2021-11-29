import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'posts_filter_event.freezed.dart';
part 'posts_filter_event.g.dart';

PostsFilterEvent postsFilterEventFromJson(String str) => PostsFilterEvent.fromJson(json.decode(str));

String postsFilterEventToJson(PostsFilterEvent data) => json.encode(data.toJson());

@freezed
class PostsFilterEvent with _$PostsFilterEvent {
  const factory PostsFilterEvent({
    @Default("trending") String filterName,
  }) = _PostsFilterEvent;

  factory PostsFilterEvent.fromJson(Map<String, dynamic> json) => _$PostsFilterEventFromJson(json);
}
