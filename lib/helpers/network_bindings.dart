import 'exports.dart';

class NetworkBinding implements Bindings {
  @override
  void dependencies() {
    // AUTH GETX CONTROLER
    Get.lazyPut(
      () => AuthControler(),
      fenix: true,
    );
    // INITIAL GETX CONTROLER
    Get.lazyPut(
      () => InitialControler(),
      fenix: true,
    );
    // CONECTIVITY GETX CONTROLER
    Get.lazyPut(
      () => ConectivityControler(),
      fenix: true,
    );
  }
}

//GETX CONTROLERS INSTANCES
// AUTH GETX CONTROLER
AuthControler get authControler => AuthControler.instance;
// INITIAL GETX CONTROLER
InitialControler get initialControler => InitialControler.instance;
// CONECTIVITY GETX CONTROLER
ConectivityControler get conectivityControler => ConectivityControler.instance;
