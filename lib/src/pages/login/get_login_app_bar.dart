import 'package:flutter/material.dart';

import 'package:insidersapp/src/shared/widgets/appbar_widgets/logo_only_title_widget.dart';

AppBar getLoginAppBar() {
  return AppBar(
    elevation: 0,
    centerTitle: true,
    title: const LogoOnlyTitleWidget(),
  );
}
