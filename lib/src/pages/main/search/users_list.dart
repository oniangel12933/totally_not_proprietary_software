import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:involio/src/pages/main/search/trending_user_card.dart';
import 'package:involio/src/theme/colors.dart';
import 'bloc/trending_user_cubit.dart';

class TrendingUserList extends StatefulWidget {
  const TrendingUserList({Key? key}) : super(key: key);

  @override
  _TrendingUserListState createState() => _TrendingUserListState();
}

class _TrendingUserListState extends State<TrendingUserList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrendingUserCubit, TrendingUserState>(
        builder: (context, TrendingUserState state) {
          return ListView.separated(
              itemCount: state.data.length,
              separatorBuilder: (BuildContext context, int index) => Container(
                padding: const EdgeInsets.only(top: 16, bottom: 16),
                child:
                Divider(height: 1, color: AppColors.involioLineSeparator),
              ),
              itemBuilder: (BuildContext context, int index) {
                return UserCard(user: state.data[index], index: index);
              });
        });
  }
}
