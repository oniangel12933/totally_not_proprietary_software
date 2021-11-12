import 'package:bloc/bloc.dart';
import 'package:insidersapp/src/pages/login/form_models/phone_entity.dart';
import 'package:insidersapp/src/repositories/auth/auth_repository.dart';
import 'package:insidersapp/src/repositories/auth/models/otp_sms_login_response.dart';
import 'package:insidersapp/src/repositories/auth/models/otp_sms_start_response.dart';
import 'package:insidersapp/src/repositories/secure_storage/secure_repository.dart';
import 'package:insidersapp/src/repositories/user/user_repository.dart';
import 'package:insidersapp/src/shared/blocs/auth_bloc/auth_bloc.dart';

import 'otp_event.dart';
import 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final AuthBloc _authBloc;
  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  final SecureStorageRepository _secureRepository;

  OtpBloc({
    required AuthBloc authBloc,
    required AuthRepository authRepository,
    required UserRepository userRepository,
    required SecureStorageRepository secureRepository,
  })  : _authBloc = authBloc,
        _authRepository = authRepository,
        _userRepository = userRepository,
        _secureRepository = secureRepository,
        super(const OtpState()) {
    on<RetrievePhoneNumberFromStorageOtpEvent>((event, emit) async {
      PhoneEntity? phone = await _secureRepository.getPhone();

      if (phone != null) {
        emit(state.copyWith(phone: phone));
      } else {
        emit(OtpState(
          phone: state.phone,
          errorMissingPhoneNumber: true,
        ));
      }
    });
    on<SubmitOtpEvent>((event, emit) async {
      if (state.phone == null) {
        emit(OtpState(
          phone: state.phone,
          errorMissingPhoneNumber: true,
        ));
        print('Cannot Submit OTP ${event.otp} to Missing Phone Number');
        return;
      } else {
        emit(OtpState(
          phone: state.phone,
          submittingInProgress: true,
        ));
        print('Submitting OTP ${event.otp} to ${state.phone?.completeNumber}');

        OtpSmsLoginResponse response = await _authRepository.logInWithPhone(
          phone: state.phone!.completeNumber(),
          password: event.otp,
        );

        print('OtpBloc ------------------');
        print(response);

        if (response.error != null || response.access_token == null) {
          print(response.error);
          emit(OtpState(
            phone: state.phone,
            submittingInProgress: false,
            errorSubmitting: true,
          ));
        } else {
          emit(OtpState(
            phone: state.phone,
            submittingInProgress: false,
            errorSubmitting: false,
          ));

          _authBloc.setLoggedIn(
            phone: state.phone!,
            token: response.access_token!,
          );
        }

        //Navigator.restorablePushNamed(context,SignUpPage.routeName);
      }
    });

    on<ResendSmsOtpEvent>((event, emit) async {
      if (state.phone == null) {
        emit(OtpState(
          phone: state.phone,
          errorMissingPhoneNumber: true,
        ));
        return;
      } else {
        print('Resending SMS to ${state.phone?.completeNumber}');

        try {
          OtpSmsStartResponse otpSmsStartResponse =
              await _authRepository.getOtpForPhoneNumber(
            phone: state.phone!.completeNumber(),
          );

          if (otpSmsStartResponse.error == null) {
            emit(OtpState(
              phone: state.phone,
              submittingInProgress: false,
              resent: true,
              errorResending: false,
            ));
          } else {
            emit(OtpState(
              phone: state.phone,
              submittingInProgress: false,
              errorResending: true,
            ));
          }
        } catch (e) {
          print(e);
          emit(OtpState(
            phone: state.phone,
            submittingInProgress: false,
            errorResending: true,
          ));
        }
      }
    });

    retrievePhoneNumberFromStorage();
  }

  void retrievePhoneNumberFromStorage() {
    add(const RetrievePhoneNumberFromStorageOtpEvent());
  }

  void submitOtp(String otp) {
    add(SubmitOtpEvent(otp: otp));
  }

  void resendSms() {
    add(const ResendSmsOtpEvent());
  }
}
