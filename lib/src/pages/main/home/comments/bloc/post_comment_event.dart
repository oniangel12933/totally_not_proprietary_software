part of 'post_comment_bloc.dart';

abstract class PostCommentEvent extends Equatable {
  const PostCommentEvent();

  @override
  List<Object?> get props => [];
}

class WritingContent extends PostCommentEvent {
  final String content;

  const WritingContent({
    required this.content,
  });

  @override
  List<Object> get props => [content];
}

class PostingComment extends PostCommentEvent {
  final String postId;
  final int commentsCnt;
  final String content;

  const PostingComment({
    required this.postId,
    required this.commentsCnt,
    required this.content,
  });

  @override
  List<Object?> get props => [commentsCnt, content];
}
