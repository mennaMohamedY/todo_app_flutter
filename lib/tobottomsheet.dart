
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firebaseutils/firebase_utils.dart';
import 'package:todo_app/model/task_dataclass.dart';
import 'package:todo_app/providers/app_config_provider.dart';
import 'package:todo_app/providers/user_provider.dart';

import 'theming/mytheme.dart';

class todoBottomSheet extends StatefulWidget {


  @override
  State<todoBottomSheet> createState() => _todoBottomSheetState();
}

class _todoBottomSheetState extends State<todoBottomSheet> {
  var currentdate=DateTime.now();
  var formKey=GlobalKey<FormState>();
  var taskTitle='';
  var taskDescription='';


  @override
  Widget build(BuildContext context) {
    var localization=AppLocalizations.of(context);
    var theming=Theme.of(context);
    var provider=Provider.of<AppConfigProvider>(context);
    print("flutter12");
    return Container(
      padding: EdgeInsets.symmetric(vertical: 22,horizontal: 42),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
        Text(localization!.addTask,style: theming.textTheme.bodyLarge?.copyWith(
          color: (provider.appMode==ThemeMode.dark)? MyTheme.colorPurble:Colors.black
        ),textAlign: TextAlign.center,),
        SizedBox(height: 22,),
          Expanded(
            child: SingleChildScrollView(
              child: Form(key: formKey,child:
                  Column(children: [
                    TextFormField(onChanged: (text){
                      taskTitle=text;
                    },validator:(text){
                      if(text==null || text.isEmpty){
                        return localization.taskStateError;
                      }
                      return null;
                    },style: TextStyle(color: (provider.appMode==ThemeMode.dark)? Colors.white:Colors.black,fontSize: 19 ),decoration: InputDecoration(hintText: localization.taskDescription,hintStyle: TextStyle(color: (provider.appMode==ThemeMode.dark)? Colors.white:Colors.black12))
                      ,),
                    SizedBox(height: 12,),
                    TextFormField(maxLines: 3,onChanged: (text){
                      taskDescription=text;
                    },validator:(text){
                      if(text==null || text.isEmpty){
                        return localization.taskStateError;
                      }
                      return null;
                    },style: TextStyle(color: (provider.appMode==ThemeMode.dark)? Colors.white:Colors.black ,fontSize: 19),decoration: InputDecoration(hintText: localization.taskDescription,hintStyle: TextStyle(color: (provider.appMode==ThemeMode.dark)? Colors.white:Colors.black12))
                      ,),
                    SizedBox(height: 38,),
                    Text(localization.selectTime,style: theming.textTheme.bodyLarge?.copyWith(
                        fontSize: 21,
                        color: (provider.appMode==ThemeMode.dark)? Colors.white:Colors.black
                    )),
                    SizedBox(height: 16,),
                    InkWell(onTap : OnDateCLickListener,child: Text("${DateFormat('yyyy-MM-dd').format(currentdate)}",style: theming.textTheme.bodySmall?.copyWith(
                        color: (provider.appMode==ThemeMode.dark)? MyTheme.colorPurble:Colors.black45
                    ), textAlign: TextAlign.center,)),
                    SizedBox(height: 16,),

                  ],)
              ),
            ),
          ),
          ElevatedButton( onPressed: (){
            checkValidation();
          }, child: Text(localization.addTaskBtn))

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
            foregroundColor: (provider.appMode==ThemeMode.dark)? MyTheme.colorPurble:MyTheme.colorPrimary, // button text color
          ),
        ),
      ), child: child!);
    }))!;
    setState(() {

    });

  }

  void checkValidation(){
    var provider=Provider.of<AppConfigProvider>(context,listen: false);
    var usersprovider=Provider.of<UserProvider>(context,listen: false);

    if(formKey.currentState?.validate() == true){
      var task=Task(taskDescription: taskDescription, taskTitle: taskTitle, taskTime: currentdate);
      FirebaseFireStoreUtils.addTask(task,usersprovider.currentUser?.id ??'').timeout(Duration(milliseconds: 500),
          onTimeout: (){
        print("Task added successfully!");
          });
      provider.ChangeTasksList(usersprovider.currentUser?.id ?? '');

      Navigator.pop(context);
      showSnackBar();

    }



  }

  void showSnackBar() {
    var provider=Provider.of<AppConfigProvider>(context,listen: false);
    SnackBar snackbar=SnackBar(
        content: Text(AppLocalizations.of(context)!.taskAddedtofirestore,style: TextStyle(fontSize: 20, ),),
    backgroundColor: (provider.appMode==ThemeMode.dark)? MyTheme.colorPurble:Colors.blueAccent,dismissDirection: DismissDirection.down,
    behavior: SnackBarBehavior.floating,margin: EdgeInsets.only(
      bottom: 25,
      right: 12,left: 12,
    ),);
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }


}
