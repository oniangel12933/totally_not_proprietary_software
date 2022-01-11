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

class IsPostingCommentState extends PostCommentState {}

class PostCommentPostedSuccessfullyState extends PostCommentState {
  final String postId;
  final int commentsCnt;
  final String content;

  const PostCommentPostedSuccessfullyState({
    required this.postId,
    required this.commentsCnt,
    required this.content,
  });
}

class PostCommentFailedToPostState extends PostCommentState {
  final String error;

  const PostCommentFailedToPostState({
    required this.error,
  });
}
