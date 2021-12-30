import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

Future<DateTime?> showPlatformDatePicker2({
  required BuildContext context,
  required DateTime initialDate,
  required DateTime firstDate,
  required DateTime lastDate,
}) async {
  DateTime? picked;
  if (isCupertino(context)) {
    picked = await showCupertinoDatePicker(
      context,
      initialDate,
      firstDate,
      lastDate,
    );
  } else {
    picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
  }
  return picked;
}

Future<DateTime?> showCupertinoDatePicker(
  BuildContext context,
  DateTime initialDate,
  DateTime firstDate,
  DateTime lastDate,
) async {
  DateTime? picked = await showModalBottomSheet<DateTime>(
    context: context,
    builder: (context) {
      DateTime tempPickedDate = initialDate;
      return SizedBox(
        height: 250,
        //color: Colors.,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CupertinoButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                CupertinoButton(
                  child: const Text('Done'),
                  onPressed: () {
                    Navigator.of(context).pop(tempPickedDate);
                  },
                ),
              ],
            ),
            const Divider(
              height: 0,
              thickness: 1,
            ),
            Expanded(
              child: CupertinoTheme(
                data: CupertinoThemeData(
                  /// added Cupertino ThemeData to get text to be white in dark
                  /// mode
                  brightness: Theme.of(context).brightness,
                ),
                child: CupertinoDatePicker(
                  initialDateTime: initialDate,
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (DateTime dateTime) {
                    tempPickedDate = dateTime;
                  },
                  maximumDate: lastDate,
                  minimumDate: firstDate,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );

  return picked;
}
