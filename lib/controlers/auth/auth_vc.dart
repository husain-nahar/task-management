import 'package:task_management/helpers/exports.dart';

class AuthVC extends StatelessWidget {
  const AuthVC({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: screenWidth / 1.5,
            child: keyboardDismisWidget(
              context,
              child: Column(
                children: [
                  gap(50),
                  onlineOflineSectionChildren(),
                  Text(
                    enterOtp,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                  gap(),
                  Row(
                    children: [
                      Expanded(
                        child: PhoneWithCodeTextField(),
                      ),
                      gap(5),
                      SizedBox(
                        width: defaultHeightForButonTextField,
                        height: defaultHeightForButonTextField,
                        child: IconButton(
                          style: ButtonStyle(
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: borderRadius12,
                              ),
                            ),
                            backgroundColor: WidgetStatePropertyAll(blackColor),
                          ),
                          icon: Icon(
                            Icons.exit_to_app_outlined,
                            color: whiteColor,
                          ),
                          onPressed: () {
                            printT("PHONE BUTON PRESED");
                            otpSendPresed();
                          },
                        ),
                      ),
                    ],
                  ),
                  gap(),
                  GetX<AuthControler>(
                    builder: (_) {
                      if (authControler.getVisibleOtpFields) {
                        return Column(
                          children: [
                            pinControler(context),
                            gap(),
                            SizedBox(
                              width: screenWidth / 1.5,
                              child: Column(
                                children: [
                                  otpResendSection(),
                                  gap(),
                                  CustomBtn(
                                    text: submitStr,
                                    onPresed: () =>
                                        authControler.procesVerification(),
                                  ),
                                  gap(),
                                ],
                              ),
                            ),
                          ],
                        );
                      } else {
                        return gap();
                      }
                    },
                  ),
                  Text(
                    testingNumbers,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(testNum1),
                      Text(testNum2),
                    ],
                  ),
                  gap(),
                  Text(testingOtp),
                  Text(testOtp),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
