import 'package:flutter/material.dart';

import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:insidersapp/src/pages/main/pages.dart';
import 'package:insidersapp/src/pages/main/search/search_view.dart';
import 'package:insidersapp/src/shared/icons/involio_action_icon.dart';
import 'package:insidersapp/src/shared/icons/involio_icons.dart';
import 'package:insidersapp/src/shared/widgets/appbar_widgets/logo_only_title_widget.dart';
import 'package:insidersapp/src/shared/widgets/fade_indexed_stack.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
  late final List<Widget> _titles;

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
    Widget titleWidget = const LogoOnlyTitleWidget();
    _titles = [
      titleWidget,
      const Text("Discover"),
      titleWidget,
      titleWidget,
      titleWidget
    ];
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        //elevation: 0,
        centerTitle: true,
        title: _titles[currentIndex],
        leading: IconButton(
          icon: Icon(context.involioIcons.menu),
          onPressed: () {
            isMaterial(context) ? showMaterialModalBottomSheet(
              expand: false,
              context: context,
              barrierColor: Colors.black.withOpacity(0.5),
              //backgroundColor: Colors.transparent,
              builder: (context) => const MainBottomNavModal(),
            ) : showCupertinoModalBottomSheet(
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
            onPressed: () {},
          ),
          IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(context.involioIcons.bell),
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
            icon: Icon(context.involioIcons.home),
            //activeIcon: Icon(context.involioIcons.homeFill),
            label: AppLocalizations.of(context)!.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(context.involioIcons.search),
            //activeIcon: Icon(context.involioIcons.searchFill),
            label: AppLocalizations.of(context)!.search,
          ),
          BottomNavigationBarItem(
            icon: getInvolioActionButtonIcon(context),
            label: AppLocalizations.of(context)!.add,
          ),
          BottomNavigationBarItem(
            icon: Icon(context.involioIcons.chartLine),
            //activeIcon: Icon(context.involioIcons.chartLineFill),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(context.involioIcons.account),
            //activeIcon: Icon(context.involioIcons.accountFill),
            label: AppLocalizations.of(context)!.account,
          ),
        ],
      ),
    );
  }
}
