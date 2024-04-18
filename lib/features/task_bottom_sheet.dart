
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/services/snack_bar_service.dart';
import 'package:todo_app/core/utils/extract_date_time.dart';
import 'package:todo_app/features/firebase_utils.dart';
import 'package:todo_app/features/setting_provider.dart';
import 'package:todo_app/models/task_model.dart';

import '../core/widgets/custom_text_field.dart';

class TaskBottomSheet extends StatefulWidget {

   TaskBottomSheet({super.key});

  @override
  State<TaskBottomSheet> createState() => _TaskBottomSheetState();
}

class _TaskBottomSheetState extends State<TaskBottomSheet> {
   var  titleController=TextEditingController();

   var descriptionController=TextEditingController();

   var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var vm=Provider.of<SettingProvider>(context);
    return Container(
      decoration:  BoxDecoration(
        color: vm.isDark()?const Color(0xff141922): Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 15,),
              Text("Add A New Task",style:theme.textTheme.titleLarge?.copyWith(
                color:vm.isDark()?Colors.white:Colors.black,

              ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15,),
              CustomTextField(
                controller: titleController,
                hint: "Enter your task title",
                hintColor: Colors.grey.shade600,
                onValidate: (value) {
                  if(value==null||value.trim().isEmpty){
                    return "Please enter your task title";
                  }
                  return null;

                },
              ),
              const SizedBox(height: 15,),
              CustomTextField(
                controller: descriptionController,
                hint: "Enter your task description",
                hintColor: Colors.grey.shade600,
                maxLines: 3,
                maxLength: 150,
                onValidate: (value) {
                  if(value==null||value.trim().isEmpty){
                    return "Please enter your task description";
                  }
                  return null;

                },
              ),
              const SizedBox(height: 15),
              Text("Select Time",style: theme.textTheme.bodyMedium?.copyWith(
                color:vm.isDark()?Colors.grey.shade500:Colors.black,
              ),),
              GestureDetector(
                onTap: (){
                  vm.selectTaskDate(context);
                },
                child: Text(DateFormat.yMMMMd().format(vm.selectedate),style: theme.textTheme.bodyMedium?.copyWith(
                  color:vm.isDark()?Colors.white:Colors.grey.shade500,
                ),
                textAlign: TextAlign.center,),
              ),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 20),
                ),
                  onPressed: (){
                  if(formKey.currentState!.validate()){
                    var data = TaskModel(
                        title: titleController.text,
                        description: descriptionController.text,
                        dateTime: extractDateTime(vm.selectedate),
                        isDone: false);
                    EasyLoading.show();
                    FirebaseUtils().addNewTask(data).then((value) {
                      EasyLoading.dismiss();
                      Navigator.pop(context);
                      SnackBarService.showSuccessMesage("task Created Successfully");
                    }).onError((error, stackTrace) {
                      EasyLoading.dismiss();
                    });
                  }
                  },
                  child: Text("Add Task",style: theme.textTheme.titleMedium?.copyWith(
                color: Colors.white,
                    fontWeight: FontWeight.w500,
              ),))
            ],
          ),
        ),
      ),
    );
  }
}
