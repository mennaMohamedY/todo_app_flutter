
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firebaseutils/firebase_utils.dart';
import 'package:todo_app/providers/user_provider.dart';
import 'package:todo_app/theming/mytheme.dart';
import 'package:todo_app/providers/app_config_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'model/task_dataclass.dart';

class EditTodoScreen extends StatefulWidget {

  static String routeName="EditTodoScreen";
  TextEditingController taskDescriptionController =TextEditingController();

  @override
  State<EditTodoScreen> createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  var chosenDate = DateTime.now();
  var formKey=GlobalKey<FormState>();
  var title="";
  var description="";
  late var selectedTime;
  late Task task;
  TextEditingController taskDescriptionController =TextEditingController();
  TextEditingController taskTitleController=TextEditingController();



  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<AppConfigProvider>(context);
    var localization=AppLocalizations.of(context);
    task= ModalRoute.of(context)?.settings.arguments as Task;
    //chosenDate =task.taskTime;
    print("chosenDate= ${chosenDate}");
    print("chosenDate= ${DateTime}");

    if(chosenDate.year == DateTime.now().year && chosenDate.month  == DateTime.now().month && chosenDate.day == DateTime.now().day){
      chosenDate =task.taskTime;
    }
    taskDescriptionController.text=task.taskDescription;
    taskTitleController.text=task.taskTitle;


    return Container(
      color: (provider.appMode==ThemeMode.dark)? MyTheme.colorPrimaryDark:MyTheme.colorOnPrimary,
      child: Stack(children: [
        Scaffold(appBar: AppBar(title: Text(localization!.appBarTitle) ,toolbarHeight: MediaQuery.of(context).size.height*0.17),backgroundColor: Colors.transparent,),
       Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*.15,horizontal: MediaQuery.of(context).size.height*.02),color: (provider.appMode==ThemeMode.dark)? MyTheme.colorOnPrimaryDark:Colors.white,
       child: Container(
         padding: EdgeInsets.all(22),
         child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
           Center(child: Text(localization.editTask,style: Theme.of(context).textTheme.bodyLarge?.copyWith(
               color: (provider.appMode==ThemeMode.dark)? Colors.white: Colors.black
           ),textAlign: TextAlign.center,)),
           SizedBox(height: MediaQuery.of(context).size.height*0.05,),
           Expanded(
             child: SingleChildScrollView(child: Form(key: formKey ,child: Column(children: [
               TextFormField(validator:(text){
                 if(text==null || text.isEmpty){
                   return localization.titleStateError;
                 }
                 return null;
               },initialValue: task.taskTitle,onChanged: (text){
                 title=text;
               },decoration: InputDecoration(hintText: task.taskTitle,hintStyle: TextStyle(color: (provider.appMode==ThemeMode.dark)? Colors.white:Colors.black45,fontSize: 22,fontWeight: FontWeight.bold)),),
               SizedBox(height: MediaQuery.of(context).size.height*0.03,),
               TextFormField(validator: (text){

                 if(text==null || text.isEmpty){
                   return localization.descriptionStateError;
                 }
                 return null;
               }, initialValue: task.taskDescription ,onChanged: (text){
                 description= text;
               },decoration: InputDecoration(hintStyle: TextStyle(color: (provider.appMode==ThemeMode.dark)? Colors.white:Colors.black45,fontSize: 22,fontWeight: FontWeight.bold)),),
               SizedBox(height: MediaQuery.of(context).size.height*0.05,),
               Text(localization.selectTime,style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                   color: (provider.appMode==ThemeMode.dark)? Colors.white: Colors.black
               )),
               SizedBox(height: MediaQuery.of(context).size.height*0.03,),
               Center(child: InkWell(onTap:ShowDate,child: Text(DateFormat("yyyy-MM-dd").format(chosenDate)
                 ,style: TextStyle(color: (provider.appMode==ThemeMode.dark)? MyTheme.colorPurble:Colors.black45,fontSize: 22,fontWeight: FontWeight.bold),),),),
               SizedBox(height: MediaQuery.of(context).size.height*0.09,),
               Center(child: ElevatedButton(onPressed: (){
                 CheckValidation();
               }, child: Text(localization.saveChanges),style:ButtonStyle(padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.099)),shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)))) ),)
             ],)),),
           )



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
    //provider.ChangeSelectedDate(chosenDate);
    setState(() {

    });
  }
  void CheckValidation(){
    var provider=Provider.of<AppConfigProvider>(context,listen: false);
    var usersprovider=Provider.of<UserProvider>(context,listen: false);

    var localization=AppLocalizations.of(context);


    if(formKey.currentState?.validate() == true){

      var TaskConvertedToJson = Task(taskDescription: (description.isEmpty)?taskDescriptionController.text:description,
          taskTitle: (title.isEmpty)? taskTitleController.text:title,
          taskTime: chosenDate,id: task.id,isDone:task.isDone ).ConvertToJson();
      FirebaseFireStoreUtils.EditTask(task.id, TaskConvertedToJson,usersprovider.currentUser?.id??'');
      // var theTask = Task(taskDescription: (description.isEmpty)?taskDescriptionController.text:description, taskTitle: (title.isEmpty)? taskTitleController.text:title, taskTime: chosenDate,id: task.id);
      // FirebaseFireStoreUtils.DeleteTask(theTask);
      // FirebaseFireStoreUtils.addTask(theTask);
      print(provider.tasksList.length);

      //updateList
      //print(chosenDate);
      // if(chosenDate.year != task.taskTime.year || chosenDate.month  != DateTime.now().month || chosenDate.day != DateTime.now().day){
      //   provider.ChangeSelectedDate(chosenDate);
      //  // var theTask = Task(taskDescription: (description.isEmpty)?taskDescriptionController.text:description, taskTitle: (title.isEmpty)? taskTitleController.text:title, taskTime: chosenDate,id: task.id);
      //   //FirebaseFireStoreUtils.DeleteTask(theTask);
      //   //provider.ChangeTasksList();
      //   showSnackBar(localization!.taskTimeEdited);
      //   Navigator.pop(context);
      //   print(provider.tasksList.length);
      //   return;
      // }
      provider.ChangeTasksList(usersprovider.currentUser?.id??'');
      showSnackBar(localization!.taskEdited);
      Navigator.pop(context);


    }


    // if(chosenDate.day != task.taskTime.day){
    //   provider.ChangeSelectedDate(chosenDate);
    //   return;
    // }
    // provider.ChangeTasksList();


    // setState(() {
    //
    // });
  }

//localization!.taskEdited
  void showSnackBar(String snackBarMsg) {
    var provider=Provider.of<AppConfigProvider>(context,listen: false);
    SnackBar snackBar=SnackBar(content: Text(snackBarMsg),
      dismissDirection: DismissDirection.down,
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.only(bottom: 16, right:12,left: 12 ),
    backgroundColor: (provider.appMode==ThemeMode.dark)? MyTheme.colorPurble:MyTheme.colorPrimary,);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
