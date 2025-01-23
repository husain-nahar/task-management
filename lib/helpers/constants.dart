import 'exports.dart';

// BASE URL
String liveUrl = "https://api.brindatt.xyz/";

// PRINT TO THE LOG
printT(String? str) => debugPrint("");
// printT(String? str) => debugPrint(openString(str));

// COMON HEIGHT FOR FIELDS & BUTTONS
double defaultHeightForButonTextField = 45;

// DEFAULT SPACING
double defaultPading = 15;

// MEDIA QUERY
MediaQueryData? get mediaQuery {
  BuildContext? context = Get.key.currentContext;

  return context == null ? null : MediaQuery.of(context);
}

//SIZE OF THE SCREEN
Size? get screenSize => mediaQuery?.size;

//WIDTH OF THE SCREEN
double get screenWidth => openNumber(screenSize?.width) as double;

//HEIGHT OF THE SCREEN
double get screenHeight => openNumber(screenSize?.height) as double;

const android = "android";
const androidId = 1;

const ios = "ios";
const iosId = 2;

const othersStr = "others";
const othersId = 3;

// ALL COLORS
const whiteColor = Colors.white;
const blackColor = Colors.black;
const redColor = Colors.redAccent;
const transperentColor = Colors.transparent;
Color lightGrayColor = Colors.grey[100] ?? whiteColor;
Color greenColor = Colors.green[900] ?? Colors.greenAccent;

// INDEXES
int zeroIndex = 0;
int firstIndex = 1;
int secondIndex = 2;

// RADIUS
BorderRadius borderRadius12 = BorderRadius.circular(12.0);
Radius radius12 = const Radius.circular(12.0);
Radius radius0 = const Radius.circular(0);

// CEL HEIGHT
double defaultProductCelHeight = 375.0;

// EMPTY CONTAINER
Widget get emptyContainer => Container();

// TRANSLATIONS
const task = "Task";
const selectCountryStr = "Select country";
const phoneNumberStr = "Phone number";
const resendCodeStr = "Resend code";
const submitStr = "Submit";
const providePhoneNumberStr = "Provide a phone number";
const enterOtp = "Please enter your mobile number to receive otp";
const deleteAl = "Delete All";
const enterTitle = "Enter title";
const enterDescription = "Enter description";
const submit = "Submit";
const testMobileNumber = "+96512345678";
const mustTitle = "Must have a title";
const mustDescription = "Must have a description";
const sureDeleteAl = "Are you sure you want to delete all";
const yesStr = "Yes";
const okStr = "OK";
const noStr = "No";
const cancel = "Cancel";
const fieldsCantBeEmpty = "Fields must not be empty";
const noChangesMade = "No changes were made";
const editAt = "Edit at";
const createdAt = "Created at";
const dateFormat = "dd/MM/yyyy, hh:mm:ss a";
const editTaskStr = "Edit task";
const sureDelete = "Are you sure you want to delete?";
const confirm = "Confirm";
const youAreConectedToInternet = "You are connected to the internet";
const youAreNotConectedToInternet = "You are not connected to the internet";
const localTasksEmpty =
    "Your local tasks are empty when you were offline, Do you want to delete them from cloud as well?";
const overideFromCloud = "Override tasks from cloud";
const localHasData =
    "Local tasks are more than what you have on cloud, Do you want to upload them to cloud as well?";
const deleteLocal = "Delete local tasks!";

const localHasLes =
    "Local tasks are less than what you have on cloud, Do you want to save them locally as well?";
const deleteCloud = "Delete tasks from cloud!";
const tasksEditedLocaly = "You have made changes to the following titles: ";
const tasksEditedLocaly2 = "Do you want to upload them to cloud?";
const discardChanges = "Discard changes";
const logoutStr = "LOGOUT";
const sureLogout = "Are you sure you want to logout?";

// TEST NUMBERS
const testingNumbers =
    "Testing numbers are below, Please use them, select country as kuwait.";
const testNum1 = "+96512345678";
const testNum2 = "+96523456789";
const testingOtp = "Testing OTP";

const String testOtp = "123456";

// HIVE BOX STRING
String taskHiveBox = "TaskHiveBox";
