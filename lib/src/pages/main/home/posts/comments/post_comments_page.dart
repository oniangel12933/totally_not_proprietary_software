import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:involio/src/pages/main/home/posts/comments/bloc/post_comment_bloc.dart';
import 'package:involio/src/pages/main/home/posts/comments/post_comments_list.dart';
import 'package:involio/src/pages/main/home/posts/post_item.dart';
import 'package:involio/src/shared/blocs/user/cubit.dart';
import 'package:involio/src/shared/config/app_config.dart';
import 'package:involio/src/shared/widgets/image_widgets/app_image_builder.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
              child: CommentsList(
                postId: widget.userPost.postId,
              ),
            ),
          ],
        ),
        bottomNavigationBar: AddCommentWidget(
          post: widget.userPost,
        ),
      ),
    );
  }
}

class AddCommentWidget extends StatelessWidget {
  final UserPost post;

  const AddCommentWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _textFieldController = TextEditingController();

    return BlocListener<PostCommentBloc, PostCommentState>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) {
        if (state is PostCommentPostedSuccessfullyState) {
          _textFieldController.clear();
          (post.key as GlobalKey<UserPostState>)
              .currentState
              ?.incrementCommentCount();
        }
      },
      child: BlocBuilder<PostCommentBloc, PostCommentState>(
        builder: (context, state) {
          return Container(
            // height: 103,
            // width: double.infinity,
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 50),
            color: AppColors.involioFillFormBackgroundColor,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 40,
                minWidth: double.infinity,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const AppImageBuilder(
                    imageUrl: "",
                    height: 45,
                    width: 45,
                    radius: 7,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: TextField(
                        textAlignVertical: TextAlignVertical.bottom,
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 15,
                        cursorHeight: 16,
                        cursorColor: AppColors.involioWhiteShades80,
                        style: AppFonts.comments1.copyWith(
                          color: AppColors.involioWhiteShades80,
                        ),
                        controller: _textFieldController,
                        // onChanged: (content) => context
                        //     .read<PostCommentBloc>()
                        //     .add(WritingContent(content: content)),
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
                                      postId: state.postId ?? "",
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
          "${AppConfig().baseUrl}api/user/files/get_s3_image/ownerAvatar";

      return AppImageBuilder(
          imageUrl: imageUrl, height: 45, width: 45, radius: 7);
    });
  }
}
