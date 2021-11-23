import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insidersapp/gen/assets.gen.dart';

class NameAndLogoTitleWidget extends StatelessWidget {
  const NameAndLogoTitleWidget({Key? key}) : super(key: key);

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
        Container(
            margin: const EdgeInsets.only(left: 8.0),
            child: const Text(
              'involio',
              style: TextStyle(fontSize: 28.0),
            ))
      ],
    );
  }
}
