import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:insidersapp/src/pages/login/enter_otp_page/enter_otp_page.dart';
import 'package:insidersapp/src/pages/login/login_page/login_form.dart';
import 'package:insidersapp/src/repositories/auth/auth_repository.dart';
import 'package:insidersapp/src/repositories/secure_storage/secure_repository.dart';
import 'package:insidersapp/src/pages/login/login_title_widget.dart';
import 'package:insidersapp/src/theme/colors.dart';

import 'bloc/login_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return LoginBloc(
          authenticationRepository:
              RepositoryProvider.of<AuthRepository>(context),
          secureRepository:
              RepositoryProvider.of<SecureStorageRepository>(context),
        );
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (previous, current) =>
            previous.loginFormStatus != current.loginFormStatus,
        builder: (context, LoginState state) {
          return BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state.loginFormStatus.isSubmissionSuccess) {
                Navigator.restorablePushNamed(context, EnterOtpPage.routeName);
              }
            },
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const LoginTitleWidget(),
              ),
              body: const SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: LoginForm(),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: state.loginFormStatus.isValidated
                    ? () {
                        context.read<LoginBloc>().submitLogin();
                      }
                    : null,
                tooltip: 'Log In',
                child: const Icon(Icons.keyboard_arrow_right),
                backgroundColor: state.loginFormStatus.isValidated
                    ? AppColors.accent
                    : Colors.grey,
                foregroundColor: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}
