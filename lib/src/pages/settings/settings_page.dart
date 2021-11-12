import 'package:flutter/material.dart';
import 'package:insidersapp/src/shared/blocs/auth_bloc/auth_bloc.dart';
import 'package:insidersapp/src/theme/theme_cubit.dart';
import 'package:provider/src/provider.dart';

import 'settings_controller.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsView extends StatelessWidget {
  const SettingsView({Key? key, required this.controller}) : super(key: key);

  static const routeName = '/settings';

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {

    //context.read<LoginBloc>().add(const LoginSubmitted());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        // Glue the SettingsController to the theme selection DropdownButton.
        //
        // When a user selects a theme from the dropdown list, the
        // SettingsController is updated, which rebuilds the MaterialApp.
        child: Column(
          children: [
            DropdownButton<ThemeMode>(
              // Read the selected themeMode from the controller
              value: context.read<ThemeCubit>().getThemeMode(),
              // Call the updateThemeMode method any time the user selects a theme.
              //onChanged: controller.updateThemeMode,
              onChanged: context.read<ThemeCubit>().setThemeMode,
              items: const [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text('System Theme'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text('Light Theme'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text('Dark Theme'),
                )
              ],
            ),
            const SizedBox(height: 30,),
            TextButton(
              // style: ButtonStyle(
              //   foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              // ),
              onPressed: () {
                context.read<AuthBloc>()
                    .setLoggedOut();
              },
              child: const Text('Logout!!'),
            )
          ],
        ),
      ),
    );
  }
}
