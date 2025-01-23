import 'exports.dart';

// TO CEHCK INTERNET
class ConectivityControler extends GetxController {
  // GLOBAL INITIALIZATION
  static ConectivityControler instance = Get.find<ConectivityControler>();

  // OBSERVABLE VARIABLES
  final RxBool _noInternet = false.obs;

  late Stream<List<ConnectivityResult>> internetStateChanges;
  Connectivity conectivity = Connectivity();

  //CUSTOM GETTERS
  bool get noInternet => _noInternet.value;

  // CUSTOM SETTERS
  set setNoInternet(bool value) => _noInternet.value = value;

  //DEFAULT FUNCTIONS
  @override
  void onInit() {
    super.onInit();
    printT("ON INIT CALLED OF CONECTIVITY CONTROLER");
  }

  @override
  void onReady() async {
    super.onReady();
    printT("ON READY CALLED OF CONECTIVITY CONTROLER");

    List<ConnectivityResult> cRList = await conectivity.checkConnectivity();

    if (cRList.first == ConnectivityResult.none) {
      setNoInternet = true;
    }

    internetStateChanges = conectivity.onConnectivityChanged;

    internetStateChanges.listen(
      (result) {
        if (result.first == ConnectivityResult.mobile ||
            result.first == ConnectivityResult.wifi ||
            result.first == ConnectivityResult.ethernet) {
          if (noInternet) {
            printT("HERE WITH INTERNET");
            setNoInternet = false;
          }
        } else {
          printT("HERE WITH NO INTERNET");
          setNoInternet = true;
        }
      },
    );
  }

  @override
  void onClose() {
    super.onClose();
    printT("ON CLOSE CALED OF CONECTIVITY CONTROLER");
  }

  @override
  void dispose() {
    super.dispose();
    printT("ON DISPOSE CALED OF CONECTIVITY CONTROLER");
  }
}
