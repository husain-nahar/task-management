import 'package:task_management/helpers/exports.dart';

class MyAp extends StatefulWidget {
  const MyAp({super.key});

  @override
  State<MyAp> createState() => _MyApState();
}

class _MyApState extends State<MyAp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyTheme.lightTheme,
      themeMode: ThemeMode.light,
      // HERE IT DECIDES WHICH SCREEN TO GO
      initialRoute: validateBoolean(GetXStorage.getIsLogedIn)
          ? GetXRouterClas.initialRoute
          : GetXRouterClas.authRoute,
      getPages: GetXRouterClas.routes,
      unknownRoute: GetPage(
        name: GetXRouterClas.authRoute,
        page: () => const AuthVC(),
      ),
    );
  }
}
