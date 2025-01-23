import 'package:task_management/helpers/exports.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //FIREBASE INTIALIZATION
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // INITIALIZE FIRESTORE DATABASE
  FirebaseFirestore.instance.settings = Settings(
    persistenceEnabled: true,
  );

  // INITIALIZE ALL GET X CONTROLERS
  NetworkBinding().dependencies();

  // START HIVE
  await Hive.initFlutter();

  // // CREATE HIVE BOX
  // await Hive.openBox(taskHiveBox);

  // REGISTER HIVE ADAPTER
  Hive.registerAdapter(TaskAdapter());

  //GETX LOCAL STORAGE INITIALIZATION
  await GetStorage.init();

  if (GetXStorage.getFirstTime == null) {
    GetXStorage.setFirstTime(
      value: true,
    );
  }
  runApp(const MyAp());
}
