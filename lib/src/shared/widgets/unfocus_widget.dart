import 'package:flutter/material.dart';

/// This widget is to allow a TextField to become unfocused and hide the
/// keyboard when we click somewhere else in the app.
class UnFocusWidget extends StatelessWidget {
  final Widget child;

  const UnFocusWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: child);
  }
}
