
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:todo_app/mytheme.dart';
import 'package:todo_app/providers/app_config_provider.dart';
import 'package:todo_app/todo_item.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';

class ToDosScreen extends StatefulWidget {

  static String routeName="TodosScreen";

  @override
  State<ToDosScreen> createState() => _ToDosScreenState();
}

class _ToDosScreenState extends State<ToDosScreen> {

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<AppConfigProvider>(context);
    final EasyInfiniteDateTimelineController _controller =
    EasyInfiniteDateTimelineController();

    return Container(
      color: (provider.appMode==ThemeMode.dark)? MyTheme.colorPrimaryDark:MyTheme.colorOnPrimary,
      child:
      Column(children: [
        EasyDateTimeLine(
          initialDate: DateTime.now(),
          activeColor: Colors.white,
          onDateChange: (selectedDate) {
            //`selectedDate` the new date selected.

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
        Expanded(child: ListView.builder(itemBuilder: itemsBuilder,itemCount: 20,))
      ],),

    );
  }

  ToDoItem itemsBuilder(context,int position){
    return ToDoItem();
  }
}
