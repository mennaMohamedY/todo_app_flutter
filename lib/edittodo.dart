
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/mytheme.dart';
import 'package:todo_app/providers/app_config_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditTodoScreen extends StatefulWidget {

  static String routeName="EditTodoScreen";

  @override
  State<EditTodoScreen> createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  var chosenDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<AppConfigProvider>(context);
    var localization=AppLocalizations.of(context);
    return Container(
      color: (provider.appMode==ThemeMode.dark)? MyTheme.colorPrimaryDark:MyTheme.colorOnPrimary,
      child: Stack(children: [
        Scaffold(appBar: AppBar(title: Text(localization!.appBarTitle) ,toolbarHeight: MediaQuery.of(context).size.height*0.17),backgroundColor: Colors.transparent,),
       Card(margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*.15,horizontal: MediaQuery.of(context).size.height*.02),color: (provider.appMode==ThemeMode.dark)? MyTheme.colorOnPrimaryDark:Colors.white,
       child: Container(
         padding: EdgeInsets.all(22),
         child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
           Center(child: Text(localization.editTask,style: Theme.of(context).textTheme.bodyLarge?.copyWith(
               color: (provider.appMode==ThemeMode.dark)? Colors.white: Colors.black
           ),textAlign: TextAlign.center,)),
           SizedBox(height: MediaQuery.of(context).size.height*0.05,),
           Form(child: TextFormField(decoration: InputDecoration(hintText: "Task Title",hintStyle: TextStyle(color: (provider.appMode==ThemeMode.dark)? Colors.white:Colors.black45,fontSize: 22,fontWeight: FontWeight.bold)),)),
           SizedBox(height: MediaQuery.of(context).size.height*0.03,),
           Form(child: TextFormField(decoration: InputDecoration(hintText: "Task Description",hintStyle: TextStyle(color: (provider.appMode==ThemeMode.dark)? Colors.white:Colors.black45,fontSize: 22,fontWeight: FontWeight.bold)),)),
           SizedBox(height: MediaQuery.of(context).size.height*0.05,),
           Text(localization.selectTime,style: Theme.of(context).textTheme.bodyLarge?.copyWith(
             color: (provider.appMode==ThemeMode.dark)? Colors.white: Colors.black
           )),
           SizedBox(height: MediaQuery.of(context).size.height*0.03,),
           Center(child: InkWell(onTap:ShowDate,child: Text("${DateFormat("yyyy-MM-dd").format(chosenDate)}",style: TextStyle(color: (provider.appMode==ThemeMode.dark)? Colors.white:Colors.black45,fontSize: 22,fontWeight: FontWeight.bold),),),),
           SizedBox(height: MediaQuery.of(context).size.height*0.09,),
           Center(child: ElevatedButton(onPressed: (){}, child: Text(localization.saveChanges),style:ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.099)),shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)))) ),)


         ],),
       ),)
      ],),
    );
  }

  void ShowDate() async{
    var provider=Provider.of<AppConfigProvider>(context,listen: false);
    chosenDate=(await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now().add(Duration(days: 365)),builder: (context,child){
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
  }
}
