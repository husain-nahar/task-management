import 'package:task_management/helpers/exports.dart';

// LOCAL HIVE DATABASE
class HiveDatabase {
  // OPEN BOX
  Future<Box> taskBox() async {
    return await Hive.openBox<Task>(taskHiveBox);
  }

// READ ALL TASKS
  Future<List<Task>> tasksList() async {
    Box box = await taskBox();

    List<Task> tasks = box.values.toList() as List<Task>;

    return tasks;
  }

  // ADD TASK
  Future<void> adTask({
    required Task task,
  }) async {
    Box box = await taskBox();

    await box.add(task);
  }

  // UPDATE TASK
  Future<void> updateTask({
    required int atIndex,
    required Task updatedTask,
  }) async {
    Box box = await taskBox();

    box.putAt(atIndex, updatedTask);
  }

  // DELETE TASK
  Future<void> deleteTask({
    required int atIndex,
  }) async {
    Box box = await taskBox();

    await box.deleteAt(atIndex);
  }

  // DELETE ALL TASKS
  Future<void> deleteAlTasks() async {
    Box box = await taskBox();

    await box.clear();
  }
}
