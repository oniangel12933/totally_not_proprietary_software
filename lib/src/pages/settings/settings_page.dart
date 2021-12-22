import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:involio/src/shared/blocs/auth_bloc/auth_bloc.dart';
import 'package:involio/src/theme/theme_cubit.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),

        // When a user selects a theme from the dropdown list, the
        // SettingsController is updated, which rebuilds the MaterialApp.
        child: Column(
          children: [
            DropdownButton<bool>(
              // Read the selected themeMode from the controller
              value: context.read<ThemeCubit>().getIsDark(),
              // Call the updateThemeMode method any time the user selects a theme.
              onChanged: (bool? isDark) =>
                  context.read<ThemeCubit>().setIsDark(isDark: isDark ?? true),
              items: const [
                DropdownMenuItem(
                  value: true,
                  child: Text('Dark Theme'),
                ),
                DropdownMenuItem(
                  value: false,
                  child: Text('Light Theme'),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            TextButton(
              // style: ButtonStyle(
              //   foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              // ),
              onPressed: () {
                context.read<AuthBloc>().setLoggedOut();
              },
              child: const Text('Logout!!'),
            )
          ],
        ),
      ),
    );
  }
}
