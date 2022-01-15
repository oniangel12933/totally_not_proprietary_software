import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';

import 'package:involio/gen/involio_api.swagger.dart';
import 'package:involio/src/pages/main/home/posts/comments/bloc/post_comment_bloc.dart';
import 'package:involio/src/pages/main/home/posts/comments/post_comments_list.dart';
import 'package:involio/src/pages/main/home/posts/post_item.dart';
import 'package:involio/src/repositories/api/user/user_repository.dart';
import 'package:involio/src/shared/widgets/image_widgets/app_image_builder.dart';
import 'package:involio/src/shared/widgets/unfocus_widget.dart';
import 'package:involio/src/theme/app_theme.dart';
import 'package:involio/src/theme/colors.dart';
import '../../posts/post_item.dart';

class PostCommentsPage extends StatefulWidget {
  final UserPost userPost;

  const PostCommentsPage({
    Key? key,
    required this.userPost,
  }) : super(key: key);

  @override
  _PostCommentsPageState createState() => _PostCommentsPageState();
}

class _PostCommentsPageState extends State<PostCommentsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostCommentBloc(
        postId: widget.userPost.postId,
        commentsCnt: widget.userPost.commentsCnt,
      ),
      child: Material(
        child: Stack(
          children: [
            UnFocusWidget(
              child: Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  centerTitle: true,
                  title: Text(AppLocalizations.of(context)!.comments,
                      style: AppFonts.body
                          .copyWith(color: AppColors.involioWhiteShades80)),
                ),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        widget.userPost,
                        const Divider(
                            height: 1, color: AppColors.involioLineSeparator)
                      ],
                    ),
                    Expanded(
                      child: PostCommentsList(
                        postId: widget.userPost.postId,
                      ),
                    ),
                  ],
                ),
                bottomNavigationBar: Container(
                  /// this NavBar adjusts the padding behind the
                  /// Comments input to ensure the last comment is not hidden behind the keyboard
                  height: MediaQuery.of(context).viewInsets.bottom > 0
                      ? MediaQuery.of(context).viewInsets.bottom + 60
                      : MediaQuery.of(context).viewInsets.bottom + 100,
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: PostCommentInput(
                post: widget.userPost,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PostCommentInput extends StatefulWidget {
  final UserPost post;

  const PostCommentInput({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  _PostCommentInputState createState() => _PostCommentInputState();
}

class _PostCommentInputState extends State<PostCommentInput> {
  late TextEditingController _textFieldController;
  late FocusNode _currentFocus;
  late UserBaseResponse userResponse;
  String _maxInputLengthError = "";
  double _maxInputLengthErrorPadding = 0;

  Future<void> _getUser() async {
    userResponse = await GetIt.I.get<UserRepository>().getUser();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getUser();
    _textFieldController = TextEditingController();
    _currentFocus = FocusNode();
    userResponse = UserBaseResponse();
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    _currentFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// if keyboard is not focused adds bottom padding to textfield
    double _bottomPadding = MediaQuery.of(context).viewInsets.bottom != 0
        ? MediaQuery.of(context).viewInsets.bottom.toDouble() + 8
        : 50;

    return BlocListener<PostCommentBloc, PostCommentState>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) {
        if (state is MaxContentLengthReachedState) {
          setState(() {
            _maxInputLengthError =
                state.maxCharactersMet ? "max character limit met" : "";
            _maxInputLengthErrorPadding = state.maxCharactersMet ? 20 : 0;
          });
        } else if (state is PostCommentPostedSuccessfullyState) {
          _currentFocus.unfocus();
          _textFieldController.clear();
          (widget.post.key as GlobalKey<UserPostState>)
              .currentState
              ?.incrementCommentCount();
        }
      },
      child: BlocBuilder<PostCommentBloc, PostCommentState>(
        builder: (context, state) {
          return ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Container(
                color: AppColors.involioFillFormBackgroundColor,
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.only(
                    left: 20, right: 20, top: 8, bottom: _bottomPadding),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const AppCurrentUserProfileImageBuilder(
                            size: AppImageSize.small),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            constraints: const BoxConstraints(minHeight: 38),
                            decoration: BoxDecoration(
                              color: AppColors.involioFillFormBackgroundColor,
                              border: Border.all(
                                color: AppColors.involioWhiteShades80,
                                style: BorderStyle.solid,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: TextField(
                                    textAlignVertical: TextAlignVertical.bottom,
                                    keyboardType: TextInputType.multiline,
                                    minLines: 1,
                                    maxLines: 6,
                                    maxLength: 2600,
                                    cursorColor: AppColors.involioWhiteShades80,
                                    style: AppFonts.comments1.copyWith(
                                      color: AppColors.involioWhiteShades80,
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      alignLabelWithHint: true,
                                      isDense: true,
                                      contentPadding: const EdgeInsets.only(
                                          bottom: 6, left: 8),
                                      hintText:
                                          "Add a comment as ${userResponse.name}",
                                      hintStyle: AppFonts.comments1.copyWith(
                                        color: AppColors.involioFillFormText,
                                      ),
                                      counterText: "",
                                    ),
                                    controller: _textFieldController,
                                    onChanged: (content) => context
                                        .read<PostCommentBloc>()
                                        .add(
                                          WritingPostCommentContentEvent(
                                            content: _textFieldController.text,
                                          ),
                                        ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () => {
                                    context.read<PostCommentBloc>().add(
                                          PostCommentPostButtonPressedEvent(
                                            postId: widget.post.postId,
                                            commentsCnt: state.commentsCnt ?? 0,
                                            content: _textFieldController.text,
                                          ),
                                        ),
                                  },
                                  style: TextButton.styleFrom(
                                    minimumSize: const Size(0, 0),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 6, horizontal: 8),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: Text(
                                    AppLocalizations.of(context)!.post,
                                    style: AppFonts.numbers1.copyWith(
                                      color: AppColors.involioFillFormText,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: _maxInputLengthErrorPadding,
                      alignment: Alignment.centerRight,
                      child: Text(
                        _maxInputLengthError,
                        style: AppFonts.comments1.copyWith(
                          color: AppColors.involioAssistiveAndAlertRed,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
