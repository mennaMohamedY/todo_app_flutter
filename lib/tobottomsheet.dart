
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/app_config_provider.dart';

import 'mytheme.dart';

class todoBottomSheet extends StatefulWidget {


  @override
  State<todoBottomSheet> createState() => _todoBottomSheetState();
}

class _todoBottomSheetState extends State<todoBottomSheet> {
  var currentdate=DateTime.now();

  @override
  Widget build(BuildContext context) {
    var localization=AppLocalizations.of(context);
    var theming=Theme.of(context);
    var provider=Provider.of<AppConfigProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 22,horizontal: 42),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
        Text(localization!.addTask,style: theming.textTheme.bodyLarge?.copyWith(
          color: (provider.appMode==ThemeMode.dark)? MyTheme.colorPurble:Colors.black
        ),textAlign: TextAlign.center,),
        SizedBox(height: 22,),
        Form(child: TextFormField(decoration: InputDecoration(hintText: localization.enterTask,hintStyle: TextStyle(color: (provider.appMode==ThemeMode.dark)? Colors.white:Colors.black12)),)),
        SizedBox(height: 38,),
        Text(localization.selectTime,style: theming.textTheme.bodyLarge?.copyWith(
          fontSize: 21,
            color: (provider.appMode==ThemeMode.dark)? Colors.white:Colors.black
        )),
        SizedBox(height: 16,),
        InkWell(onTap : OnDateCLickListener,child: Text("${DateFormat('yyyy-MM-dd').format(currentdate)}",style: theming.textTheme.bodySmall?.copyWith(
          color: (provider.appMode==ThemeMode.dark)? MyTheme.colorPurble:Colors.black12
        ), textAlign: TextAlign.center,)),
        SizedBox(height: 16,),
        ElevatedButton(onPressed: (){}, child: Text(localization.addTaskBtn))
      ],),
    );
  }

  void OnDateCLickListener()async{
    var provider=Provider.of<AppConfigProvider>(context,listen: false);
    currentdate=(await showDatePicker(context: context,initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now().add(Duration(days: 365)), 
    builder: (context,child){
      return Theme(data: Theme.of(context).copyWith(
        colorScheme: ColorScheme.light(
          primary: (provider.appMode==ThemeMode.dark)? MyTheme.colorOnPrimaryDark:MyTheme.colorPrimary, // <-- SEE HERE
          onPrimary: Colors.white, // <-- SEE HERE
          onSurface: Colors.black, // <-- SEE HERE
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: (provider.appMode==ThemeMode.dark)? MyTheme.colorPurble:MyTheme.colorPrimary, // button text color
          ),
        ),
      ), child: child!);
    }))!;
    setState(() {

    });

  }
}
