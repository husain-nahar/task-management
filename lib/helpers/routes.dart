import 'exports.dart';

class GetXRouterClas {
  static const String authRoute = "/auth";
  static const String initialRoute = "/";

  static List<GetPage> routes = [
    GetPage(
      name: authRoute,
      page: () => const AuthVC(),
    ),
    GetPage(
      name: initialRoute,
      page: () => const InitialVC(),
    ),
  ];

// PRESENT VC
  static presentControler(
    RouteEnum routeName, {
    bool isInitialControler = false,
  }) {
    if (isInitialControler) {
      Get.offAllNamed(
        RouteEnum.enumValue(routeName),
      );
    } else {
      Get.toNamed(
        RouteEnum.enumValue(routeName),
      );
    }
  }

  // DISMISS CONTROLLER
  static get dismisControler {
    Get.back();
  }
}
