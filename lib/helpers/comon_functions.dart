import 'exports.dart';

bool validateBoolean(bool? boolean) => boolean ?? false;
num openNumber(num? value) => value ?? 0;
String openString(String? value) => value ?? "";
bool stringEmpty(String? value) => value?.isEmpty ?? true;
bool numGrtrThnZero(num? number) => (number ?? 0) > 0;
bool numGrtrThnEqualZero(num? number) => (number ?? 0) >= 0;
bool numGrtrThnOne(num? number) => (number ?? 0) > 1;

bool textFieldNotValidated(TextEditingController textFormField) =>
    textFormField.text.isEmpty;

OutlineInputBorder outlineBorder([Color? color]) {
  return OutlineInputBorder(
    borderSide: BorderSide(
      color: color ?? blackColor,
      width: 0.5,
    ),
    borderRadius: borderRadius12,
  );
}

// OTP BUTTON FUNCTION
Future otpSendPresed({
  bool isResendingCode = false,
}) async {
  showLoader();
  printT("OTP BUTTON PRESED");
  printT("@ FIRST IN OTP");
  await Future.delayed(
    const Duration(seconds: 1),
  );

  String phoneNumber = "";

  if (isResendingCode) {
    authControler.setResendingCode = true;
    authControler.startTimerForResendCode();

    phoneNumber =
        "+${authControler.getSelectedCountry?.phoneCode}${authControler.getPhoneTextEditingControler.text}";
  } else {
    // AUTHENTICATION CONTROLER 1
    if (stringEmpty(authControler.getSelectedCountry?.countryCode)) {
      showInfoAlert(selectCountryStr);
      return;
    }
    if (textFieldNotValidated(authControler.getPhoneTextEditingControler) ||
        (RegExp(r'^\+\d{1,3}\d{9,10}$')
            .hasMatch(authControler.getPhoneTextEditingControler.text))) {
      showInfoAlert(providePhoneNumberStr);
      return;
    }
    printT("OTP VALIDATED OTP SEND AUTH CONTROLER");
    phoneNumber =
        "+${authControler.getSelectedCountry?.phoneCode}${authControler.getPhoneTextEditingControler.text.trim()}";

    printT("PHONE NUMBER IS: $phoneNumber");

    String otpReceived = testOtp;

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {
          printT("PHONE CREDENTIAL RECEIVED: $credential");
          if (phoneNumber != testMobileNumber) {
            otpReceived = credential.smsCode!;
          }
        },
        verificationFailed: (FirebaseAuthException error) {
          showInfoAlert(
            "Firebase Error for Phone: ${error.message}",
          );
        },
        codeSent: (
          String verificationId,
          int? forceResendingToken,
        ) async {
          authControler.setphoneVerificationId = verificationId;

          printT(
            "PHONE VERIF ID: $verificationId & FORCE Resending Token: $forceResendingToken",
          );
          printT("SMS CODE INSIDE VERIFICATION: $otpReceived");

          if (!isResendingCode) {
            authControler.setResendingCode = true;
            authControler.startTimerForResendCode();
          }
          hideLoader();
          authControler.setVisibleOtpFields =
              authControler.getPhoneTextEditingControler.text.length > 7;
          if (!authControler.getVisibleOtpFields) {
            authControler.getOtpTextEditingControler.setText("");
          }
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          printT("PHONE VERIF ONLY ID: $verificationId");
        },
      );
      // hideLoader();
    } on FirebaseAuthException catch (e) {
      showInfoAlert(e.message);
    } catch (e) {
      hideLoader();
      printT(
        "something went wrong inside OTP SEND PRESED",
      );
    }
    printT("@ LAST IN OTP");
  }
}
