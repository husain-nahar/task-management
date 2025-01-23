import 'package:task_management/helpers/exports.dart';
import 'package:task_management/helpers/models/firestore_database.dart';

class InitialControler extends GetxController {
  // GLOBAL INITIALIZATION
  static InitialControler instance = Get.find<InitialControler>();

  // OBSERVABLE VARIABLES
  final Rx<TextEditingController> _titleTextEditingControler =
      TextEditingController().obs;
  final Rx<TextEditingController> _descriptionTextEditingControler =
      TextEditingController().obs;

  final RxList<Task> _tasksList = <Task>[].obs;

  // LOCAL VARIABLES
  final FocusNode _fieldFocusNode = FocusNode();
  // bool updateLocal = false;

  //CUSTOM GETTERS
  TextEditingController get getTitleTextEditingControler =>
      _titleTextEditingControler.value;

  TextEditingController get getDescriptionTextEditingControler =>
      _descriptionTextEditingControler.value;
  FocusNode get getFieldFocusNode => _fieldFocusNode;

  List<Task> get getTasksList => _tasksList;

  // CUSTOM SETTERS
  set setTasksList(List<Task> tasks) {
    _tasksList.value = tasks;
    // if (updateLocal) {
    updateHive(
      tasks: tasks,
    );
    // }
  }

  //DEFAULT FUNCTIONS
  @override
  void onInit() {
    super.onInit();
    printT("ON INIT CALED OF INITIAL CONTROLER");
  }

  @override
  void onReady() {
    super.onReady();
    printT("ON READY CALED OF INITIAL CONTROLER");
    // refreshList();
  }

  @override
  void onClose() {
    super.onClose();
    printT("ON CLOSE CALED OF INITIAL CONTROLER");
  }

