
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/mytheme.dart';
import 'package:todo_app/providers/app_config_provider.dart';

class LanguageBottomSheet extends StatefulWidget {

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var localization=AppLocalizations.of(context);
    var provider=Provider.of<AppConfigProvider>(context);


    return Container(
      margin: EdgeInsets.all(18),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(onTap:(){provider.ChangeLanguage('en');}, child: Container(
            child: (provider.appLanguage=='en')? selectedLanguageStyle(localization!.english):unSelectedLanguageStyle(localization!.english),
          ),),
          SizedBox(height: 12,),
          InkWell(onTap:(){provider.ChangeLanguage('ar');}, child: Container(
            child: (provider.appLanguage=='ar')? selectedLanguageStyle(localization!.arabic):unSelectedLanguageStyle(localization!.arabic),
          ),)

        ],
      ),
    );
  }


  Widget selectedLanguageStyle(String lang){
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
  Widget unSelectedLanguageStyle(String lang){
    var provider=Provider.of<AppConfigProvider>(context);
    return Text(lang,style:Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: (provider.appMode==ThemeMode.dark)? Colors.white:Colors.black) ,);
    setState(() {

    });
  }
}
