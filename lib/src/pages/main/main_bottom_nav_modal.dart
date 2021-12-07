import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'package:insidersapp/src/router/router.gr.dart';
import 'package:insidersapp/src/shared/icons/involio_icons.dart';
import 'package:insidersapp/src/theme/colors.dart';

class MainBottomNavModal extends StatelessWidget {
  const MainBottomNavModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: (Theme.of(context).brightness == Brightness.dark)
          ? AppColors.involioBackground
          : AppColors.involioLightBackground,
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: 10,),
            ListTile(
              title: const Text('Account'),
              leading: Icon(context.involioIcons.account),
              onTap: () => Navigator.of(context).pop(),
            ),
            ListTile(
              title: const Text('Settings'),
              leading: Icon(context.involioIcons.settings),
              onTap: () {
                Navigator.of(context).pop();
                context.router.push(const SettingsRoute());
              },
            ),
            ListTile(
                title: const Text('Notifications'),
                leading: Icon(context.involioIcons.bell),
                onTap: () {
                  Navigator.of(context).pop();
                  //context.router.push(const TestCupertinoRoute());
                }),
            ListTile(
              title: const Text('My Interests'),
              leading: Icon(context.involioIcons.interests),
              onTap: () => Navigator.of(context).pop(),
            ),
            ListTile(
              title: const Text('My Reviews'),
              leading: Icon(context.involioIcons.star),
              onTap: () => Navigator.of(context).pop(),
            ),
            ListTile(
              title: const Text('Drafts'),
              leading: Icon(context.involioIcons.drafts),
              onTap: () => Navigator.of(context).pop(),
            ),
            ListTile(
              title: const Text('Give Feedback'),
              leading: Icon(context.involioIcons.feedback),
              onTap: () => Navigator.of(context).pop(),
            ),
            ListTile(
              title: const Text('Involio Walk-through'),
              leading: Icon(context.involioIcons.walkThrough),
              onTap: () => Navigator.of(context).pop(),
            ),
            ListTile(
              title: const Text('Help Center'),
              leading: Icon(context.involioIcons.helpCenter),
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
