import 'package:task_management/helpers/exports.dart';
part 'task.g.dart';

// HIVE ADAPTERS STRUCTURE
@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  int? uniqueId;

  @HiveField(2)
  String? title;

  @HiveField(3)
  String? description;

  @HiveField(4)
  DateTime? createdDate;

  @HiveField(5)
  DateTime? editedDate;

  @HiveField(6)
  bool? editedLocaly;

  Task({
    this.id,
    this.uniqueId,
    this.title,
    this.description,
    this.createdDate,
    this.editedDate,
    this.editedLocaly,
  });

  Task.fromJson(Map<String, Object?> json)
      : this(
          id: json['id'] as String?,
          uniqueId: json['uniqueId'] as int?,
          title: json['title'] as String?,
          description: json['description'] as String?,
          createdDate: (json['createdDate'] as Timestamp?)?.toDate(),
          editedDate: (json['editedDate'] as Timestamp?)?.toDate(),
          editedLocaly: json['editedLocaly'] as bool?,
        );

  Task copyWith({
    String? id,
    int? uniqueId,
    String? title,
    String? description,
    DateTime? createdDate,
    DateTime? editedDate,
    bool? editedLocaly,
  }) {
    return Task(
      id: id ?? this.id,
      uniqueId: uniqueId ?? this.uniqueId,
      title: title ?? this.title,
      description: description ?? this.description,
      createdDate: createdDate ?? this.createdDate,
      editedDate: editedDate ?? this.editedDate,
      editedLocaly: editedLocaly ?? this.editedLocaly,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'uniqueId': uniqueId,
      'title': title,
      'description': description,
      'createdDate': createdDate,
      'editedDate': editedDate,
      'editedLocaly': editedLocaly,
    };
  }
}
