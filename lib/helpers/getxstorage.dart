import 'exports.dart';

// LOCAL STORAGE USING GETX
class GetXStorage {
  static GetStorage storage = GetStorage();

  static const String stApInstaledFirstTime = "stApInstaledFirstTime";
  static const String stIsLogedIn = "stIsLogedIn";

  static Future setFirstTime({bool? value}) async {
    await storage.write(
      stApInstaledFirstTime,
      value,
    );
    await storage.save();
  }

  static bool? get getFirstTime {
    bool? value = storage.read(
      stApInstaledFirstTime,
    );
    return value;
  }

  static Future setIsLogedIn({bool? value}) async {
    await storage.write(
      stIsLogedIn,
      value,
    );
    await storage.save();
  }

  static bool? get getIsLogedIn {
    bool? value = storage.read(
      stIsLogedIn,
    );
    return value;
  }
}
