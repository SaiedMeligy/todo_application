
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/features/Login/page/login_view.dart';
import 'package:todo_app/features/Tasks/page/task_view.dart';
import 'package:todo_app/features/setting_provider.dart';
import '../../layout_view.dart';

class SplashView extends StatefulWidget {
  static const String route_name= "SplashView";
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}
class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
  Timer(Duration(seconds: 2),(){
    Navigator.pushReplacementNamed(context, LoginView.route_name);
  }
  );

  }


  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var vm = Provider.of<SettingProvider>(context);
    return Column(
      children: [
        Image.asset(
          vm.isDark()?"assets/images/splash –dark.png":"assets/images/splash.png",
          height: mediaQuery.height,
          width: mediaQuery.width,
          fit: BoxFit.fill,
        )


      ],

    );
  }
}
