import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/features/Tasks/page/update_task.dart';
import 'package:todo_app/features/Tasks/page/update_task.dart';

import '../../../core/services/snack_bar_service.dart';
import '../../../core/utils/extract_date_time.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../models/task_model.dart';
import '../../firebase_utils.dart';
import '../../setting_provider.dart';
import '../../translation/locale_keys.g.dart';

class UpdateTaskWidget extends StatefulWidget {
  static const String route_name = "UpdateTask";
  TaskModel? taskModel;

  UpdateTaskWidget({super.key, this.taskModel});

  @override
  State<UpdateTaskWidget> createState() => _UpdateTaskWidgetState();
}

class _UpdateTaskWidgetState extends State<UpdateTaskWidget> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late ThemeData theme;
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.taskModel!.title);
    descriptionController =
        TextEditingController(text: widget.taskModel!.description);
  }

  @override
  Widget build(BuildContext context) {
    // var theme = Theme.of(context);
    var vm = Provider.of<SettingProvider>(context);
    theme = Theme.of(context);

    // Create a FocusNode instance
    FocusNode focusNode = FocusNode();

    // Add listener to close the keyboard when the node receives focus
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        FocusManager.instance.primaryFocus?.unfocus();
      }
    });
    return FocusScope(
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 15,
              ),
              Text(
                "Edit Task",
                style: theme.textTheme.titleLarge?.copyWith(
                  color: vm.isDark() ? Colors.white : Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 15,
              ),
              CustomTextField(
                controller: titleController,
                hint: "this is title",
                hintColor: Colors.grey.shade600,
                onValidate: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter your task title";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              CustomTextField(
                controller: descriptionController,
                hint: "task details",
                hintColor: Colors.grey.shade600,
                maxLines: 3,
                maxLength: 150,
                onValidate: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter your task description";
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              Text(
                "Select Time",
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: vm.isDark() ? Colors.grey.shade500 : Colors.black,
                ),
              ),
              GestureDetector(
                onTap: () {
                  vm.selectTaskDate(context);
                },
                child: Text(
                  DateFormat.yMMMMd().format(vm.selectedate),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: vm.isDark() ? Colors.white : Colors.grey.shade500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Spacer(),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 20),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      EasyLoading.show();
                      widget.taskModel!.title = titleController.text;
                      widget.taskModel!.description = descriptionController.text;
                      FirebaseUtils()
                          .updateTask(widget.taskModel!)
                          .then((value) {
                        EasyLoading.dismiss();
                        Navigator.pop(context);
                        SnackBarService.showSuccessMesage(
                            "Task updated successfully");
                      });
                    }
                  },
                  child: Text(
                    "Save Change",
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ))
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Close"),
          ),
        ],
      ),
    );
  }
}
