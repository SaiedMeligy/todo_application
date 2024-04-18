import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/services/snack_bar_service.dart';
import 'package:todo_app/features/Tasks/page/update_task.dart';
import 'package:todo_app/models/task_model.dart';

import '../../../core/utils/extract_date_time.dart';
import '../../firebase_utils.dart';
import '../../setting_provider.dart';

class TaskWidget extends StatelessWidget {
  TaskModel taskModel;
  TaskWidget({super.key, required this.taskModel});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var vm = Provider.of<SettingProvider>(context);
    var formKey=GlobalKey<FormState>();
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Slidable(
            key: const ValueKey(0),
            startActionPane: ActionPane(
                extentRatio: 0.6, //use for width
                closeThreshold: 0.5,
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      EasyLoading.show();
                      var data = TaskModel(
                          title: taskModel.title,
                          description: taskModel.description,
                          dateTime: taskModel.dateTime,
                          isDone: true,
                          id: taskModel.id);
                      FirebaseUtils().deleteTask(data).then((value) {
                        EasyLoading.dismiss();
                        Navigator.pop(context);
                        SnackBarService.showSuccessMesage(
                            "Task deleted successfully");
                      });
                    },
                    backgroundColor: Color(0xFFFE4A49),
                    foregroundColor: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                  SlidableAction(
                    onPressed:(context) {
                      showDialog(context: context, builder: (context) =>
                          UpdateTaskWidget(taskModel:TaskModel(title: taskModel.title,
                              description: taskModel.description,
                              dateTime: taskModel.dateTime,
                              isDone: true,
                              id: taskModel.id )));
                    },
                    backgroundColor: theme.primaryColor,
                    foregroundColor: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    icon: Icons.edit,
                    label: 'update',
                  ),
                ]),
            child: ListTile(
                leading: VerticalDivider(
                  thickness: 4,
                  width: 4,
                  color: theme.primaryColor,
                  indent: 2,
                ),
                title: Text(taskModel.title,
                    style: theme.textTheme.bodyMedium!.copyWith(
                        color: taskModel.isDone
                            ? Color(0xff61E757)
                            : theme.primaryColor)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(taskModel.description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: vm.isDark()
                            ? theme.textTheme.bodySmall
                            : theme.textTheme.bodySmall!
                                .copyWith(color: Colors.black)),
                    Row(
                      children: [
                        Icon(Icons.access_alarm_rounded,
                            color: vm.current_theme == ThemeMode.light
                                ? Colors.grey.shade600
                                : Colors.white),
                        Text(DateFormat.yMMMd().format(taskModel.dateTime),
                            style: vm.current_theme == ThemeMode.light
                                ? theme.textTheme.bodySmall!
                                    .copyWith(color: Colors.grey.shade600)
                                : theme.textTheme.bodySmall)
                      ],
                    ),
                  ],
                ),
                trailing: taskModel.isDone
                    ? Text(
                        "Done !",
                        style: theme.textTheme.titleLarge
                            ?.copyWith(color: Color(0xff61E757)),
                      )
                    : InkWell(
                  onTap: () {
                    // showDialog(context: context, builder: (context) =>
                    // UpdateTaskWidget(taskModel:TaskModel(title: taskModel.title,
                    //     description: taskModel.description,
                    //     dateTime: taskModel.dateTime,
                    //     isDone: true,
                    //     id: taskModel.id )));
  },
                      child: Container(
                          decoration: BoxDecoration(
                              color: theme.primaryColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Icon(
                            Icons.check_rounded,
                            size: 40,
                            color:Colors.white,
                          ),
                        ),
                    ),
                contentPadding: EdgeInsets.all(5),
                tileColor: vm.current_theme == ThemeMode.light
                    ? Colors.white
                    : Color(0xFF141922),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)))),
      ),
    );
  }
}
