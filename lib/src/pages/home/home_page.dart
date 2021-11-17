import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class HomePage extends StatefulWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static final titles = ['Home', 'Search', 'Settings', 'Info', 'Profile'];

  late PlatformTabController tabController;

  late List<Widget> tabs;

  @override
  void initState() {
    super.initState();

    // If you want further control of the tabs have one of these
    tabController = PlatformTabController(
      initialIndex: 1,
    );

    tabs = [
      const HomeTab(),
      const SearchTab(),
      const SettingTab(),
      const InfoTab(),
      const ProfileTab(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PlatformTabScaffold(
      iosContentPadding: true,
      tabController: tabController,
      appBarBuilder: (_, index) => PlatformAppBar(
        //title: const Text('Page Title'),
        trailingActions: <Widget>[
          PlatformIconButton(
            padding: EdgeInsets.zero,
            icon: Icon(context.platformIcons.share),
            onPressed: () {},
          ),
        ],
        cupertino: (_, __) => CupertinoNavigationBarData(
          //title: Text('titles: ${titles[index]}'),
          title: const Text('Not Financial Advice'),
        ),
        material: (_, __) => MaterialAppBarData(
          //title: Text('titles: ${titles[index]}'),
          title: const Text('Not Financial Advice'),
        ),
      ),
      bodyBuilder: (context, index) => IndexedStack(
        index: index,
        children: tabs,
      ),
      items: [
        BottomNavigationBarItem(
          label: titles[0],
          icon: Icon(context.platformIcons.home),
        ),
        BottomNavigationBarItem(
          label: titles[1],
          icon: Icon(context.platformIcons.search),
        ),
        BottomNavigationBarItem(
          label: titles[2],
          icon: Icon(context.platformIcons.addCircledOutline),
        ),
        BottomNavigationBarItem(
          label: titles[3],
          icon: Icon(context.platformIcons.info),
        ),
        BottomNavigationBarItem(
          label: titles[4],
          icon: Icon(context.platformIcons.personOutline),
        ),
      ],
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Home Tab'),
    );
  }
}

class SearchTab extends StatelessWidget {
  const SearchTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Search Tab'),
    );
  }
}

class SettingTab extends StatelessWidget {
  const SettingTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Settings Tab'),
    );
  }
}

class InfoTab extends StatelessWidget {
  const InfoTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Info Tab'),
    );
  }
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Profile Tab'),
    );
  }
}