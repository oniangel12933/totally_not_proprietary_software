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

class MaxContentLengthReachedState extends PostCommentState {
  final bool maxCharactersMet;

  const MaxContentLengthReachedState({
    required this.maxCharactersMet,
  });

  @override
  List<Object?> get props => [
    maxCharactersMet,
    content,
  ];
}

class IsPostingCommentState extends PostCommentState {}

class PostCommentPostedSuccessfullyState extends PostCommentState {
  final String postId;
  final String commentId;
  final int commentsCnt;
  final String content;

  const PostCommentPostedSuccessfullyState({
    required this.postId,
    required this.commentId,
    required this.commentsCnt,
    required this.content,
  });

  @override
  List<Object?> get props => [
    commentId,
    commentsCnt,
    content,
  ];
}

class PostCommentFailedToPostState extends PostCommentState {
  final String error;

  const PostCommentFailedToPostState({
    required this.error,
  });
}
