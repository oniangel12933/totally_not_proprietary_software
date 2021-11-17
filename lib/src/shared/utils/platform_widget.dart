// import 'package:flutter/material.dart';
// import 'dart:io' show Platform;
//
// // https://medium.com/flutter/do-flutter-apps-dream-of-platform-aware-widgets-7d7ed7b4624d
// abstract class PlatformWidget<I extends Widget, A extends Widget> extends StatelessWidget {
//   const PlatformWidget({Key? key}) : super(key: key);
//
//
//   @override
//   Widget build(BuildContext context) {
//     if(Platform.isAndroid) {
//       return createAndroidWidget(context);
//     } else if (Platform.isIOS) {
//       return createIosWidget(context);
//     }
//     // platform not supported returns an empty widget
//     return Container();
//   }
//
//   I createIosWidget(BuildContext context);
//
//   A createAndroidWidget(BuildContext context);
// }