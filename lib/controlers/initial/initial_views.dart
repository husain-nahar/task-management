import 'package:task_management/helpers/exports.dart';

class DismisableWidget extends StatelessWidget {
  const DismisableWidget({
    super.key,
    required int index,
  }) : _index = index;

  final int _index;

  @override
  Widget build(BuildContext context) {
    Task task = initialControler.getTasksList[_index];

    return Dismissible(
      key: Key(
        openString(
          task.id?.toString(),
        ),
      ),
      background: Container(
        decoration: BoxDecoration(
          color: redColor,
          borderRadius: borderRadius12,
        ),
      ),
      confirmDismiss: (DismissDirection direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(confirm),
              content: const Text(
                sureDelete,
              ),
              actions: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      printT("DELETE TASK PRESED");
                      Navigator.of(context).pop(true);
                      initialControler.deleteTask(
                        atIndex: _index,
                      );
                    },
                    child: const Text(yesStr)),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text(cancel),
                ),
              ],
            );
          },
        );
      },
      child: CardWidget(
        index: _index,
        // task: task,
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required int index,
  }) : _index = index;

  final int _index;

  @override
  Widget build(BuildContext context) {
    Task task = initialControler.getTasksList[_index];
    final DateTime? createdDate = task.createdDate;
    final DateTime? editedDate = task.editedDate;
    final DateFormat formater = DateFormat(dateFormat);
    final String createdDateString = formater.format(
      createdDate ?? DateTime.now(),
    );
    final String editedDateString = formater.format(
      editedDate ?? DateTime.now(),
    );
    return Card(
      color: lightGrayColor,
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(defaultPading),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  openString(task.title?.capitalizeFirst),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                IconButton(
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: borderRadius12,
                      ),
                    ),
                    backgroundColor: WidgetStatePropertyAll(transperentColor),
                  ),
                  icon: Icon(
                    Icons.edit,
                    color: blackColor,
                  ),
                  onPressed: () {
                    printT("EDIT BUTON PRESED OF INDEX: $_index");
                    initialControler.editTask(
                      context,
                      index: _index,
                    );
                  },
                ),
              ],
            ),
            gap(),
            Text(
              openString(task.description?.capitalizeFirst),
            ),
            gap(),
            Row(
              children: [
                Expanded(
                  child: customRichText(
                    context,
                    firstStr: createdAt,
                    secondStr: createdDateString,
                    explicitColor: greenColor,
                  ),
                ),
                if (editedDate != null) ...[
                  Expanded(
                    child: customRichText(
                      context,
                      firstStr: editAt,
                      secondStr: editedDateString,
                      explicitColor: redColor,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
