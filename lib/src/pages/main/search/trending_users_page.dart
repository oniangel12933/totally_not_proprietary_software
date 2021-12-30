import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:involio/src/pages/main/search/users_list.dart';
import 'package:involio/src/theme/app_theme.dart';
import 'package:involio/src/theme/colors.dart';
import 'bloc/trending_user_cubit.dart';

class TrendingUsersPage extends StatelessWidget {
  const TrendingUsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.top20Users,
          style: AppFonts.body.copyWith(color: AppColors.involioWhiteShades80),
        ),
      ),
      body: BlocProvider(
        create: (context) => TrendingUserCubit(pageSize: 20),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Text(
                    AppLocalizations.of(context)!.trendingUsers,
                    style: AppFonts.headline6
                        .copyWith(color: AppColors.involioWhiteShades60),
                  )),
              const Expanded(
                child: TrendingUserList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
