import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:insidersapp/gen/assets.gen.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SplashPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //Center Column contents vertically,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        //Center Column contents horizontally,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            //Center Row contents horizontally,
            crossAxisAlignment: CrossAxisAlignment.center,
            //Center Row contents vertically,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: SvgPicture.asset(Assets.images.insidersLogo,
                    semanticsLabel: '', height: 40, width: 40),
              ),
              Container(
                  margin: const EdgeInsets.only(left: 10.0),
                  child: const Text(
                    "insiders",
                    style: TextStyle(fontSize: 40.0),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
