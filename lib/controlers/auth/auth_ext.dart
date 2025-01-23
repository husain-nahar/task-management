import 'package:task_management/helpers/exports.dart';

extension AuthVCExt on AuthVC {
  // PIN CONTROLER
  Widget pinControler(BuildContext context) {
    PinTheme defaultPinTheme(BuildContext context) => PinTheme(
          width: defaultHeightForButonTextField,
          height: defaultHeightForButonTextField,
          textStyle: TextStyle(
              // context,
              ),
          decoration: BoxDecoration(
            borderRadius: borderRadius12,
            border: Border.all(color: blackColor),
          ),
        );

    return Directionality(
      // Specify direction if desired
      textDirection: TextDirection.ltr,
      child: Pinput(
        focusNode: authControler.getOtpFieldFocusNode,
        length: 6,
        controller: authControler.getOtpTextEditingControler,
        autofocus: true,
        keyboardType: TextInputType.phone,
        androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
        listenForMultipleSmsOnAndroid: true,
        defaultPinTheme: defaultPinTheme(context),
        hapticFeedbackType: HapticFeedbackType.lightImpact,
        separatorBuilder: (index) => const SizedBox(width: 15),
        onClipboardFound: (pincode) {},
        onCompleted: (pincode) {
          debugPrint('onCompleted: $pincode');
          authControler.setPincode = pincode;
        },
        onChanged: (value) {
          debugPrint('onChanged: $value');
        },
        cursor: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              width: 25,
              height: 1,
              color: blackColor,
            ),
          ],
        ),
        focusedPinTheme: defaultPinTheme(context).copyWith(
          decoration: defaultPinTheme(context).decoration!.copyWith(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: blackColor),
              ),
        ),
        submittedPinTheme: defaultPinTheme(context).copyWith(
          decoration: defaultPinTheme(context).decoration!.copyWith(
                color: transperentColor,
                borderRadius: BorderRadius.circular(19),
                border: Border.all(color: blackColor),
              ),
        ),
        errorPinTheme: defaultPinTheme(context).copyBorderWith(
          border: Border.all(color: Colors.redAccent),
        ),
      ),
    );
  }
}

Widget otpResendSection() {
  if (authControler.getResendingCode) {
    return Text(
      "${authControler.getTimerInt}",
      textAlign: TextAlign.center,
    );
  } else {
    return CustomBtn(
      text: resendCodeStr,
      onPresed: () {
        otpSendPresed(
          isResendingCode: true,
        );
      },
    );
  }
}
