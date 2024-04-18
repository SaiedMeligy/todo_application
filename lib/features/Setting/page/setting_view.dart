
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/features/setting_provider.dart';

import '../../translation/locale_keys.g.dart';


class SettingView extends StatelessWidget {
  static const String route_name="SettingView";
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> languageList = ["English", "عربي"];
    List<String> themeList = ["Light", "Dark"];
    var theme =Theme.of(context);
    var vm=Provider.of<SettingProvider>(context);
    var mediaQuery=MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: mediaQuery.width,
          height: mediaQuery.height*0.22,
          decoration: BoxDecoration(
              color:theme.primaryColor
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 50),
            child: Text(LocaleKeys.Settings.tr(),style: vm.current_theme==ThemeMode.light?theme.textTheme.titleLarge:theme.textTheme.titleLarge!.copyWith(
              color: Color(0xFF141922)
            )),
          ),

        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  LocaleKeys.Language.tr(),
                  style: vm.current_theme==ThemeMode.light?theme.textTheme.bodySmall!.copyWith(
                    color: Colors.black,
                    fontSize: 20
                  ):theme.textTheme.bodyMedium),
              const SizedBox(
                height: 10,
              ),
              CustomDropdown<String>(
                initialItem: vm.current_language == "en" ? "English" : "عربي",
                decoration: CustomDropdownDecoration(
                  listItemStyle: TextStyle(
                    color:vm.current_theme==ThemeMode.light?theme.primaryColor:theme.primaryColor,
                      fontWeight: FontWeight.w300
                  ),
                  closedBorder: Border.all(
                    color: theme.primaryColor
                  ),
                  headerStyle:TextStyle(fontWeight: FontWeight.w400,color:vm.current_theme==ThemeMode.light?theme.primaryColor:theme.primaryColor),
                  expandedFillColor:
                  vm.isDark() ? const Color(0xFF141922) : Colors.white,
                  closedFillColor:
                  vm.isDark() ? const  Color(0xFF141922) : Colors.white,
                  closedSuffixIcon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: vm.isDark() ? theme.primaryColor : theme.primaryColor,
                  ),
                  expandedSuffixIcon: Icon(
                    Icons.keyboard_arrow_up_rounded,
                    color: vm.isDark() ? Colors.white : Colors.black,
                  ),
                ),
                items: languageList,
                onChanged: (value) {
                  if (value == "English") {
                    vm.changeLanguage("en");
                    context.setLocale(const Locale("en"));
                  } else if (value == "عربي") {
                    vm.changeLanguage("ar");
                    context.setLocale(const Locale("ar"));
                  }
                },
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                  LocaleKeys.Theme.tr()
                  ,
                  style: vm.current_theme==ThemeMode.light?theme.textTheme.bodySmall!.copyWith(
                      color: Colors.black,
                    fontSize: 20
                  ):theme.textTheme.bodyMedium),
              const SizedBox(
                height: 10,
              ),
              CustomDropdown<String>(
                initialItem: vm.isDark() ? "Dark" : "Light",
                decoration: CustomDropdownDecoration(
                  listItemStyle:TextStyle(
                    color: (vm.current_theme==ThemeMode.light)?theme.primaryColor:theme.primaryColor,
                      fontWeight: FontWeight.w300,
                  ),
                  closedBorder: Border.all(
                    color: theme.primaryColor
                  ),
                  headerStyle:TextStyle(fontWeight: FontWeight.w400,color:vm.current_theme==ThemeMode.light?theme.primaryColor:theme.primaryColor),
                  expandedFillColor:
                  vm.isDark() ? const Color(0xFF141922) : Colors.white,
                  closedFillColor:
                  vm.isDark() ? const Color(0xFF141922) : Colors.white,
                  closedSuffixIcon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: vm.isDark() ? theme.primaryColor : theme.primaryColor,
                  ),
                  expandedSuffixIcon: Icon(
                    Icons.keyboard_arrow_up_rounded,
                    color: vm.isDark() ?  Colors.white : Colors.black,
                  ),
                ),
                items: themeList,
                onChanged: (value) {
                  if (value == "Light") {
                    vm.changeTheme(ThemeMode.light);
                  } else if (value == "Dark") {
                    vm.changeTheme(ThemeMode.dark);
                  }
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
