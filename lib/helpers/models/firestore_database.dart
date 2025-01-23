import 'package:task_management/helpers/exports.dart';

const String taskRef = "tasks";

// DATABASE FOR THE FIRESTORE
class FirestoreDatabase {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference tasksRef;

  FirestoreDatabase() {
    tasksRef = _firestore.collection(taskRef).withConverter<Task>(
          fromFirestore: (DocumentSnapshot<Map<String, dynamic>> snapshot, _) =>
              Task.fromJson(snapshot.data()!),
          toFirestore: (Task task, _) => task.toJson(),
        );
  }

// READ ALL TASKS
  Stream<QuerySnapshot> tasksList() {
    return tasksRef.snapshots();
  }

  // ADD TASK
  Future<DocumentReference<Object?>> adTask(Task task) async {
    DocumentReference<Object?> savedObject = await tasksRef.add(task);
    return savedObject;
  }

  // UPDATE TASK
  Future<void> updateTask({
    required Task updatedTask,
  }) async {
    tasksRef.doc(updatedTask.id).update(
          updatedTask.toJson(),
        );
  }

  // DELETE TASK
  Future<void> deleteTask({
    required String? id,
  }) async {
    tasksRef.doc(id).delete();
  }

  // DELETE ALL TASKS
  Future<void> deleteAlTasks() async {
    final collection = await tasksRef.get();
    final batch = _firestore.batch();

    for (final doc in collection.docs) {
      batch.delete(doc.reference);
    }
    return await batch.commit();
  }
}
