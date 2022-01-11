part of 'post_comment_bloc.dart';

abstract class PostCommentEvent extends Equatable {
  const PostCommentEvent();

  @override
  List<Object?> get props => [];
}

class WritingPostCommentContentEvent extends PostCommentEvent {
  final String content;

  const WritingPostCommentContentEvent({
    required this.content,
  });

  @override
  List<Object> get props => [content];
}

class PostCommentPostButtonPressedEvent extends PostCommentEvent {
  final String postId;
  final int commentsCnt;
  final String content;

  const PostCommentPostButtonPressedEvent({
    required this.postId,
    required this.commentsCnt,
    required this.content,
  });

  @override
  List<Object?> get props => [commentsCnt, content];
}
