// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> ar = {
  "login": "تسجيل الدخول",
  "welcomeBack": "مرحبًا بعودتك",
  "email": "بريد إلكتروني",
  "EnterYourEmailAddress": "أدخل عنوان بريدك الالكتروني",
  "password": "كلمة المرور",
  "EnterYourPassword": "ادخل كلمة المرور",
  "OR": "أو",
  "createNewAccount": "انشاء حساب جديد !..",
  "CreateAccount": "إنشاء حساب",
  "FullName": "الاسم الكامل",
  "EnterYourFullName": "ادخل اسمك كامل",
  "ConfirmPassword": "تأكيد كلمة المرور",
  "EnterYouConfirmPassword": "اعد ادخال كلمة السر",
  "invalidEmail": "عنوان البريد الإلكتروني غير صالح",
  "invalidPassword": "يجب عليك إدخال كلمة المرور الخاصة بك!",
  "passwordNotMatched": "كلمة المرور غير متطابقة",
  "invalidName": "يجب عليك إدخال اسمك",
  "ToDoList": "عمل قائمة",
  "Settings": "إعدادات",
  "Language": "لغة",
  "Theme": "النمط"
};
static const Map<String,dynamic> en = {
  "login": "login",
  "welcomeBack": "welcome back",
  "email": "E-mail",
  "EnterYourEmailAddress": "Enter your e-mail address",
  "password": "password",
  "EnterYourPassword": "Enter Your Password",
  "OR": "OR",
  "createNewAccount": "create new account !..",
  "CreateAccount": "Create Account",
  "FullName": "Full Name",
  "EnterYourFullName": "Enter Your Full Name",
  "ConfirmPassword": "Confirm Password",
  "EnterYouConfirmPassword": "Enter you confirm password",
  "invalidEmail": "Invalid e-mail address",
  "invalidPassword": "You must enter your password !",
  "invalidName": "You must enter your name",
  "passwordNotMatched": "Password not matched",
  "ToDoList": "To Do List",
  "Settings": "Settings",
  "Language": "Language",
  "Theme": "Theme"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ar": ar, "en": en};
}
