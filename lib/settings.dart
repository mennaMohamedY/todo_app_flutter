

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/languagebottomsheet.dart';
import 'package:todo_app/modebottomsheet.dart';
import 'package:todo_app/theming/mytheme.dart';
import 'package:todo_app/providers/app_config_provider.dart';

class SettingsScreen extends StatefulWidget {
  static String routeName="SettingsScreen";

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    var localization=AppLocalizations.of(context);
    var provider=Provider.of<AppConfigProvider>(context);
    var theming=Theme.of(context);
    return Container(
      color: (provider.appMode==ThemeMode.dark)? MyTheme.colorPrimaryDark:MyTheme.colorOnPrimary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 27,bottom: 12,left: 9),
            child: Text(localization!.language,style: theming.textTheme.bodyLarge?.copyWith(
              color: (provider.appMode==ThemeMode.dark)? Colors.white:Colors.black,
              fontSize: 26,
            ) ,),
          ),
          InkWell(
            onTap: OnLanguageClickListener,
            child: Container(margin :EdgeInsets.symmetric(vertical: 9,horizontal: 20),padding: EdgeInsets.symmetric(vertical: 8,horizontal: 9),decoration: BoxDecoration(
                color: (provider.appMode==ThemeMode.dark)? MyTheme.colorOnPrimaryDark:Colors.white,
                border: Border.all(color: Colors.blueAccent,width: 1,)),
              child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
                Text((provider.appLanguage=='ar')? localization.arabic:localization.english,style: theming.textTheme.bodySmall?.copyWith(
                    color: (provider.appMode==ThemeMode.dark)? MyTheme.colorPurble:MyTheme.colorPrimary
                ),),
                Icon(Icons.expand_more_rounded,color: (provider.appMode==ThemeMode.dark)? MyTheme.colorPurble:theming.primaryColor,)
              ],)),
          ),

          Container(
            margin: EdgeInsets.only(top: 27,bottom: 12,left: 9),
            child: Text(localization!.mode,style: theming.textTheme.bodyLarge?.copyWith(
              color: (provider.appMode==ThemeMode.dark)? Colors.white:Colors.black,
              fontSize: 26,
            ) ,),
          ),
          InkWell(
            onTap: OnModeClickListener,
            child: Container(margin :EdgeInsets.symmetric(vertical: 9,horizontal: 20),padding: EdgeInsets.symmetric(vertical: 8,horizontal: 9),decoration: BoxDecoration(
                color: (provider.appMode==ThemeMode.dark)? MyTheme.colorOnPrimaryDark:Colors.white,
                border: Border.all(color: (provider.appMode==ThemeMode.dark)? MyTheme.colorPurble:MyTheme.colorPrimary,width: 1,)),
                child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
                  Text((provider.appMode==ThemeMode.dark)? localization.dark:localization.light,style: theming.textTheme.bodySmall?.copyWith(
                      color: (provider.appMode==ThemeMode.dark)? MyTheme.colorPurble:MyTheme.colorPrimary
                  ),),
                  Icon(Icons.expand_more_rounded,color: (provider.appMode==ThemeMode.dark)? MyTheme.colorPurble:theming.primaryColor,)
                ],)),
          )
        ],
      ),
    );
  }

  void OnLanguageClickListener() {
    var provider=Provider.of<AppConfigProvider>(context,listen: false);
    showModalBottomSheet(context: context, builder: (context){
      return LanguageBottomSheet();
    },shape: RoundedRectangleBorder( side: BorderSide(color: (provider.appMode==ThemeMode.dark)? MyTheme.colorPurble:Colors.blueAccent,width: 2), borderRadius:BorderRadius.only(topRight: Radius.circular(12),topLeft: Radius.circular(12)) ),
      backgroundColor: (provider.appMode==ThemeMode.dark)? MyTheme.colorPrimaryDark:Colors.white,);
  }
  void OnModeClickListener() {
    var provider=Provider.of<AppConfigProvider>(context,listen: false);

    showModalBottomSheet(context: context, builder: (context){
      return ModeBottomSheet();
    },shape: RoundedRectangleBorder( side: BorderSide(color: (provider.appMode==ThemeMode.dark)? MyTheme.colorPurble:Colors.blueAccent,width: 2), borderRadius:BorderRadius.only(topRight: Radius.circular(12),topLeft: Radius.circular(12)) ),
        backgroundColor: (provider.appMode==ThemeMode.dark)? MyTheme.colorPrimaryDark:Colors.white,
    );
    setState(() {

    });
  }

}
