import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/config/App_theme_manager.dart';
import 'package:todo_app/core/services/loading_service.dart';
import 'package:todo_app/features/Login/page/login_view.dart';
import 'package:todo_app/features/Register/page/register_view.dart';
import 'package:todo_app/features/Setting/page/setting_view.dart';
import 'package:todo_app/features/Tasks/page/task_view.dart';
import 'package:todo_app/features/Tasks/page/update_task.dart';
import 'package:todo_app/features/layout_view.dart';
import 'package:todo_app/features/setting_provider.dart';
import 'package:todo_app/features/splash/page/splash_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'features/translation/codegen_loader.g.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:bot_toast/bot_toast.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await EasyLocalization.ensureInitialized();
  runApp(
      EasyLocalization(
        supportedLocales: [Locale("en"),Locale("ar")],
        path: 'assets/translations',
        fallbackLocale: Locale("en"),
        assetLoader: CodegenLoader(),
        child: ChangeNotifierProvider(
    create:(context) => SettingProvider(),
        child: const todoapp()),
      ),
  );
  LoadingService();

}


class todoapp extends StatelessWidget {
  const todoapp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var vm =Provider.of<SettingProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemeManager.lightTheme,
      darkTheme: AppThemeManager.darkTheme,
      themeMode: vm.current_theme,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      initialRoute: SplashView.route_name,
      routes: {
        SplashView.route_name :(context) => const SplashView(),
        LayoutView.route_name:(context) =>  LayoutView(),
        TaskView.route_name:(context) => const TaskView(),
        SettingView.route_name:(context) => const SettingView(),
        LoginView.route_name:(context) => LoginView(),
        RegisterView.route_name:(context) => RegisterView(),
        UpdateTaskWidget.route_name:(context) => UpdateTaskWidget(),

      },
      navigatorObservers: [BotToastNavigatorObserver()],
      builder: EasyLoading.init(
        builder: BotToastInit(),
      ),


    );
  }
}