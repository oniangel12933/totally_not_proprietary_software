import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insidersapp/src/repositories/api/user/user_repository.dart';
import 'package:insidersapp/src/shared/blocs/user/cubit.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  static const routeName = '/profile';

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (context) => UserCubit(
          userRepository: RepositoryProvider.of<UserRepository>(context))
        ..getUser(),
      child: const ProfilePage2(),
    );
  }
}

class ProfilePage2 extends StatefulWidget {
  const ProfilePage2({Key? key}) : super(key: key);

  @override
  _ProfilePageState2 createState() => _ProfilePageState2();
}

class _ProfilePageState2 extends State<ProfilePage2> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return (state.user != null && state.user!.username != null)
            ? Text(state.user!.username!)
            : Container();
      },
    );
  }
}
