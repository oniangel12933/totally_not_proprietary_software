import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:formz/formz.dart';

import 'package:involio/src/pages/login/sign_up_page/sign_up_form.dart';
import 'package:involio/src/router/router.gr.dart';
import 'package:involio/src/shared/widgets/unfocus_widget.dart';
import 'package:involio/src/theme/app_theme.dart';
import 'package:involio/src/theme/colors.dart';
import '../get_login_app_bar.dart';
import 'bloc/sign_up_bloc.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

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
                if (state.goToWelcomePage == true) {
                  // this means that the signup worked, but login did not
                  context.router.pop();
                  context.router.push(const LoginRoute());
                } else {
                  context.router.pop();
                  context.router.push(const LoginRoute());
                  context.router.push(const EnterOtpRoute());
                }
              }
            },
            child: UnFocusWidget(
              child: Scaffold(
                appBar: getLoginAppBar(),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                            left: AppThemes.edgePadding,
                            right: AppThemes.edgePadding),
                        child: SignUpForm(),
                      ),
                      Container(
                        height: 80,
                        color: AppColors.involioBackground.withOpacity(0.8),
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 0, bottom: 0),
                        child: Text(
                          AppLocalizations.of(context)!.policyAgreement,
                          style: AppFonts.bodySmall
                              .copyWith(color: AppColors.involioWhiteShades100),
                        ),
                      ),
                    ],
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: state.signUpFormStatus.isValidated
                      ? () {
                          context.read<SignUpBloc>().submitSignUp();
                        }
                      : null,
                  tooltip: AppLocalizations.of(context)!.signUp,
                  child: const Icon(Icons.keyboard_arrow_right),
                  backgroundColor: state.signUpFormStatus.isValidated
                      ? AppColors.involioBlue
                      : Colors.grey,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
