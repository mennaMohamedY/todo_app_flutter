
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firebaseutils/firebase_utils.dart';
import 'package:todo_app/model/task_dataclass.dart';
import 'package:todo_app/providers/user_provider.dart';
//import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:todo_app/theming/mytheme.dart';
import 'package:todo_app/providers/app_config_provider.dart';
import 'package:todo_app/todo_item.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';

class ToDosScreen extends StatefulWidget {

  static String routeName="TodosScreen";

  @override
  State<ToDosScreen> createState() => _ToDosScreenState();
}

class _ToDosScreenState extends State<ToDosScreen> {
  //List<Task> tasksList=[];


  @override
  Widget build(BuildContext context) {

    var provider=Provider.of<AppConfigProvider>(context);
    var userProvider=Provider.of<UserProvider>(context);
    var tasksList=provider.tasksList;
    var usersProvider=Provider.of<UserProvider>(context);
    if(tasksList.isEmpty){
      provider.ChangeTasksList(usersProvider.currentUser?.id??'');
    }
    final EasyInfiniteDateTimelineController _controller =
    EasyInfiniteDateTimelineController();

    return Container(
      color: (provider.appMode==ThemeMode.dark)? MyTheme.colorPrimaryDark:MyTheme.colorOnPrimary,
      child:
      Column(children: [
        EasyDateTimeLine(
          initialDate: provider.selectedDate,
          activeColor: Colors.white,
          onDateChange: (selectedDate) {
            provider.ChangeSelectedDate(selectedDate,usersProvider.currentUser?.id ?? '');

          },
          headerProps:  EasyHeaderProps(
            monthPickerType: MonthPickerType.switcher,
            selectedDateStyle: TextStyle(color: (provider.appMode==ThemeMode.dark)? Colors.white:Colors.black,fontSize: 18),
            dateFormatter: DateFormatter.fullDateDMY(),
          ),
          dayProps:  EasyDayProps(

             inactiveDayStyle: DayStyle(decoration: BoxDecoration(color: (provider.appMode==ThemeMode.dark)? MyTheme.colorOnPrimaryDark:Colors.white),dayNumStyle: TextStyle(color: (provider.appMode==ThemeMode.dark)? MyTheme.colorPurble:Colors.black,fontSize: 18),
             dayStrStyle: TextStyle(color: (provider.appMode==ThemeMode.dark)? Colors.white:Colors.black45,fontSize: 14),),
            dayStructure: DayStructure.dayStrDayNum,
            activeDayStyle: DayStyle(
              dayNumStyle: TextStyle(color: Colors.white),
              dayStrStyle: TextStyle(color: Colors.white),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff3371FF),
                    Color(0xff8426D6),
                  ],
                ),
              ),
            ),
          ),
          locale: provider.appLanguage,
        ),
        Expanded(child: ListView.builder(itemBuilder: (context,index){
          return ToDoItem(task: tasksList[index],index: index,);
        }
          ,itemCount: tasksList.length,))
      ],),

    );
  }

  // ToDoItem itemsBuilder(context,int position){
  //   return ToDoItem(task: tasksList[position]);
  // }


  //msh hysm3 lma n3ml t3delat so we need provider
  //  void getAllTasks()async{
  //   //var collectionRef= FirebaseFireStoreUtils.getCollectionRef();
  //   QuerySnapshot<Task> querySnapshot = await FirebaseFireStoreUtils.getCollectionRef().get();
  //   //var documenstList=querySnapshot.docs;
  //   //m3ana QueryDocumentSnapshot<Task> and we want to convert it to List<Task>
  //   tasksList =querySnapshot.docs.map((document) {
  //     return document.data();
  //   }).toList();
  //   setState(() {
  //
  //   });
  //
  // }
}
