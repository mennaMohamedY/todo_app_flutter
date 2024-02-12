

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/app_config_provider.dart';

import 'mytheme.dart';


class ToDoItem extends StatefulWidget{
  @override
  State<ToDoItem> createState() => _ToDoItemState();
}

class _ToDoItemState extends State<ToDoItem> {
  var notDoneYet=true;

  var Done=false;

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<AppConfigProvider>(context);

    return  Container(

      padding: EdgeInsets.all( 12),
      child: Slidable(
        // Specify a key if the Slidable is dismissible.
          key: const ValueKey(0),

          // The start action pane is the one at the left or the top side.
          startActionPane: ActionPane(
            // A motion is a widget used to control how the pane animates.
            motion: const ScrollMotion(),

            // A pane can dismiss the Slidable.
            dismissible: DismissiblePane(onDismissed: () {}),

            // All actions are defined in the children parameter.
            children:  [
              // A SlidableAction can have an icon and/or a label.
              SlidableAction(

                onPressed: (context){},
                backgroundColor: Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),

            ],
          ), child: Container(
        margin:EdgeInsets.only(right: 1),
          color:(provider.appMode==ThemeMode.dark)? MyTheme.colorPrimaryDark: MyTheme.colorOnPrimary,
          child: Stack(children: [

            Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(19),
                color: (provider.appMode==ThemeMode.dark)? MyTheme.colorOnPrimaryDark:Colors.white
                ,border:  Border.all(color: Colors.white ,width: 2) ),
              child: Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
                Container(margin:EdgeInsets.symmetric(horizontal: 12,vertical: 10),color: (provider.appMode==ThemeMode.dark)?MyTheme.colorPurble:MyTheme.colorPrimary,width: 5,height:MediaQuery.of(context).size.height*.12 )
                ,Expanded(
                  child: Column(mainAxisAlignment:MainAxisAlignment.spaceEvenly,crossAxisAlignment:CrossAxisAlignment.start,children: [
                    Text("Task title",style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: (provider.appMode==ThemeMode.dark)?Colors.white:MyTheme.colorPrimary
                    ),),
                    Text("Task Details",style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: (provider.appMode==ThemeMode.dark)?Colors.white:MyTheme.colorPrimary
                    ),)
                  ],),
                ),
                Stack(children: [
                  InkWell(onTap:addTask,child:Visibility(visible: notDoneYet ,child: Container(margin:EdgeInsets.all(12),padding:EdgeInsets.symmetric(horizontal: 15,vertical: 5),decoration: BoxDecoration( color: (provider.appMode==ThemeMode.dark)?MyTheme.colorPurble:MyTheme.colorPrimary,borderRadius: BorderRadius.circular(12)),child: Icon(Icons.check,color: Colors.white,size: 32),),)),
                  InkWell(onTap:removeTask,child:Visibility(visible:Done,child: Container(margin:EdgeInsets.all(12),padding:EdgeInsets.symmetric(horizontal: 15,vertical: 5),decoration: BoxDecoration( color: Colors.white,borderRadius: BorderRadius.circular(12)),child: Text("Done!",style: TextStyle(color: Color(0xff61E757)),),)),)],),
              ],),)

          ],)



      )),
    );
  }

  void addTask(){
    if(notDoneYet){
      notDoneYet=false;
      Done=true;
    }
    setState(() {});
  }
  void removeTask(){
    if(Done){
      notDoneYet=true;
      Done=false;
    }
    setState(() {});
  }

}