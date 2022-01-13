import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:formz/formz.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart' as ipn;

import 'package:involio/src/pages/login/form_models/phone_entity.dart';
import 'package:involio/src/shared/icons/involio_icons.dart';
import 'package:involio/src/shared/widgets/platform_date_picker_modal.dart';
import 'package:involio/src/theme/app_theme.dart';
import 'package:involio/src/theme/colors.dart';
import '../login_input_decoration.dart';
import 'bloc/sign_up_bloc.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    userNameController.dispose();
    phoneController.dispose();
    birthDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsets fieldPadding =
        const EdgeInsets.symmetric(horizontal: 0, vertical: 20);

    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state.signUpFormStatus.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.error ?? AppLocalizations.of(context)!.userCreationError),
              ),
            );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 0, right: 0, bottom: 12),
            child: Text(
              AppLocalizations.of(context)!.createAccount,
              style: AppFonts.headline2.copyWith(color: AppColors.involioWhiteShades100),
            ),
          ),
          Padding(
            padding: fieldPadding,
            child: _NameInput(controller: nameController),
          ),
          Padding(
            padding: fieldPadding,
            child: _UsernameInput(controller: userNameController),
          ),
          Padding(
            padding: fieldPadding,
            child: _PhoneInput(controller: phoneController),
          ),
          Padding(
            padding: fieldPadding,
            child: _BirthDateInput(controller: birthDateController),
          ),
        ],
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  final TextEditingController controller;

  const _NameInput({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        if (state.name.value == SignUpBloc.secretName) {
          controller.text = state.name.value;
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0, bottom: 8),
              child: Text(
                AppLocalizations.of(context)!.nameSignUp,
                style: AppFonts.headline8.copyWith(color: AppColors.involioWhiteShades100),
              ),
            ),
            TextField(
              controller: controller,
              key: const Key('loginForm_nameInput_textField'),
              onChanged: (name) =>
                  context.read<SignUpBloc>().add(SignUpNameChanged(name)),
              decoration: getLoginInputDecoration(
                labelText: '',
                errorText: AppLocalizations.of(context)!.invalidName,
                field: state.name,
                hintText: AppLocalizations.of(context)!.nameFormat
              ),
            ),
          ],
        );
      },
    );
  }
}

class _UsernameInput extends StatelessWidget {
  final TextEditingController controller;

  const _UsernameInput({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        if (state.name.value == SignUpBloc.secretName) {
          controller.text = state.username.value;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0, bottom: 8),
              child: Text(
                AppLocalizations.of(context)!.userNameSignUp,
                style: AppFonts.headline8.copyWith(color: AppColors.involioWhiteShades100),
              ),
            ),
            TextField(
              controller: controller,
              key: const Key('loginForm_usernameInput_textField'),
              onChanged: (username) => context
                  .read<SignUpBloc>()
                  .add(SignUpUsernameChanged(username)),
              decoration: getLoginInputDecoration(
                labelText: '',
                errorText: AppLocalizations.of(context)!.invalidUserName,
                field: state.username,
                prefixIcon: Icon(context.involioIcons.at,
                  color: AppColors.involioWhiteShades100,
                  size: 24,),
                hintText: AppLocalizations.of(context)!.userNameFormat,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _PhoneInput extends StatelessWidget {
  final TextEditingController controller;

  const _PhoneInput({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.phone != current.phone,
      builder: (context, state) {
        if (state.name.value == SignUpBloc.secretName) {
          controller.text = state.phone.value.number;
        }

        String initialCountry = 'US';
        if (state.phone.value.isoCode.isNotEmpty) {
          initialCountry = state.phone.value.isoCode;
        }
        ipn.PhoneNumber initialNumber =
            ipn.PhoneNumber(isoCode: initialCountry);

        // ipn.PhoneNumber initialNumber = ipn.PhoneNumber(
        //   isoCode: 'US',
        // );
        // if (state.?.number != null && state.phone.pure) {
        //   initialNumber = ipn.PhoneNumber(
        //     isoCode: state.initialPhone?.isoCode ?? 'US',
        //     dialCode: state.initialPhone?.dialCode,
        //     phoneNumber: state.initialPhone?.number,
        //   );
        // }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0, bottom: 8),
              child: Text(
                AppLocalizations.of(context)!.phoneNumberSignUp,
                style: AppFonts.headline8.copyWith(color: AppColors.involioWhiteShades100),
              ),
            ),
            ipn.InternationalPhoneNumberInput(
              initialValue: initialNumber,
              countries: const ["US"],
              textFieldController: controller,
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
                  context.read<SignUpBloc>().phoneChanged(
                        phone: PhoneEntity(
                          number: phoneN!,
                          dialCode: phoneNumber.dialCode!,
                          isoCode: phoneNumber.isoCode!,
                        ),
                      );
                }
              },
              onInputValidated: (bool value) {
                //print(value);
              },
              selectorConfig: const ipn.SelectorConfig(
                selectorType: ipn.PhoneInputSelectorType.BOTTOM_SHEET,
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
        );
      },
    );
  }
}

class _BirthDateInput extends StatefulWidget {
  final TextEditingController controller;

  const _BirthDateInput({Key? key, required this.controller}) : super(key: key);

  @override
  State<_BirthDateInput> createState() => _BirthDateInputState();
}

class _BirthDateInputState extends State<_BirthDateInput> {
  DateTime selectedDate = DateTime(2000);

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showPlatformDatePicker2(
      context: context,
      initialDate: selectedDate, //.subtract(const Duration(days: 365*10)),
      firstDate: DateTime(1910),
      lastDate: DateTime.now(),
    );
    await _datePicked(picked);
  }

  _datePicked(DateTime? picked) async {
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        String date =
            "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
        widget.controller.text = date;
      });
      context.read<SignUpBloc>().add(
            SignUpBirthDateChanged(
              "${picked.toLocal().year}-${picked.toLocal().month}-${picked.toLocal().day}",
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0, bottom: 8),
          child: Text(
            AppLocalizations.of(context)!.dateOfBirth,
            style: AppFonts.headline8.copyWith(color: AppColors.involioWhiteShades100),
          ),
        ),
        BlocBuilder<SignUpBloc, SignUpState>(
          buildWhen: (previous, current) =>
              previous.birthDate != current.birthDate,
          builder: (context, state) {
            if (state.name.value == SignUpBloc.secretName) {
              widget.controller.text = state.birthDate.value;
            }

            return GestureDetector(
              onTap: () {
                _selectDate(context);
                FocusScope.of(context).unfocus(); // hide keyboard
              },
              child: AbsorbPointer(
                child: TextFormField(
                  controller: widget.controller,
                  decoration: getLoginInputDecoration(
                    labelText: '',
                    errorText: AppLocalizations.of(context)!.invalidDateOfBirth,
                    field: state.birthDate,
                    hintText: AppLocalizations.of(context)!.dateFormat,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
