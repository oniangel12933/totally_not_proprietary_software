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
    on<WritingPostCommentContentEvent>(_writingContent);
    on<PostCommentPostButtonPressedEvent>(_postingComment);
  }

  Future<void> _writingContent(
    WritingPostCommentContentEvent event,
    Emitter<PostCommentState> emit,
  ) async {
    emit(MaxContentLengthReachedState(
        maxCharactersMet: event.content.length == 2600));
  }

  Future<void> _postingComment(
    PostCommentPostButtonPressedEvent event,
    Emitter<PostCommentState> emit,
  ) async {
    if (event.content.isEmpty) {
      return;
    }

    emit(IsPostingCommentState());

    try {
      CommentsRepository _commentsRepository =
          GetIt.I.get<CommentsRepository>();
      CommentResponse response = await _commentsRepository.createPostComment(
        content: event.content,
        postId: event.postId,
      );

      if (response.success == true) {
        emit(PostCommentPostedSuccessfullyState(
          postId: event.postId,
          commentsCnt: event.commentsCnt + 1,
          content: event.content,
        ));
      } else {
        emit(const PostCommentFailedToPostState(
            error: "Posting Comment Failed"));
      }
    } catch (error) {
      emit(PostCommentFailedToPostState(error: "$error"));
    }
  }
}