  @override
  void dispose() {
    super.dispose();
    printT("ON DISPOSE CALED OF INITIAL CONTROLER");

    for (var controler in [
      getTitleTextEditingControler,
      getDescriptionTextEditingControler,
    ]) {
      controler.dispose();
    }
    getFieldFocusNode.dispose();
  }

// CUSTOM FUNCTIONS
// UPDATE LOCAL STORAGE [HIVE]
  Future<void> updateHive({
    required List<Task> tasks,
  }) async {
    printT("CAME TO UPDATE");
    printT("FIRST TIME UZER: ${GetXStorage.getFirstTime}");

    if (validateBoolean(GetXStorage.getFirstTime)) {
      // REMOVING ALL TASKS FROM HIVE
      await HiveDatabase().deleteAlTasks();

      // ADDING ALL FIRESTORE CLOUD TASKS TO HIVE
      for (final task in tasks) {
        await HiveDatabase().adTask(
          task: task,
        );
        // }
      }
      await GetXStorage.setFirstTime(
        value: false,
      );
      printT("FIRST TIME UZER 2: ${GetXStorage.getFirstTime}");
    }
  }

// FETCH ALL TASKS
  Future<void> refreshList() async {
    final collection = await FirestoreDatabase().tasksRef.get();

    List<Task> fireStoreTasksList = [];
    List<Task> hiveTasksList = await HiveDatabase().tasksList();
    List<Task> latestTasks;

    for (var task in collection.docs) {
      var tempTask = task.data();

      fireStoreTasksList.add(tempTask as Task);
    }

    if (!conectivityControler.noInternet) {
      // SHOW FIRESTORE
      latestTasks = fireStoreTasksList;
    } else {
      // SHOW HIVE
      latestTasks = hiveTasksList;
    }

    // updateLocal = true;
    setTasksList = latestTasks.reversed.toList();

    for (var task in fireStoreTasksList) {
      printT(
          "FIRESTORE TASK: ID: ${task.id}, UNIQUE-ID: ${task.uniqueId}, TITLE: ${task.title}, DESCRIPTION: ${task.description}");
    }
    for (var task in hiveTasksList) {
      printT(
          "HIVE TASK: ID: ${task.id}, UNIQUE-ID: ${task.uniqueId}, TITLE: ${task.title}, DESCRIPTION: ${task.description}");
    }
  }

// SHOW BOTOM DIALOG OF TEXTFIELDS
  _showBotomSheet(
    BuildContext context, {
    int? index,
  }) {
    // Show bottom sheet with options for adding a new task or editing an existing one
    showModalBottomSheet(
      context: context,
      elevation: 5,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: defaultPading,
            right: defaultPading,
            left: defaultPading,
          ),
          child: Column(
            children: [
              Text(
                (index == null) ? task : editTaskStr,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              gap(),
              TextField(
                controller: getTitleTextEditingControler,
                decoration: InputDecoration(hintText: enterTitle),
                focusNode: getFieldFocusNode,
              ),
              gap(),
              TextField(
                controller: getDescriptionTextEditingControler,
                decoration: InputDecoration(hintText: enterDescription),
              ),
              gap(),
              CustomBtn(
                text: submit,
                onPresed: () async {
                  printT("EDITOR SUBMIT BUTON PRESED");

                  if (index != null) {
                    // EDITING THE TASK
                    final String previousTitle =
                        openString(getTasksList[index].title);
                    final String previousDescription =
                        openString(getTasksList[index].description);

                    if (getTitleTextEditingControler.text.isEmpty ||
                        getDescriptionTextEditingControler.text.isEmpty) {
                      return showInfoAlert(fieldsCantBeEmpty);
                    } else {
                      if (getTitleTextEditingControler.text == previousTitle &&
                          getDescriptionTextEditingControler.text ==
                              previousDescription) {
                        return showInfoAlert(noChangesMade);
                      }

                      Task updatedTask = Task(
                        id: getTasksList[index].id,
                        uniqueId: getTasksList[index].uniqueId,
                        title: getTitleTextEditingControler.text,
                        description: getDescriptionTextEditingControler.text,
                        createdDate: getTasksList[index].createdDate,
                        editedDate: DateTime.now(),
                        editedLocaly: true,
                      );

                      if (!conectivityControler.noInternet) {
                        // UPDATING TO THE CLOUD
                        await FirestoreDatabase().updateTask(
                          updatedTask: updatedTask,
                        );

                        // NOW ADING LOCALY
                        await HiveDatabase().updateTask(
                          atIndex: index,
                          updatedTask: updatedTask,
                        );
                      } else {
                        // UPDATING LOCALY
                        await HiveDatabase().updateTask(
                          atIndex: index,
                          updatedTask: updatedTask,
                        );
                      }
                    }
                  } else {
                    // ADING NEW TASK
                    if (textFieldNotValidated(getTitleTextEditingControler)) {
                      return showInfoAlert(mustTitle);
                    }
                    if (textFieldNotValidated(
                        getDescriptionTextEditingControler)) {
                      return showInfoAlert(mustDescription);
                    }

                    int id;

                    if (initialControler.getTasksList.isEmpty) {
                      id = 0;
                    } else {
                      Task task = initialControler.getTasksList.reduce(
                          ($0, $1) =>
                              (openNumber($0.uniqueId) > openNumber($1.uniqueId)
                                  ? $0
                                  : $1));
                      id = (openNumber(task.uniqueId) as int) + 1;
                    }

                    Task newTask = Task(
                        id: "",
                        uniqueId: id,
                        title: getTitleTextEditingControler.text,
                        description: getDescriptionTextEditingControler.text,
                        createdDate: DateTime.now(),
                        editedDate: null);

                    if (!conectivityControler.noInternet) {
                      // ADING TO THE CLOUD
                      DocumentReference<Object?> recievedObject =
                          await FirestoreDatabase().adTask(
                        newTask,
                      );
                      newTask.id = recievedObject.id;

                      await FirestoreDatabase().updateTask(
                        updatedTask: newTask,
                      );
                      // NOW ADING LOCALY
                      await HiveDatabase().adTask(
                        task: newTask,
                      );
                    } else {
                      // ADING LOCALY
                      await HiveDatabase().adTask(
                        task: newTask,
                      );
                    }
                  }

                  printT(
                      "TASKS LIST COUNT ${initialControler.getTasksList.length}");
                  await refreshList();

                  // FIRST CLEAR THE TEXT FIELDS
                  getTitleTextEditingControler.clear();
                  getDescriptionTextEditingControler.clear();

                  // ALSO CLOSE THE BOTOM SHEET
                  GetXRouterClas.dismisControler;

                  if (!context.mounted) return;

                  // REMOVE TEXTFIELD FOCUS
                  FocusScope.of(context).unfocus();
                },
              ),
              gap(),
            ],
          ),
        );
      },
    );
  }

