import 'package:task_management/helpers/exports.dart';

class AuthControler extends GetxController {
  // GLOBAL INITIALIZATION
  static AuthControler instance = Get.find<AuthControler>();
  static int defaultTimerTime = 60;

  // OBSERVABLE VARIABLES
  final Rx<TextEditingController> _phoneTextEditingControler =
      TextEditingController().obs;
  final Rx<TextEditingController> _otpTextEditingControler =
      TextEditingController().obs;

  final RxString _phoneVerificationId = "".obs;

  final Rx<Country?> _selectedCountry = (null as Country?).obs;
  final RxBool _resendingCode = false.obs;
  final RxInt _timerInt = defaultTimerTime.obs;
  final RxBool _visibleOtpFields = false.obs;

  // LOCAL VARIABLES
  Timer? _timer;
  final FocusNode _otpFieldFocusNode = FocusNode();
  String _pincode = "";

  //CUSTOM GETTERS
  Country? get getSelectedCountry => _selectedCountry.value;
  String get getPhoneVerificationId => _phoneVerificationId.value;
  int get getTimerInt => _timerInt.value;
  bool get getResendingCode => _resendingCode.value;

  TextEditingController get getPhoneTextEditingControler =>
      _phoneTextEditingControler.value;

  TextEditingController get getOtpTextEditingControler =>
      _otpTextEditingControler.value;
  FocusNode get getOtpFieldFocusNode => _otpFieldFocusNode;
  String get pincode => _pincode;

  bool get getVisibleOtpFields => _visibleOtpFields.value;

  // CUSTOM SETTERS
  set setCountry(Country? newValue) => _selectedCountry.value = newValue;

  set setphoneVerificationId(String newValue) =>
      _phoneVerificationId.value = newValue;

  set setResendingCode(bool newValue) => _resendingCode.value = newValue;
  set setTimerInt(int newValue) {
    printT("NEW VALUE: $newValue");
    _timerInt.value = newValue;
  }

  set setPincode(String newValue) => _pincode = newValue;

  set setVisibleOtpFields(bool newValue) => _visibleOtpFields.value = newValue;

  //DEFAULT FUNCTIONS
  @override
  void onInit() {
    super.onInit();
    printT("ON INIT CALED OF AUTH CONTROLER");
  }

  @override
  void onReady() {
    super.onReady();
    printT("ON READY CALED OF AUTH CONTROLER");
  }

  @override
  void onClose() {
    super.onClose();
    printT("ON CLOSE CALED OF AUTH CONTROLER");
  }

  @override
  void dispose() {
    super.dispose();
    printT("ON DISPOSE CALED OF AUTH CONTROLER");

    for (var controler in [
      getOtpTextEditingControler,
      getPhoneTextEditingControler,
    ]) {
      controler.dispose();
    }
    getOtpFieldFocusNode.dispose();
  }

// CUSTOM FUNCTIONS
  startTimerForResendCode() {
    printT("CAME HERE FOR TIMER");

    _timer?.cancel();

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        printT("TIMERR: ${_timer?.tick}");

        setTimerInt = getTimerInt - 1;
        if (getTimerInt == 0) {
          printT("TIMER NOW ZERO");
          _timer?.cancel();
          setTimerInt = 60;
          setResendingCode = false;
        }
      },
    );
  }

  void resetTimer() {
    _timer?.cancel();
    setTimerInt = defaultTimerTime;
    setResendingCode = false;
  }

  procesVerification() {
    String phoneNumber =
        "+${authControler.getSelectedCountry?.phoneCode ?? ""}${authControler.getPhoneTextEditingControler.text}";

    printT("PHONE NUMBER: $phoneNumber");

    if (conectivityControler.noInternet) {
      return showInfoAlert(
        youAreNotConectedToInternet,
      );
    } else {
      showLoader();
      CalApi.signInToFirebase(phoneNumber);
    }
  }
}
