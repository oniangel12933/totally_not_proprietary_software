import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:insidersapp/gen/involio_api.swagger.dart';
import 'package:insidersapp/src/pages/login/form_models/phone_entity.dart';
import 'package:insidersapp/src/repositories/api/auth/auth_repository.dart';
import 'package:insidersapp/src/repositories/local/secure_storage/secure_repository.dart';
import 'package:insidersapp/src/shared/blocs/auth_bloc/auth_bloc.dart';
import 'package:insidersapp/src/shared/blocs/event_transformers/throttle.dart';

import 'otp_event.dart';
import 'otp_state.dart';

const throttleDuration = Duration(milliseconds: 200);

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final AuthBloc _authBloc;
  late final AuthRepository _authRepository;
  late final SecureStorageRepository _secureRepository;

  OtpBloc({
    required AuthBloc authBloc,
  })  : _authBloc = authBloc,
        super(const OtpState()) {
    _authRepository = GetIt.I.get<AuthRepository>();
    _secureRepository = GetIt.I.get<SecureStorageRepository>();

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
    on<SubmitOtpEvent>(
      (event, emit) async {
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
          print(
              'Submitting OTP ${event.otp} to ${state.phone?.completeNumber}');

          OTPLoginResponse response = await _authRepository.logInWithPhone(
            phone: state.phone!.completeNumber(),
            password: event.otp,
          );

          //print('OtpBloc ------------------');
          //print(response);

          if (response.error != null || response.accessToken == null) {
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
              token: response.accessToken!,
            );
          }

          //Navigator.restorablePushNamed(context,SignUpPage.routeName);
        }
      },
      transformer: throttle(throttleDuration),
    );

    on<ResendSmsOtpEvent>(
      (event, emit) async {
        if (state.phone == null) {
          emit(OtpState(
            phone: state.phone,
            errorMissingPhoneNumber: true,
          ));
          return;
        } else {
          print('Resending SMS to ${state.phone?.completeNumber}');

          try {
            SMSStartResponse otpSmsStartResponse =
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
      },
      transformer: throttle(throttleDuration),
    );

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
