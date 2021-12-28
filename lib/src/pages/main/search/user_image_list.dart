import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:involio/src/pages/main/search/user_image_card.dart';
import 'bloc/trending_user_cubit.dart';

class UserImageList extends StatelessWidget {
  const UserImageList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //margin: const EdgeInsets.all(10.0),
      height: 114.0,
      child: BlocBuilder<TrendingUserCubit, TrendingUserState>(
        builder: (context, TrendingUserState state) {
          return ListView.separated(
            itemCount: state.data.length,
            separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(
              width: 20,
            ),
            itemBuilder: (BuildContext context, int index) {
              return UserImageCard(
                name: state.data[index].name,
                avatar: state.data[index].ownerAvatar,
              );
            },
            scrollDirection: Axis.horizontal,
          );
        },
      ),
    );
  }
}
