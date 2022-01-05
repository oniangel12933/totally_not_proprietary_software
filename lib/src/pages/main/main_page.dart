import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:involio/src/pages/main/pages.dart';
import 'package:involio/src/pages/main/search/search_view.dart';
import 'package:involio/src/shared/icons/involio_action_icon.dart';
import 'package:involio/src/shared/icons/involio_icons.dart';
import 'package:involio/src/shared/widgets/appbar_widgets/logo_only_title_widget.dart';
import 'package:involio/src/shared/widgets/fade_indexed_stack.dart';
import 'package:involio/src/shared/widgets/unfocus_widget.dart';
import 'package:involio/src/theme/app_theme.dart';
import 'package:involio/src/theme/colors.dart';
import 'home/home_view.dart';
import 'main_bottom_nav_modal.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    _pages = [
      const HomeView(),
      const SearchView(),
      const SettingTab(),
      const InfoTab(),
      const ProfileTab(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    Widget titleWidget = const LogoOnlyTitleWidget(); //ToDo change involio icon colors

    late final List<Widget> _titles = [
      titleWidget,
      Text(
        AppLocalizations.of(context)!.discover,
        style: AppFonts.body.copyWith(color: AppColors.involioWhiteShades80),
      ),
      titleWidget,
      titleWidget,
      titleWidget
    ];

    return UnFocusWidget(
      child: Scaffold(
        appBar: AppBar(
          //elevation: 0,
          centerTitle: true,
          title: _titles[currentIndex],
          leading: IconButton(
            icon: Icon(context.involioIcons.menu),
            color: AppColors.involioWhiteShades80,
            onPressed: () {
              isMaterial(context)
                  ? showMaterialModalBottomSheet(
                      expand: false,
                      context: context,
                      barrierColor: Colors.black.withOpacity(0.5),
                      //backgroundColor: Colors.transparent,
                      builder: (context) => const MainBottomNavModal(),
                    )
                  : showCupertinoModalBottomSheet(
                      expand: false,
                      context: context,
                      //backgroundColor: Colors.green,
                      //backgroundColor: Colors.transparent,
                      barrierColor: Colors.black.withOpacity(0.5),
                      builder: (context) => const MainBottomNavModal(),
                    );
            },
          ),
          actions: <Widget>[
            IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(context.involioIcons.followUser),
              color: AppColors.involioWhiteShades80,
              onPressed: () {},
            ),
            IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(context.involioIcons.bell),
              color: AppColors.involioWhiteShades80,
              onPressed: () {},
            ),
          ],
        ),
        body: FadeIndexedStack(
          index: currentIndex,
          children: _pages,
          duration: const Duration(
            milliseconds: 50,
          ),
        ),
        bottomNavigationBar: bottomItems(),
      ),
    );
  }

  Widget bottomItems() {
    return Theme(
      data: Theme.of(context).copyWith(
          //splashColor: Colors.transparent,
          //highlightColor: Colors.transparent,
          //hoverColor: Colors.transparent,
          ),
      child: BottomNavigationBar(
        //enableFeedback: true,
        showSelectedLabels: false,
        showUnselectedLabels: false,

        /// fontsize 0.0 Prevents an exception for a flutter bug
        /// when show labels is false
        /// https://github.com/flutter/flutter/issues/86545
        backgroundColor: AppColors.involioFooterBackground,
        unselectedFontSize: 0.0,
        selectedFontSize: 0.0,
        elevation: 0.5,
        onTap: (int index) {
          setState(() {
            if (index != 2) {
              currentIndex = index;
            } else {
              // todo: pop up edit post sheet
            }
          });
          // pageController.animateToPage(
          //   index,
          //   duration: Duration(
          //     milliseconds: 200,
          //   ),
          //   curve: Curves.easeIn,
          // );
        },
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              context.involioIcons.home,
              color: AppColors.involioWhiteShades80,
            ),
            activeIcon: Icon(
              context.involioIcons.home,
              color: AppColors.involioBlue,
            ),
            label: AppLocalizations.of(context)!.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              context.involioIcons.search,
              color: AppColors.involioWhiteShades80,
            ),
            activeIcon: Icon(
              context.involioIcons.search,
              color: AppColors.involioBlue,
            ),
            label: AppLocalizations.of(context)!.search,
          ),
          BottomNavigationBarItem(
            icon: getInvolioActionButtonIcon(context),
            label: AppLocalizations.of(context)!.add,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              context.involioIcons.chartLine,
              color: AppColors.involioWhiteShades80,
            ),
            activeIcon: Icon(
              context.involioIcons.chartLine,
              color: AppColors.involioBlue,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              context.involioIcons.profile,
              color: AppColors.involioWhiteShades80,
            ),
            activeIcon: Icon(
              context.involioIcons.profile,
              color: AppColors.involioBlue,
            ),
            label: AppLocalizations.of(context)!.profile,
          ),
        ],
      ),
    );
  }
}
