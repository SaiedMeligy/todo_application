import 'package:flutter/material.dart';
import 'package:todo_app/features/Setting/page/setting_view.dart';
import 'package:todo_app/features/Tasks/page/task_view.dart';

class SettingProvider extends ChangeNotifier{
  ThemeMode current_theme=ThemeMode.light;
  int current_index=0;
  DateTime selectedate=DateTime.now();
  List<Widget>screens=[
    const TaskView(),
    const SettingView(),
  ];
  String current_language="ar";
  selectTaskDate(BuildContext context) async {
    var currentSelectedDate=await showDatePicker(context: context,
    initialDate: selectedate,
    currentDate: DateTime.now(),
    firstDate: DateTime.now(),
        lastDate: selectedate.add(Duration(days: 365),
    ));
    if(currentSelectedDate==null) return;
    selectedate=currentSelectedDate;
    notifyListeners();
  }


  changeTheme(ThemeMode newTheme){
    if(current_theme==newTheme) return;
    current_theme =newTheme;
    notifyListeners();
  }
  changeLanguage(String newLanguage){
    if(current_language==newLanguage) return;
    current_language=newLanguage;
    notifyListeners();

  }
  changeIndex(index){
    current_index=index;
    notifyListeners();
  }
  bool isDark(){
    return current_theme == ThemeMode.dark;
  }
}