import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:insidersapp/src/pages/login/sign_up_page/sign_up_form.dart';
import 'package:insidersapp/src/router/router.gr.dart';
import 'package:insidersapp/src/theme/app_theme.dart';
import 'package:insidersapp/src/theme/colors.dart';
import '../get_login_app_bar.dart';
import 'bloc/sign_up_bloc.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  static const routeName = '/signup';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return SignUpBloc();
      },
      child: BlocBuilder<SignUpBloc, SignUpState>(
        buildWhen: (previous, current) =>
            previous.signUpFormStatus != current.signUpFormStatus,
        builder: (context, SignUpState state) {
          return BlocListener<SignUpBloc, SignUpState>(
            listener: (context, state) {
              if (state.signUpFormStatus.isSubmissionSuccess) {
                //Navigator.restorablePushNamed(context, EnterOtpPage.routeName);
                context.router.push(const EnterOtpRoute());
              }
            },
            child: Scaffold(
              appBar: getLoginAppBar(),
              body: Stack(
                alignment: Alignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(AppThemes.edgePadding),
                    child: CustomScrollView(
                      slivers: [
                        /// SliverFillRemaining helps force terms of services
                        /// to the bottom of the page
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: SignUpForm(),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 60,
                            color: AppColors.involioBackground.withOpacity(0.8),
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 0, bottom: 10),
                            child: const Text(
                              'By continuing, you agree to our terms of service and privacy policy',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 20, left: 0, right: 20),
                          child: FloatingActionButton(
                            onPressed: state.signUpFormStatus.isValidated
                                ? () {
                                    context.read<SignUpBloc>().submitSignUp();
                                    //Navigator.restorablePushNamed(context, EnterOtpPage.routeName);
                                  }
                                : null,
                            tooltip: 'Sign Up',
                            child: const Icon(Icons.keyboard_arrow_right),
                            backgroundColor: state.signUpFormStatus.isValidated
                                ? AppColors.involioBlue
                                : Colors.grey,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
