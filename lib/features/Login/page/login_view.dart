import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/features/Register/page/register_view.dart';
import 'package:todo_app/features/firebase_utils.dart';
import 'package:todo_app/features/layout_view.dart';
import 'package:todo_app/features/setting_provider.dart';

import '../../../core/services/snack_bar_service.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../translation/locale_keys.g.dart';

class LoginView extends StatelessWidget {
  static const route_name = "Login";
  var formkey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var vm = Provider.of<SettingProvider>(context);
    return Container(
      decoration: BoxDecoration(
          color: (vm.current_theme == ThemeMode.light)
              ? const Color(0XFFDFECDB)
              : const Color(0xFF060E1E),
          image: const DecorationImage(
              image: AssetImage("assets/images/auth_pattern.png"),
              fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            LocaleKeys.login.tr(),
            style: theme.textTheme.titleLarge,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 120,
                  ),
                  Text(LocaleKeys.welcomeBack.tr(),
                      style: (vm.current_theme == ThemeMode.light)
                          ? theme.textTheme.bodyLarge?.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 24)
                          : theme.textTheme.bodyLarge!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(LocaleKeys.email.tr(),
                      style: (vm.current_theme == ThemeMode.light)
                          ? theme.textTheme.bodyMedium!
                              .copyWith(color: Colors.black)
                          : theme.textTheme.bodyMedium),
                  CustomTextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    hint: LocaleKeys.EnterYourEmailAddress.tr(),
                    hintColor: (vm.current_theme == ThemeMode.light)
                        ? Colors.black45
                        : Colors.white54,
                    suffixWidget: Icon(
                      Icons.email_rounded,
                      color: (vm.current_theme == ThemeMode.light)
                          ? Colors.grey.shade700
                          : theme.primaryColor,
                    ),
                    onValidate: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return LocaleKeys.EnterYourEmailAddress.tr();
                      }
                      var regex = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                      if (!regex.hasMatch(value)) {
                        return LocaleKeys.invalidEmail.tr();
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(LocaleKeys.password.tr(),
                      style: (vm.current_theme == ThemeMode.light)
                          ? theme.textTheme.bodyMedium!
                              .copyWith(color: Colors.black)
                          : theme.textTheme.bodyMedium),
                  CustomTextField(
                    controller:passwordController,
                    isPassword: true,
                    maxLines: 1,
                    hint: LocaleKeys.EnterYourPassword.tr(),
                    hintColor: (vm.current_theme == ThemeMode.light)
                        ? Colors.black45
                        : Colors.white54,
                    suffixWidget: Icon(
                      Icons.email_rounded,
                      color: (vm.current_theme == ThemeMode.light)
                          ? Colors.grey.shade700
                          : theme.primaryColor,
                    ),
                    onValidate: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return LocaleKeys.EnterYourPassword.tr();
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(

                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          FirebaseUtils()
                              .loginUserAccount(
                                  emailController.text, passwordController.text)
                              .then((value) {
                            if (value == true) {
                              EasyLoading.dismiss();
                              SnackBarService.showSuccessMesage("logged in Successfuly");
                              Navigator.pushReplacementNamed(
                                  context, LayoutView.route_name);
                            }
                          });

                          //Navigator.pushNamed(context, LayoutView.route_name);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlue.shade400,
                          padding: const EdgeInsets.symmetric(horizontal: 40)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            LocaleKeys.login.tr(),
                            style: theme.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w500, fontSize: 17),
                          ),
                          const Icon(Icons.arrow_forward_outlined,color: Colors.white,)
                        ],
                      )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        LocaleKeys.OR.tr(),
                        textAlign: TextAlign.center,
                        style: (vm.current_theme == ThemeMode.light)
                            ? theme.textTheme.bodyLarge!.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)
                            : theme.textTheme.bodyLarge,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, RegisterView.route_name);
                          },
                          child: Text(LocaleKeys.createNewAccount.tr(),
                              style: (vm.current_theme == ThemeMode.light)
                                  ? theme.textTheme.bodyLarge!.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)
                                  : theme.textTheme.bodyLarge,
                              textAlign: TextAlign.center)),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
