import 'exports.dart';

enum RouteEnum {
  auth,
  initial,
  details;

  static String enumValue(RouteEnum value) {
    switch (value) {
      case RouteEnum.initial:
        return GetXRouterClas.initialRoute;

      default:
        return GetXRouterClas.authRoute;
    }
  }
}
