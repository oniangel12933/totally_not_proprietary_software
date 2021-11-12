import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:insidersapp/src/pages/login/enter_otp_page/enter_otp_page.dart';
import 'package:insidersapp/src/pages/login/sign_up_page/sign_up_form.dart';
import 'package:insidersapp/src/repositories/api_client/error_interceptor.dart';
import 'package:insidersapp/src/repositories/auth/auth_repository.dart';
import 'package:insidersapp/src/repositories/secure_storage/secure_repository.dart';
import 'package:insidersapp/src/pages/login/login_title_widget.dart';
import 'package:insidersapp/src/theme/colors.dart';

import 'bloc/sign_up_bloc.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  static const routeName = '/sign_up';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return SignUpBloc(
          authenticationRepository:
              RepositoryProvider.of<AuthRepository>(context),
          secureRepository:
              RepositoryProvider.of<SecureStorageRepository>(context),
          //loginFlowCubit: context.read<LoginFlowCubit>(),
        );
      },
      child: BlocBuilder<SignUpBloc, SignUpState>(
        buildWhen: (previous, current) =>
            previous.signUpFormStatus != current.signUpFormStatus,
        builder: (context, SignUpState state) {
          return BlocListener<SignUpBloc, SignUpState>(
            listener: (context, state) {
              if (state.signUpFormStatus.isSubmissionSuccess) {
                Navigator.restorablePushNamed(context, EnterOtpPage.routeName);
              }
            },
            child: Scaffold(
              //backgroundColor: AppColors.primary,
              appBar: AppBar(
                //backgroundColor: AppColors.primary,
                centerTitle: true,
                title: const LoginTitleWidget(),
              ),
              body: Stack(
                alignment: Alignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(12),
                    //child: SingleChildScrollView(child: SignUpForm()),

                      /// the CustomScrollView helps fo
                      child: CustomScrollView(
                        slivers: [
                          /// SliverFillRemaining helps force terms of services
                          /// to the bottom of the page
                          SliverFillRemaining(
                            hasScrollBody: false,
                            child: SignUpForm(),
                            // child: Column(
                            //   children: <Widget>[
                            //     const Text('Header'),
                            //     Expanded(child: Container(color: Colors.red)),
                            //     const Text('Footer'),
                            //   ],
                            //),
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
                      color: AppColors.insidersColorsAppBackground
                          .withOpacity(0.8),
                      padding: const EdgeInsets.only(
                          left: 20, right: 80, top: 20, bottom: 20),
                      child: const Text(
                        'By continuing, you agree to our terms of service and privacy policy',
                      ),
                    ),
                  ),
                ],
              ),

              // child: Scaffold(
              //   //backgroundColor: AppColors.primary,
              //   appBar: AppBar(
              //     //backgroundColor: AppColors.primary,
              //     centerTitle: true,
              //     title: const LoginTitleWidget(),
              //   ),
              //   body: Column(
              //     children: [
              //       const Padding(
              //         padding: EdgeInsets.all(12),
              //         child: SingleChildScrollView(
              //           child: SignUpForm(),
              //         ),
              //       ),
              //     ],
              //   ),

              floatingActionButton: FloatingActionButton(
                onPressed: state.signUpFormStatus.isValidated
                    ? () {
                        context.read<SignUpBloc>().submitSignUp();
                        //Navigator.restorablePushNamed(context, EnterOtpPage.routeName);
                      }
                    : null,
                tooltip: 'Sign Up',
                child: const Icon(Icons.keyboard_arrow_right),
                //icon: const Icon(Icons.arrow_forward),
                //label: const Text("Agree"),
                backgroundColor: state.signUpFormStatus.isValidated
                    ? AppColors.accent
                    : Colors.grey,
                foregroundColor: Colors.white,
              ),

              // floatingActionButton:
              //     FloatingActionButton.extended(
              //   onPressed: state.signUpFormStatus.isValidated
              //       ? () {
              //           context.read<SignUpBloc>().submitSignUp();
              //           //Navigator.restorablePushNamed(context, EnterOtpPage.routeName);
              //         }
              //       : null,
              //   tooltip: 'Sign Up',
              //   icon: const Icon(Icons.arrow_forward),
              //   label: const Text("Agree"),
              //   backgroundColor: state.signUpFormStatus.isValidated
              //       ? AppColors.accent
              //       : Colors.grey,
              //   foregroundColor: Colors.white,
              // ),

              // floatingActionButton: BlocBuilder<SignUpBloc, SignUpState>(
              //   buildWhen: (previous, current) =>
              //   previous.signUpFormStatus != current.signUpFormStatus,
              //   builder: (context, SignUpState state) {
              //     return FloatingActionButton.extended(
              //       onPressed: state.signUpFormStatus.isValidated
              //           ? () {
              //         context.read<SignUpBloc>().submitSignUp();
              //         //Navigator.restorablePushNamed(context, EnterOtpPage.routeName);
              //       }
              //           : null,
              //       tooltip: 'Sign Up',
              //       icon: const Icon(Icons.arrow_forward),
              //       label: const Text("Agree"),
              //       backgroundColor: state.signUpFormStatus.isValidated
              //           ? AppColors.accent : Colors.grey,
              //       foregroundColor: Colors.white,
              //     );
              //   },
              // ),

              //floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

              // bottomNavigationBar: Transform.translate(
              //   offset:
              //       Offset(0.0, -1 * MediaQuery.of(context).viewInsets.bottom),
              //   child: const BottomAppBar(
              //     //color: AppColors.primary,
              //     child: SizedBox(
              //       //width: double.infinity,
              //       height: 60.0,
              //       child: Text(
              //           'By continuing, you agree to our terms of service and privacy policy'),
              //     ),
              //   ),
              // ),
            ),
          );
        },
      ),
    );
  }
}
