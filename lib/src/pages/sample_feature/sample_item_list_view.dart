import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:insidersapp/src/pages/profile/profile_page.dart';
import 'package:insidersapp/src/pages/settings/settings_controller.dart';
import 'package:insidersapp/src/router/router.gr.dart';
import 'package:provider/src/provider.dart';
import '../settings/settings_page.dart';
import 'sample_item.dart';
import 'sample_item_details_view.dart';

/// Displays a list of SampleItems.
class SampleItemListPage extends StatelessWidget {
  const SampleItemListPage({
    Key? key,
  }) : super(key: key);

  final List<SampleItem> items = const [
    SampleItem(1),
    SampleItem(2),
    SampleItem(3)
  ];

  @override
  Widget build(BuildContext context) {
    return SampleItemListPage2(items: items);
  }
}

/// Displays a list of SampleItems.
class SampleItemListPage2 extends StatelessWidget {
  const SampleItemListPage2({
    Key? key,
    this.items = const [SampleItem(1), SampleItem(2), SampleItem(3)],
  }) : super(key: key);

  final List<SampleItem> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Items'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              //Navigator.restorablePushNamed(context, SettingsView.routeName);
              //context.router.push(SettingsRoute(controller: context.read<SettingsController>()));
              context.router.push(const SettingsRoute());
            },
          ),
        ],
      ),

      // To work with lists that may contain a large number of items, it’s best
      // to use the ListView.builder constructor.
      //
      // In contrast to the default ListView constructor, which requires
      // building all Widgets up front, the ListView.builder constructor lazily
      // builds Widgets as they’re scrolled into view.
      body: Column(
        children: [
          const ProfilePage(),
          Expanded(
            child: ListView.builder(
              // Providing a restorationId allows the ListView to restore the
              // scroll position when a user leaves and returns to the app after it
              // has been killed while running in the background.
              restorationId: 'sampleItemListView',
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                final item = items[index];

                return ListTile(
                    title: Text('SampleItem ${item.id}'),
                    leading: const CircleAvatar(
                      // Display the Flutter Logo image asset.
                      foregroundImage:
                          AssetImage('assets/images/flutter_logo.png'),
                    ),
                    onTap: () {
                      // Navigate to the details page. If the user leaves and returns to
                      // the app after it has been killed while running in the
                      // background, the navigation stack is restored.
                      Navigator.restorablePushNamed(
                        context,
                        SampleItemDetailsView.routeName,
                      );
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}
