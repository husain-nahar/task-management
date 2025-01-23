import 'exports.dart';

// JUST THE LIGHT THEME
class MyTheme {
  MyTheme._();

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: whiteColor,
      foregroundColor: blackColor,
      iconTheme: IconThemeData(color: blackColor),
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),
    scaffoldBackgroundColor: whiteColor,
    iconTheme: const IconThemeData(
      color: blackColor,
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          transperentColor,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              radius12,
            ),
          ),
        ),
        iconColor: WidgetStateProperty.all(whiteColor),
        backgroundColor: WidgetStateProperty.all(blackColor),
        foregroundColor: WidgetStateProperty.all(whiteColor),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      errorStyle: const TextStyle(fontSize: 0.75),
      focusedBorder: outlineBorder(blackColor),
      enabledBorder: outlineBorder(blackColor),
      errorBorder: outlineBorder(redColor),
      focusedErrorBorder: outlineBorder(redColor),
    ),
  );
}