// SHOWS THE EDITOR WITH TEXTFIELDS
  Future<void> showEditor(
    BuildContext context, {
    int? index,
  }) async {
    _showBotomSheet(
      context,
      index: index,
    );
  }

  // EDIT A TASK
  Future<void> editTask(
    BuildContext context, {
    required int index,
  }) async {
    final String previousTitle = openString(getTasksList[index].title);
    final String previousDescription =
        openString(getTasksList[index].description);

    getTitleTextEditingControler.setText(previousTitle);
    getDescriptionTextEditingControler.setText(previousDescription);

    showEditor(
      context,
      index: index,
    );
  }

  // DELETE A TASK
  Future<void> deleteTask({
    required int atIndex,
  }) async {
    printT("INDEX WHERE DELETING: $atIndex");
    printT("FIRESTORE ID: ${getTasksList[atIndex].id}");

    if (!conectivityControler.noInternet) {
      // DELETING TO THE CLOUD
      await FirestoreDatabase().deleteTask(
        id: getTasksList[atIndex].id,
      );
      // NOW DELETING LOCALY
      await HiveDatabase().deleteTask(
        atIndex: atIndex,
      );
    } else {
      // DELETING LOCALY
      await HiveDatabase().deleteTask(
        atIndex: atIndex,
      );
    }

    refreshList();
  }

  // DELETE ALL TASKS
  Future<void> deleteAl() async {
    if (initialControler.getTasksList.isNotEmpty) {
      showCustomAlert(
        withText: sureDeleteAl,
        isNegative: true,
        btnPresed: () async {
          printT("DELETE AL PRESED");
          if (!conectivityControler.noInternet) {
            // DELETING TO THE CLOUD
            await FirestoreDatabase().deleteAlTasks();
            // NOW DELETING LOCALY
            await HiveDatabase().deleteAlTasks();
          } else {
            // DELETING LOCALY
            await HiveDatabase().deleteAlTasks();
          }
          initialControler.refreshList();
        },
      );
    }
  }

  // RESOLVE THE CONFLICT
  Future
      // <List<Task>>
      resolveConflict(
    BuildContext context, {
    required List<Task> tasksFromFireStore,
    required List<Task> tasksFromHive,
  }) async {
    // List<Task> tempTasks = [];
    // List<Task> tasksFromHive = await TaskDatabase().tasksList();

// FOR DELETE ALL LOGIC MADE LOCALLY
    if (tasksFromHive.isEmpty && numGrtrThnZero(tasksFromFireStore.length)) {
      printT("LOCAL HAS NO COUNTING BUT CLOUD HAS");
      if (!context.mounted) return;

      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(confirm),
            content: const Text(
              localTasksEmpty,
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () async {
                  printT("DELETE TASKS FROM CLOUD PRESED");
                  Navigator.of(context).pop(true);

                  await FirestoreDatabase().deleteAlTasks();
                  // updateLocal = true;
                  setTasksList = [];
                },
                child: const Text(yesStr),
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pop(false);

                  for (final task in tasksFromFireStore) {
                    await HiveDatabase().adTask(
                      task: task,
                    );
                  }
                  // updateLocal = true;
                  setTasksList = tasksFromFireStore;
                },
                child: const Text(overideFromCloud),
              ),
            ],
          );
        },
      );
    } else if (tasksFromHive.length > tasksFromFireStore.length) {
      printT("LOCAL HAS MORE THAN CLOUD");

      if (!context.mounted) return;
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(confirm),
            content: const Text(
              localHasData,
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () async {
                  printT("DELETE TASKS FROM CLOUD PRESED");
                  Navigator.of(context).pop(true);

                  // UPLOADING TO THE CLOUD
                  for (final task in tasksFromHive) {
                    Task? fireStoreTask = tasksFromFireStore.firstWhereOrNull(
                      ($0) => validateBoolean(
                        task.uniqueId?.isEqual(
                          openNumber($0.uniqueId),
                        ),
                      ),
                    );
                    if (fireStoreTask == null) {
                      await FirestoreDatabase().adTask(
                        task,
                      );
                    }
                  }

                  setTasksList = tasksFromHive;
                },
                child: const Text(yesStr),
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pop(false);

                  for (var index = 0; index < tasksFromHive.length; index++) {
                    Task? fireStoreTask = tasksFromFireStore.firstWhereOrNull(
                      ($0) => validateBoolean(
                        tasksFromHive[index].uniqueId?.isEqual(
                              openNumber($0.uniqueId),
                            ),
                      ),
                    );
                    if (fireStoreTask == null) {
                      await HiveDatabase().deleteTask(
                        atIndex: index,
                      );
                    }
                  }

                  setTasksList = tasksFromFireStore;
                },
                child: const Text(deleteLocal),
              ),
            ],
          );
        },
      );
    } else if (tasksFromHive.length < tasksFromFireStore.length) {
      printT("LOCAL HAS LESS THAN CLOUD");

      if (!context.mounted) return;
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(confirm),
            content: const Text(
              localHasLes,
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () async {
                  printT("SAVE TASKS FROM CLOUD TO LOCAL PRESED");
                  Navigator.of(context).pop(true);

                  // UPLOADING TO THE CLOUD
                  for (final task in tasksFromFireStore) {
                    Task? hiveTask = tasksFromHive.firstWhereOrNull(
                      ($0) => validateBoolean(
                        task.uniqueId?.isEqual(
                          openNumber($0.uniqueId),
                        ),
                      ),
                    );
                    if (hiveTask == null) {
                      await HiveDatabase().adTask(
                        task: task,
                      );
                    }
                  }

                  setTasksList = tasksFromFireStore;
                },
                child: const Text(yesStr),
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pop(false);

                  for (var index = 0;
                      index < tasksFromFireStore.length;
                      index++) {
                    Task? hiveTask = tasksFromHive.firstWhereOrNull(
                      ($0) => validateBoolean(
                        tasksFromFireStore[index].uniqueId?.isEqual(
                              openNumber($0.uniqueId),
                            ),
                      ),
                    );
                    if (hiveTask == null) {
                      await FirestoreDatabase().deleteTask(
                        id: tasksFromFireStore[index].id,
                      );
                    }
                  }
                  setTasksList = tasksFromHive;
                },
                child: const Text(deleteCloud),
              ),
            ],
          );
        },
      );
    } else {
      printT("LOCAL AND CLOUD COUNTING SAME");

      // IF USER EDITED ANY TASK OFLINE
      List<Task> tasks = tasksFromHive;
      tasks.retainWhere(
        ($0) => $0.editedLocaly == true,
      );

      if (tasks.isNotEmpty) {
        // SOLVE AL EDITED CONFLICTS HERE
        String descpStr = tasksEditedLocaly;

        for (final task in tasks) {
          descpStr += openString(task.title);
        }
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(confirm),
              content: Text(
                "$descpStr, $tasksEditedLocaly2",
              ),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () async {
                    printT("EDIT TASKS ON CLOUD PRESED");
                    Navigator.of(context).pop(true);

                    for (var i = 0; i < tasks.length; i++) {
                      tasks[i].editedLocaly = false;
                      await FirestoreDatabase().updateTask(
                        updatedTask: tasks[i],
                      );
                      await HiveDatabase().updateTask(
                        atIndex: i,
                        updatedTask: tasks[i],
                      );
                    }
                    setTasksList = tasksFromHive;
                  },
                  child: const Text(yesStr),
                ),
                ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context).pop(false);

                    for (final task in tasksFromFireStore) {
                      await HiveDatabase().deleteAlTasks();
                      await HiveDatabase().adTask(
                        task: task,
                      );
                    }
                    setTasksList = tasksFromFireStore;
                  },
                  child: const Text(discardChanges),
                ),
              ],
            );
          },
        );
      } else {
        setTasksList = tasksFromFireStore;
      }
    }
  }

  Widget returningWidget({
    required List<Task> tasks,
  }) {
    Future.delayed(
      Duration(milliseconds: 250),
      () {
        // updateLocal = false;
        initialControler.setTasksList = tasks;
        // .reversed.toList();
      },
    );

    return GetX<InitialControler>(builder: (_) {
      return ListView.builder(
          itemCount: initialControler.getTasksList.length,
          itemBuilder: (
            BuildContext context,
            int index,
          ) {
            return Padding(
              padding: EdgeInsets.all(defaultPading),
              child: DismisableWidget(
                index: index,
              ),
            );
          });
    });
  }
}
