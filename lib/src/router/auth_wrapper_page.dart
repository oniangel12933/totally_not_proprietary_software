import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insidersapp/src/shared/blocs/auth_bloc/auth_bloc.dart';
import 'package:insidersapp/src/shared/blocs/auth_bloc/auth_state.dart';

class AuthWrapperPage extends StatelessWidget {
  const AuthWrapperPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (BuildContext context, state) {
        return const AutoRouter();
      },
    );
    // return Scaffold(
    //   appBar: AppBar(title: Text('AuthWrapper')),
    //   body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
    //     builder: (BuildContext context, state) {
    //       bool auth = state.status == AuthenticationStatus.authenticated;
    //       if (auth) {
    //         return const AutoRouter();
    //       } else {
    //         context.router.root.replaceAll([UnAuthRouter()]);
    //         return Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           children: const [
    //             CircularProgressIndicator(),
    //             Text('Not Authenticated State'),
    //           ],
    //         );
    //       }
    //     },
    //   ),
    // );
  }
}
