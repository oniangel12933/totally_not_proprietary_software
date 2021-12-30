import 'package:flutter/cupertino.dart';

import 'package:flutter_svg/svg.dart';

import 'package:involio/gen/assets.gen.dart';

class LogoOnlyTitleWidget extends StatelessWidget {
  const LogoOnlyTitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // The ConstrainedBox allows the title to be centered in the appbar when
    // using centerTitle: true,
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: SvgPicture.asset(Assets.images.insidersLogo,
              semanticsLabel: '', height: 32, width: 32),
        ),
      ],
    );
  }
}
