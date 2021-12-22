import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:involio/src/router/router.gr.dart';
import 'package:involio/src/shared/widgets/appbar_widgets/logo_only_title_widget.dart';
import 'package:involio/src/theme/app_theme.dart';
import 'package:involio/src/theme/colors.dart';

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({Key? key}) : super(key: key);

  @override
  _GetStartedPageState createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: const LogoOnlyTitleWidget(),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),

            child: CustomScrollView(
              slivers: [
                /// SliverFillRemaining helps force terms of services
                /// to the bottom of the page
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 98),
                        Text(
                          AppLocalizations.of(context)!.welcome,
                          style: AppFonts.headline2.copyWith(color: AppColors.involioWhiteShades80),
                        ),
                        const SizedBox(height: 28),
                        SizedBox(
                          width: 130,
                          height: 48,
                          child: TextButton(
                            child: Text(
                              AppLocalizations.of(context)!.getStarted,
                              style: AppFonts.headline7.copyWith(color: AppColors.involioWhiteShades100),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                AppColors.involioBlue,
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                            onPressed: () => context.router.push(const SignUpRoute()),
                          ),
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              height: 80,
              color: AppColors.involioBackground.withOpacity(0.8),
              padding: const EdgeInsets.only(
                  left: 20, right: 0, top: 20, bottom: 20),
              child: Row(
                children: [
                  Text (AppLocalizations.of(context)!.accountExists,
                  style: AppFonts.headline6.copyWith(color: AppColors.involioWhiteShades80,),
                  ),
                  TextButton(
                    child: Text(AppLocalizations.of(context)!.logIn),
                    style: TextButton.styleFrom(primary: AppColors.involioBlue, textStyle: AppFonts.bodyBig,),
                    onPressed: () => context.router.push(const LoginRoute()),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
