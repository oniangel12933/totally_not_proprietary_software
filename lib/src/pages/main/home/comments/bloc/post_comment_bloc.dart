import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:involio/gen/involio_api.swagger.dart';
import 'package:involio/src/repositories/api/comments/comments_repository.dart';

part 'post_comment_event.dart';

part 'post_comment_state.dart';

class PostCommentBloc extends Bloc<PostCommentEvent, PostCommentState> {
  final String? postId;
  final int? commentsCnt;
  final String? content;

  PostCommentBloc({this.postId, this.commentsCnt, this.content})
      : super(PostCommentState(
          postId: postId,
          commentsCnt: commentsCnt,
        )) {
    on<PostingComment>(_posting);
  }

  Future<void> _posting(
    PostingComment event,
    Emitter<PostCommentState> emit,
  ) async {
    if (event.content.isEmpty) {
      return;
    }

    emit(IsPostingComment());

    try {
      CommentsRepository _commentsRepository =
          GetIt.I.get<CommentsRepository>();
      CommentResponse response = await _commentsRepository.createPostComment(
        content: event.content,
        postId: event.postId,
      );

      if (response.success == true) {
        emit(CommentSuccessful(
          postId: event.postId,
          commentsCnt: event.commentsCnt + 1,
          content: event.content,
        ));
      } else {
        emit(const CommentFailed(error: "Posting Comment Failed"));
      }
    } catch (error) {
      emit(CommentFailed(error: "$error"));
    }
  }
}
