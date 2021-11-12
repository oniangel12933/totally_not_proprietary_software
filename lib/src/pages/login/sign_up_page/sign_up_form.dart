import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:insidersapp/src/pages/login/form_models/phone_entity.dart';
import 'package:insidersapp/src/theme/colors.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart' as pn;

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
        const EdgeInsets.symmetric(horizontal: 16, vertical: 20);

    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state.signUpFormStatus.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                  content: Text(state.error ?? "Could not create new user")),
            );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 12),
            child: Text(
              'Create your account',
              style: Theme.of(context).textTheme.headline5,
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
        return TextField(
          controller: controller,
          key: const Key('loginForm_nameInput_textField'),
          onChanged: (name) =>
              context.read<SignUpBloc>().add(SignUpNameChanged(name)),
          decoration: getLoginInputDecoration(
            labelText: 'Your Name',
            errorText: 'Invalid name',
            field: state.name,
          ),
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

        return TextField(
          controller: controller,
          key: const Key('loginForm_usernameInput_textField'),
          onChanged: (username) =>
              context.read<SignUpBloc>().add(SignUpUsernameChanged(username)),
          decoration: getLoginInputDecoration(
            labelText: 'Your User Name',
            errorText: 'Invalid username',
            field: state.username,
            prefix: '@',
          ),
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

        return IntlPhoneField(
          controller: controller,
          showDropdownIcon: true,
          dropdownDecoration: BoxDecoration(
            color: AppColors.insidersColorsAppBackgroundSwatch[400],
            borderRadius: BorderRadius.circular(12),
          ),
          decoration: getLoginInputDecoration(
              labelText: 'Your Phone Number',
              errorText: 'Invalid phone number',
              field: state.phone),
          onChanged: (pn.PhoneNumber phoneNumber) {
            print(phoneNumber.completeNumber);
            if (phoneNumber.countryISOCode != null &&
                phoneNumber.countryCode != null &&
                phoneNumber.number != null) {
              context.read<SignUpBloc>().phoneChanged(
                    phone: PhoneEntity(
                      number: phoneNumber.number!,
                      countryCode: phoneNumber.countryCode!,
                      countryISOCode: phoneNumber.countryISOCode!,
                    ),
                  );
            }
          },
          onCountryChanged: (pn.PhoneNumber phone) {},
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
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate, //.subtract(const Duration(days: 365*10)),
        firstDate: DateTime(1910),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
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
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.birthDate != current.birthDate,
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
                labelText: 'Date of Birth',
                errorText: 'Invalid birth date',
                field: state.birthDate,
                hintText: 'mm/dd/yyy',
              ),
            ),
          ),
        );
      },
    );
  }
}
