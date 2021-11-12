import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:insidersapp/src/pages/login/form_models/phone_entity.dart';
import 'package:insidersapp/src/theme/colors.dart';

import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart' as pn;

import '../login_input_decoration.dart';
import 'bloc/login_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets fieldPadding =
        const EdgeInsets.symmetric(horizontal: 0, vertical: 8);

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.loginFormStatus.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failed')),
            );
        }
        if (state.initialPhone?.number != null && state.phone.pure) {
          phoneController.text = state.initialPhone!.number;
          context.read<LoginBloc>().phoneChanged(
            phone: state.initialPhone!,
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 0,
              right: 0,
              top: 32,
              bottom: 32,
            ),
            child: Text(
              'Welcome Back!',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Padding(
            padding: fieldPadding,
            child: BlocBuilder<LoginBloc, LoginState>(
              buildWhen: (previous, current) =>
                  (previous.phone != current.phone ||
                      previous.initialPhone != current.initialPhone ||
                      previous.readyToDisplay != current.readyToDisplay),
              builder: (context, state) {
                /// readyToDisplay makes sure that the phone number and
                /// country code is loaded from storage before displaying
                return state.readyToDisplay
                    ? IntlPhoneField(
                        controller: phoneController,
                        initialCountryCode:
                            state.initialPhone?.countryISOCode ?? 'US',
                        showDropdownIcon: true,
                        dropdownDecoration: BoxDecoration(
                          color:
                              AppColors.insidersColorsAppBackgroundSwatch[400],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        decoration: getLoginInputDecoration(
                            labelText: 'Your Phone Number',
                            errorText: 'Invalid phone number',
                            field: state.phone),
                        onChanged: (pn.PhoneNumber phoneNumber) {
                          context.read<LoginBloc>().phoneChanged(
                                phone: PhoneEntity(
                                  number: phoneNumber.number ?? '',
                                  countryCode: phoneNumber.countryCode ?? '',
                                  countryISOCode:
                                      phoneNumber.countryISOCode ?? '',
                                ),
                              );
                        },
                        onCountryChanged: (pn.PhoneNumber phone) {},
                      )
                    : Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
