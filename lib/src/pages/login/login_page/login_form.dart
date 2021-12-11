import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart' as ipn;

import 'package:insidersapp/src/pages/login/form_models/phone_entity.dart';
import '../login_input_decoration.dart';
import 'bloc/login_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:insidersapp/src/theme/app_theme.dart';
import 'package:insidersapp/src/theme/colors.dart';

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
        // if (state.initialPhone?.number != null && state.phone.pure) {
        //   phoneController.text = state.initialPhone!.number;
        //   context.read<LoginBloc>().phoneChanged(
        //         phone: state.initialPhone!,
        //       );
        // }
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
              AppLocalizations.of(context)!.welcomeBack,
              style: AppFonts.headline2.copyWith(color: AppColors.involioWhiteShades100),
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
                //String initialCountry = 'US';
                ipn.PhoneNumber initialNumber = ipn.PhoneNumber(
                  isoCode: 'US',
                );
                if (state.initialPhone?.number != null && state.phone.pure) {
                  initialNumber = ipn.PhoneNumber(
                    isoCode: state.initialPhone?.isoCode ?? 'US',
                    dialCode: state.initialPhone?.dialCode,
                    phoneNumber: state.initialPhone?.number,
                  );
                } else if (state.phone.value.isoCode.isNotEmpty) {
                  String initialCountry = state.phone.value.isoCode;
                  initialNumber = ipn.PhoneNumber(isoCode: initialCountry);
                }

                /// readyToDisplay makes sure that the phone number and
                /// country code is loaded from storage before displaying
                return state.readyToDisplay
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 0, bottom: 8),
                            child: Text(
                              AppLocalizations.of(context)!.phoneNumberLogIn,
                              style: AppFonts.headline8.copyWith(color: AppColors.involioWhiteShades100),
                            ),
                          ),
                          ipn.InternationalPhoneNumberInput(
                            initialValue: initialNumber,
                            textFieldController: phoneController,
                            // onInputChanged: (ipn.PhoneNumber number) {
                            //   print(number.phoneNumber);
                            // },
                            onInputChanged: (ipn.PhoneNumber phoneNumber) {
                              // if there is only a dial code without a phone number, the phone number will be the dial code
                              // this removes country code from number
                              String? phoneN = (phoneNumber.dialCode?.length ==
                                      phoneNumber.phoneNumber?.length)
                                  ? null
                                  : phoneNumber.phoneNumber?.substring(
                                      phoneNumber.dialCode?.length ?? 0,
                                    );

                              if (phoneN?.isNotEmpty != null &&
                                  phoneNumber.dialCode?.isNotEmpty != null &&
                                  phoneNumber.phoneNumber?.isNotEmpty != null) {
                                context.read<LoginBloc>().phoneChanged(
                                      phone: PhoneEntity(
                                        number: phoneN ?? '',
                                        dialCode: phoneNumber.dialCode ?? '',
                                        isoCode: phoneNumber.isoCode ?? '',
                                      ),
                                    );
                              }
                            },
                            onInputValidated: (bool value) {
                              //print(value);
                            },
                            selectorConfig: const ipn.SelectorConfig(
                              selectorType:
                                  ipn.PhoneInputSelectorType.BOTTOM_SHEET,
                              showFlags: true,
                              useEmoji: false,
                              leadingPadding: 0,
                              trailingSpace: false,
                              setSelectorButtonAsPrefixIcon: false,
                            ),
                            ignoreBlank: false,
                            autoValidateMode: AutovalidateMode.disabled,
                            //selectorTextStyle: const TextStyle(color: Colors.black),

                            formatInput: true,
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            inputBorder: const OutlineInputBorder(),
                            inputDecoration: getLoginInputDecoration(
                              labelText: '',
                              errorText: AppLocalizations.of(context)!.invalidPhoneNumber,
                              field: state.phone,
                              hintText: AppLocalizations.of(context)!.phoneNumberFormat,
                            ),
                          ),
                        ],
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
