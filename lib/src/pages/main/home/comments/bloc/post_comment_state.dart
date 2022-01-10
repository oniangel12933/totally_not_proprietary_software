part of 'post_comment_bloc.dart';

class PostCommentState extends Equatable {
  final String? postId;
  final int? commentsCnt;
  final String? content;

  const PostCommentState({
    this.postId,
    this.commentsCnt,
    this.content,
  });

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        postId,
        commentsCnt,
        content,
      ];

  PostCommentState copyWith({
    int? commentsCnt,
    String? content,
  }) {
    return PostCommentState(
      postId: postId,
      commentsCnt: commentsCnt ?? this.commentsCnt,
      content: content ?? this.content,
    );
  }
}

class IsPostingComment extends PostCommentState {}

class CommentSuccessful extends PostCommentState {
  final String postId;
  final int commentsCnt;
  final String content;

  const CommentSuccessful({
    required this.postId,
    required this.commentsCnt,
    required this.content,
  });
}

class CommentFailed extends PostCommentState {
  final String error;

  const CommentFailed({
    required this.error,
  });
}
