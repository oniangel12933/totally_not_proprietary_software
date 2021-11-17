import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:insidersapp/src/pages/login/login_page/login_page.dart';
import 'package:insidersapp/src/pages/login/sign_up_page/sign_up_page.dart';
import 'package:insidersapp/src/pages/login/login_title_widget.dart';
import 'package:insidersapp/src/router/router.gr.dart';
import 'package:insidersapp/src/theme/colors.dart';

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({Key? key}) : super(key: key);

  @override
  _GetStartedPageState createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: const LoginTitleWidget(),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),

            child: CustomScrollView(
              slivers: [
                /// SliverFillRemaining helps force terms of services
                /// to the bottom of the page
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 98),
                        const Text(
                          'Welcome to the\nepicenter of social\ninvesting',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            //fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 28),
                        SizedBox(
                          width: 130,
                          height: 54,
                          child: TextButton(
                            child: const Text(
                              'Get Started',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                AppColors.insidersColorsInsidersBlue,
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                            onPressed: () => context.router.push(const SignUpRoute()),
                          ),
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              height: 80,
              color: AppColors.insidersColorsAppBackground.withOpacity(0.8),
              padding: const EdgeInsets.only(
                  left: 20, right: 80, top: 20, bottom: 20),
              child: Row(
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                    child: const Text('Log In'),
                    onPressed: () => context.router.push(const LoginRoute()),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
