

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/edittodo.dart';
import 'package:todo_app/firebaseutils/constants.dart';
import 'package:todo_app/firebaseutils/firebase_utils.dart';
import 'package:todo_app/providers/app_config_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/providers/user_provider.dart';

import 'model/task_dataclass.dart';
import 'theming/mytheme.dart';


class ToDoItem extends StatefulWidget{

  Task task;
  int index;
  ToDoItem({required this.task,required this.index});

  @override
  State<ToDoItem> createState() => _ToDoItemState();
}

class _ToDoItemState extends State<ToDoItem> {
  var notDoneYet=true;
  Color borderColor=Colors.white;
  Color verticleLineDark=MyTheme.colorPurble;
  Color verticleLineLight=MyTheme.colorPrimary;
  Color green=Color(0xff61E757);

  var Done=false;

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<AppConfigProvider>(context);
    var usersProvider=Provider.of<UserProvider>(context);

    return  Container(

      padding: EdgeInsets.all( 12),
      child: Slidable(
        // Specify a key if the Slidable is dismissible.
          key:  Key(widget.task.id),

          // The start action pane is the one at the left or the top side.
          startActionPane: ActionPane(
            // A motion is a widget used to control how the pane animates.
            motion: const ScrollMotion(),

            //A pane can dismiss the Slidable.
            dismissible: DismissiblePane(
                onDismissed: () {
              FirebaseFireStoreUtils.DeleteTask(widget.task,usersProvider.currentUser?.id ?? '');
              //provider.ChangeTasksList();
              provider.tasksList.removeAt(widget.index);
              showSnackBar();


            }),


            // All actions are defined in the children parameter.
            children:  [
              // A SlidableAction can have an icon and/or a label.
              SlidableAction(

                onPressed: (context){
                  FirebaseFireStoreUtils.DeleteTask(widget.task,usersProvider.currentUser?.id ??'');
                  provider.ChangeTasksList(usersProvider.currentUser?.id ??'');
                  showSnackBar();
                },
                backgroundColor: Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),

            ],

          ),
          endActionPane:  ActionPane(
            motion: ScrollMotion(),
            children: [
              SlidableAction(
                // An action can be bigger than the others.
                flex: 2,
                onPressed: (context){
                  Navigator.pushNamed(context, EditTodoScreen.routeName,arguments:widget.task);
                },
                backgroundColor: (provider.appMode==ThemeMode.dark)? MyTheme.colorPurble:MyTheme.colorPrimary,
                foregroundColor: Colors.white,
                icon: Icons.edit_note,
                label: 'Edit',
              ),

            ],
          ), child: Container(
        margin:EdgeInsets.only(right: 1),
          color:(provider.appMode==ThemeMode.dark)? MyTheme.colorPrimaryDark: MyTheme.colorOnPrimary,
          child: Stack(children: [

            Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(19),
                color: (provider.appMode==ThemeMode.dark)? MyTheme.colorOnPrimaryDark:Colors.white
                ,border:  Border.all(color: (provider.appMode==ThemeMode.dark)? ((widget.task.isDone)?green:Colors.white) : ((widget.task.isDone)?green:MyTheme.colorPrimary) ,width: 2) ),
              child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
                Container(margin:EdgeInsets.symmetric(horizontal: 12,vertical: 10),color: (provider.appMode==ThemeMode.dark)? ((widget.task.isDone)?green:MyTheme.colorPurble) : ((widget.task.isDone)?green:MyTheme.colorPrimary)  ,width: 5,height:MediaQuery.of(context).size.height*.12 )
                ,Expanded(
                  child: Column(mainAxisAlignment:MainAxisAlignment.spaceEvenly,crossAxisAlignment:CrossAxisAlignment.start,children: [
                    Text(widget.task.taskTitle,style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: (provider.appMode==ThemeMode.dark)?Colors.white:Colors.black,
                      fontSize: 20
                    ),),
                    Text(widget.task.taskDescription,style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: (provider.appMode==ThemeMode.dark)?Colors.white:MyTheme.colorPrimary,
                      fontSize: 18
                    ),)
                  ],),
                ),
                (widget.task.isDone == true)? TaskIsDone(): TaskNotDoneYet()

              ],),)

          ],)



      )),
    );
  }
  Widget TaskNotDoneYet(){
    var provider =Provider.of<AppConfigProvider>(context);
    return InkWell(onTap: addTask,child:Container(margin:EdgeInsets.all(12),padding:EdgeInsets.symmetric(horizontal: 15,vertical: 5),decoration: BoxDecoration( color: (provider.appMode==ThemeMode.dark)?MyTheme.colorPurble:MyTheme.colorPrimary,borderRadius: BorderRadius.circular(12)),child: Icon(Icons.check,color: Colors.white,size: 32),)
      ,);
  }


  Widget TaskIsDone(){
    return InkWell(onTap: removeTask,child: Container(margin:EdgeInsets.all(12),padding:EdgeInsets.symmetric(horizontal: 15,vertical: 5),decoration: BoxDecoration( color: Colors.white,borderRadius: BorderRadius.circular(12)),child: Text("Done!",style: TextStyle(color: Color(0xff61E757)),),));
  }

  void addTask(){
    var usersProvider=Provider.of<UserProvider>(context,listen: false);
    var newData={
      Constants.isDone:true
    };
    FirebaseFireStoreUtils.EditTask(widget.task.id,
        newData ,
        usersProvider.currentUser?.id ??'');
    widget.task.isDone=true;
    print("done is clicked }");

    setState(() {});
  }

  void removeTask(){
    var usersProvider=Provider.of<UserProvider>(context,listen: false);
    var newData={
      Constants.isDone: false
    };
    FirebaseFireStoreUtils.EditTask(widget.task.id,
        newData,
        usersProvider.currentUser?.id ??'');
    print("done is clicked }");
    widget.task.isDone=false;

    setState(() {});
  }

  void showSnackBar() {
    var provider=Provider.of<AppConfigProvider>(context,listen: false);
    var localization=AppLocalizations.of(context);
    SnackBar snackBar=SnackBar(content: Text(localization!.taskDeleted,style: TextStyle(fontSize: 20),),
      dismissDirection: DismissDirection.down,
    backgroundColor: (provider.appMode == ThemeMode.dark)? MyTheme.colorPurble:MyTheme.colorPrimary,
    behavior: SnackBarBehavior.floating, margin: EdgeInsets.only(bottom: 25, right: 12,left: 12,)
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}