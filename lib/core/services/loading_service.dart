import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoadingService{
  easyLoading(){
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.circle
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..backgroundColor = Colors.white
      ..indicatorColor = Colors.yellow
      ..textColor = Colors.white
      ..maskColor =Color(0xff5D9CEC)
      ..userInteractions = false
      ..dismissOnTap = false;
  }
}