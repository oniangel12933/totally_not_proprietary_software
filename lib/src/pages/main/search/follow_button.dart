import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:involio/src/pages/main/search/bloc/user_follow_bloc.dart';
import 'package:involio/src/pages/main/search/bloc/user_follow_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:involio/src/theme/app_theme.dart';
import 'package:involio/src/theme/colors.dart';
import 'package:numeral/numeral.dart';

class OptimisticFollowButton extends StatefulWidget {
  final String? userId;
  final bool? isFollowing;
  final int? followers;

  const OptimisticFollowButton({
    Key? key,
    required this.userId,
    required this.isFollowing,
    required this.followers,
  }) : super(key: key);

  @override
  _OptimisticFollowButtonState createState() => _OptimisticFollowButtonState();
}

class _OptimisticFollowButtonState extends State<OptimisticFollowButton> {
  late final UserFollowBloc _userFollowBloc;

  @override
  void initState() {
    _userFollowBloc = UserFollowBloc(
      userId: widget.userId,
      isFollowing: widget.isFollowing,
      followersCnt: widget.followers,
    );

    super.initState();
  }

  @override
  void dispose() {
    _userFollowBloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserFollowBloc, UserFollowState>(
        bloc: _userFollowBloc,
        builder: (BuildContext context, UserFollowState followedState) {
          if (followedState.error != null) {}

          return SizedBox(
            height: 19.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(Numeral(followedState.followersCnt).value(fractionDigits: 1),
                    style: AppFonts.numbers1.copyWith(
                      color: AppColors.involioWhiteShades80,
                    )),
                const SizedBox(width: 4),
                Text(AppLocalizations.of(context)!.followers,
                    style: AppFonts.numbers1.copyWith(
                      color: AppColors.involioGreenGrayBlue,
                    )),
                const SizedBox(width: 4),
                Text("•",
                    style: AppFonts.numbers1.copyWith(
                      color: AppColors.involioWhiteShades80,
                    )),
                const SizedBox(width: 4),
                TextButton(
                  style: TextButton.styleFrom(
                    minimumSize: const Size(0, 0),
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () {
                    _userFollowBloc.followButtonPressed(
                      userId: followedState.userId,
                      wasFollowing: followedState.isFollowing,
                      followersCntWas: followedState.followersCnt,
                    );
                    //widget.isFollowed = followedState.isFollowing;
                  },
                  child: Text(
                      followedState.isFollowing
                          ? AppLocalizations.of(context)!.following
                          : AppLocalizations.of(context)!.follow,
                      style: AppFonts.numbers1.copyWith(
                        color: AppColors.involioWhiteShades80,
                      )),
                ),
              ],
            ),
          );
        });
  }
}
