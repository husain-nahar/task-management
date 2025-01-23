import 'package:task_management/helpers/exports.dart';
import 'package:task_management/helpers/models/firestore_database.dart';

class InitialVC extends StatelessWidget {
  const InitialVC({super.key});

  static bool shouldntGoBack = false;

  @override
  Widget build(BuildContext context) {
    // FIRESTORE DATABASE INSTANCE
    final fireStoreDatabase = FirestoreDatabase();

    if (Theme.of(context).platform == TargetPlatform.iOS) {
      if (!shouldntGoBack) {
        GetXRouterClas.dismisControler;
      } else {
        shouldntGoBack = false;
      }
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          GetX<InitialControler>(
            builder: (_) {
              if (initialControler.getTasksList.isNotEmpty) {
                return customInkWel(
                  child: Text(
                    deleteAl,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    printT("DELETE ALL PRESED");
                    initialControler.deleteAl();
                  },
                );
              } else {
                return emptyContainer;
              }
            },
          ),
          SizedBox(
            width: defaultPading,
            height: defaultPading,
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                onlineOflineSectionChildren(
                  isForInitial: true,
                ),
                gap(),
                Expanded(
                  child: GetX<ConectivityControler>(builder: (_) {
                    printT(
                        "IS NO INTERNET: ${conectivityControler.noInternet}");
                    return StreamBuilder(
                        stream: fireStoreDatabase.tasksList(),
                        builder: (
                          BuildContext context,
                          AsyncSnapshot<QuerySnapshot<Object?>> snapshot,
                        ) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.hasData) {
                            final List tasks = snapshot.data?.docs ?? [];

                            printT("TASKS ARE: $tasks");

                            List<Task> tasksList = [];

                            for (var task in tasks) {
                              var tempTask = task.data();

                              printT("TASKS ARE 1: $tempTask");

                              tasksList.add(tempTask);
                            }

                            Future.delayed(
                              Duration(seconds: 1),
                              () async {
                                List<Task> tasksFromHive =
                                    await HiveDatabase().tasksList();

                                if (!context.mounted) return;

                                initialControler.resolveConflict(
                                  context,
                                  tasksFromFireStore: tasksList,
                                  tasksFromHive: tasksFromHive,
                                );
                              },
                            );

                            return initialControler.returningWidget(
                              tasks: tasksList,
                            );
                          } else {
                            return emptyContainer;
                          }
                        });
                  }),
                ),
              ],
            ),
            // LOGOUT BUTON SECTION
            Column(
              children: [
                Spacer(),
                Padding(
                  padding: EdgeInsets.all(defaultPading * 5),
                  child: CustomBtn(
                    text: logoutStr,
                    onPresed: () {
                      printT("LOGOUT PRESED");
                      showCustomAlert(
                        withText: sureLogout,
                        isNegative: true,
                        btnText: logoutStr,
                        btnPresed: () async {
                          await FirebaseAuth.instance.signOut();
                          GetXRouterClas.presentControler(
                            RouteEnum.auth,
                            isInitialControler: true,
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          printT("FLOATING BUTON PRESED");
          initialControler.showEditor(context);
        },
        backgroundColor: blackColor,
        child: Icon(
          Icons.add,
          color: whiteColor,
        ),
      ),
    );
  }
}
