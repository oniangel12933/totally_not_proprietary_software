import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'posts_filter_state.freezed.dart';
part 'posts_filter_state.g.dart';

PostsFilterState postsFilterStateFromJson(String str) => PostsFilterState.fromJson(json.decode(str));

String postsFilterStateToJson(PostsFilterState data) => json.encode(data.toJson());

@freezed
class PostsFilterState with _$PostsFilterState {
  const factory PostsFilterState({
    required String filterName,
  }) = _PostsFilterState;

  // const factory PostsFilterState.initial({
  //   @Default("trending") String filterName,
  // }) = InitialPostsFilterEvent;

  // const factory PostsFilterState.trending({
  //   @Default("interests") String filterName,
  // }) = InitialPostsFilterEvent;

  factory PostsFilterState.fromJson(Map<String, dynamic> json) => _$PostsFilterStateFromJson(json);
}
