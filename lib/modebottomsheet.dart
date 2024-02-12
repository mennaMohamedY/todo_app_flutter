
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/mytheme.dart';
import 'package:todo_app/providers/app_config_provider.dart';

class ModeBottomSheet extends StatefulWidget {

  @override
  State<ModeBottomSheet> createState() => _ModeBottomSheetState();
}

class _ModeBottomSheetState extends State<ModeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var localization=AppLocalizations.of(context);
    var provider=Provider.of<AppConfigProvider>(context);


    return Container(
      margin: EdgeInsets.all(18),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(onTap:(){provider.ChangeAppThemeMode(ThemeMode.light);}, child: Container(
            child: (provider.appMode==ThemeMode.light)? selectedModeStyle(localization!.light):unSelectedModeStyle(localization!.light),
          ),),
          SizedBox(height: 12,),
          InkWell(onTap:(){provider.ChangeAppThemeMode(ThemeMode.dark);}, child: Container(
            child: (provider.appMode==ThemeMode.dark)? selectedModeStyle(localization!.dark):unSelectedModeStyle(localization!.dark),
          ),)

        ],
      ),
    );
  }

  Widget selectedModeStyle(String lang){
    var provider=Provider.of<AppConfigProvider>(context);
    return Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
      Text(lang,style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: (provider.appMode==ThemeMode.dark)? MyTheme.colorPurble:MyTheme.colorPrimary
      ),),
      Icon(Icons.check,color: (provider.appMode==ThemeMode.dark)? MyTheme.colorPurble:MyTheme.colorPrimary,size: 32,)
    ],);
    setState(() {

    });
  }

  Widget unSelectedModeStyle(String lang){
    var provider=Provider.of<AppConfigProvider>(context);
    return Text(lang,style:Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: (provider.appMode==ThemeMode.dark)? Colors.white:Colors.black) ,);
    setState(() {

    });
  }
}
