import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/services/snack_bar_service.dart';
import 'package:todo_app/features/Login/page/login_view.dart';
import 'package:todo_app/features/firebase_utils.dart';
import 'package:todo_app/features/setting_provider.dart';
import 'package:todo_app/features/translation/locale_keys.g.dart';

import '../../../core/widgets/custom_text_field.dart';

class RegisterView extends StatelessWidget {
  static const String route_name = "Register";
  var formkey=GlobalKey<FormState>();
  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var confirmPasswordController=TextEditingController();

   RegisterView({super.key});
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
            LocaleKeys.CreateAccount.tr(),
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
                  Text(LocaleKeys.FullName.tr(),
                      style: (vm.current_theme == ThemeMode.light)
                          ? theme.textTheme.bodyMedium!
                              .copyWith(color: Colors.black)
                          : theme.textTheme.bodyMedium),
                  CustomTextField(
                    controller:nameController ,
                      keyboardType: TextInputType.emailAddress,
                      hint: LocaleKeys.EnterYourFullName.tr(),
                      hintColor: (vm.current_theme == ThemeMode.light)
                          ? Colors.black45
                          : Colors.white54,
                      suffixWidget: Icon(
                        Icons.person,
                        color: (vm.current_theme == ThemeMode.light)
                            ? Colors.grey.shade700
                            : theme.primaryColor,
                      ),
                      onValidate: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return LocaleKeys.invalidName.tr();
                        }
                        return null;
                      }),
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
                    controller: passwordController,
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
                      var regex = RegExp(
                          r"(?=^.{8,}$)(?=.*[!@#$%^&*]+)(?![.\\n])(?=.*[A-Z])(?=.*[a-z]).*$");
                      if (!regex.hasMatch(value)) {
                        return "The password must include at least \n* one lowercase letter, \n* one uppercase letter, \n* one digit, \n* one special character,\n* at least 8 characters long.";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(LocaleKeys.ConfirmPassword.tr(),
                      style: (vm.current_theme == ThemeMode.light)
                          ? theme.textTheme.bodyMedium!
                              .copyWith(color: Colors.black)
                          : theme.textTheme.bodyMedium),
                  CustomTextField(
                    controller: confirmPasswordController,
                    isPassword: true,
                    maxLines: 1,
                    hint: LocaleKeys.EnterYouConfirmPassword.tr(),
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
                      if(value==null||value.trim().isEmpty) {
                        return LocaleKeys.EnterYouConfirmPassword.tr();
                      }
                      if (value != passwordController.text) {
                        return LocaleKeys.passwordNotMatched.tr();
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if(formkey.currentState!.validate()){
                          FirebaseUtils().creatAcount(emailController.text, passwordController.text).then((value){
                            if(value==true){
                              EasyLoading.dismiss();
                              SnackBarService.showSuccessMesage("Account successfully created");
                              Navigator.pushNamedAndRemoveUntil(context, LoginView.route_name, (route) => false);
                            }
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue.shade400,
                          padding: const EdgeInsets.symmetric(horizontal: 40)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            LocaleKeys.CreateAccount.tr(),
                            style: theme.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w500, fontSize: 17),
                          ),
                          const Icon(Icons.arrow_forward_outlined,color: Colors.white,)
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
