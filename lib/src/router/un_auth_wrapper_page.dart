import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insidersapp/src/shared/blocs/auth_bloc/auth_bloc.dart';
import 'package:insidersapp/src/shared/blocs/auth_bloc/auth_state.dart';

class UnAuthWrapperPage extends StatelessWidget {
  const UnAuthWrapperPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (BuildContext context, state) {
        return const AutoRouter();
      },
    );
    // return Scaffold(
    //   body: BlocBuilder<AuthBloc, AuthState>(
    //     builder: (BuildContext context, state) {
    //       bool auth = state.status == AuthenticationStatus.authenticated;
    //       if (!auth) {
    //         return const AutoRouter();
    //       } else {
    //         context.router.root.replaceAll([const AuthRouter()]);
    //         return Center(
    //           child: Column(
    //             mainAxisSize: MainAxisSize.min,
    //             children: const [
    //               CircularProgressIndicator(),
    //               Text('Authenticated State'),
    //             ],
    //           ),
    //         );
    //       }
    //     },
    //   ),
    // );
  }
}
