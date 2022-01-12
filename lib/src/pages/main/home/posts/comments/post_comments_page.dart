import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:involio/src/pages/main/home/posts/comments/bloc/post_comment_bloc.dart';
import 'package:involio/src/pages/main/home/posts/comments/post_comments_list.dart';
import 'package:involio/src/pages/main/home/posts/post_item.dart';
import 'package:involio/src/shared/blocs/user/cubit.dart';
import 'package:involio/src/shared/config/app_config.dart';
import 'package:involio/src/shared/widgets/image_widgets/app_image_builder.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
                    widget.userPost,
                    Expanded(
                      child: PostCommentsList(
                        postId: widget.userPost.postId,
                      ),
                    ),
                  ],
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
  @override
  void initState() {
    super.initState();
  }

  final _textFieldController = TextEditingController();
  late FocusScopeNode _currentFocus;
  String _maxInputLengthError = "";
  double _profileImageBottomPadding = 0;

  @override
  void dispose() {
    _textFieldController.dispose();
    _currentFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _currentFocus = FocusScope.of(context);

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
            _profileImageBottomPadding = state.maxCharactersMet ? 34 : 0;
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
          return Container(
            padding: EdgeInsets.only(
                left: 20, right: 20, top: 8, bottom: _bottomPadding),
            color: AppColors.involioFillFormBackgroundColor,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 40,
                minWidth: double.infinity,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: _profileImageBottomPadding),
                    child: const AppImageBuilder(
                      imageUrl: "",
                      height: 45,
                      width: 45,
                      radius: 7,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: TextField(
                        textAlignVertical: TextAlignVertical.bottom,
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 6,
                        maxLength: 2600,
                        cursorHeight: 16,
                        cursorColor: AppColors.involioWhiteShades80,
                        style: AppFonts.comments1.copyWith(
                          color: AppColors.involioWhiteShades80,
                        ),
                        controller: _textFieldController,
                        onChanged: (content) => context
                            .read<PostCommentBloc>()
                            .add(WritingPostCommentContentEvent(
                                content: _textFieldController.text)),
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          contentPadding: const EdgeInsets.all(8),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 1,
                              color: AppColors.involioWhiteShades80,
                              style: BorderStyle.solid,
                            ),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1,
                                color: AppColors.involioWhiteShades80),
                          ),
                          hintText: "add a comment",
                          hintStyle: AppFonts.comments1.copyWith(
                            color: AppColors.involioFillFormText,
                          ),
                          counterText: _maxInputLengthError,
                          counterStyle: AppFonts.comments1.copyWith(
                            color: AppColors.involioAssistiveAndAlertRed,
                          ),
                          suffixIcon: TextButton(
                            child: Text(
                              AppLocalizations.of(context)!.post,
                              style: AppFonts.numbers1.copyWith(
                                color: AppColors.involioFillFormText,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              minimumSize: const Size(0, 0),
                              padding: const EdgeInsets.all(4),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () => {
                              context.read<PostCommentBloc>().add(
                                    PostCommentPostButtonPressedEvent(
                                      postId: widget.post.postId,
                                      commentsCnt: state.commentsCnt ?? 0,
                                      content: _textFieldController.text,
                                    ),
                                  ),
                            },
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}


class ProfilePicture extends StatefulWidget {
  const ProfilePicture({Key? key}) : super(key: key);

  @override
  ProfilePictureState createState() => ProfilePictureState();
}

class ProfilePictureState extends State<ProfilePicture> {
  @override
  void initState() {
    super.initState();

    context.read<UserCubit>().getUser();
  }

  //ToDo get profile image
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
        builder: (context, UserState state) {
      String imageUrl =
          "${GetIt.I.get<AppConfig>().baseUrl}api/user/files/get_s3_image/ownerAvatar";

      return AppImageBuilder(
          imageUrl: imageUrl, height: 45, width: 45, radius: 7);
    });
  }
}
