import 'exports.dart';

class CalApi {
  const CalApi._();

  // SIGN IN TO FIREBASE
  static Future signInToFirebase(
    String? stringCredential,
  ) async {
    try {
      printT("VERIF ID: ${authControler.getPhoneVerificationId}");
      printT("SMS CODE: ${authControler.getOtpTextEditingControler.text}");

      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: authControler.getPhoneVerificationId,
        smsCode: authControler.getOtpTextEditingControler.text,
      );
      await FirebaseAuth.instance.signInWithCredential(
        credential,
      );
      printT("SIGN IN SUCCESS");
      authControler.setResendingCode = false;
      authControler.resetTimer();

      InitialVC.shouldntGoBack = true;
      GetXRouterClas.presentControler(
        RouteEnum.initial,
        isInitialControler: true,
      );
      GetXStorage.setIsLogedIn(
        value: true,
      );
      hideLoader();
    } on FirebaseAuthException catch (e) {
      printT("ERROR HERE SIGN IN FIREBASE");
      showInfoAlert(e.message);
    } catch (e) {
      hideLoader();
      printT("something went wrong inside SIGN IN FIREBASE");
    }
    printT("ENDING OF SIGN IN FIREBASE REACHED");
  }
}
