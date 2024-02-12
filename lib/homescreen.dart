

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/app_config_provider.dart';
import 'package:todo_app/tobottomsheet.dart';
import 'package:todo_app/mytheme.dart';
import 'package:todo_app/settings.dart';
import 'package:todo_app/todoslist.dart';

class HomeScreen extends StatefulWidget{

  static String routeName="HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var position=0;



  @override
  Widget build(BuildContext context) {
    var localization=AppLocalizations.of(context);
    var title=AppLocalizations.of(context)!.appBarTitle;
    var provider=Provider.of<AppConfigProvider>(context);
    if(position != 0){
      title=AppLocalizations.of(context)!.settings;
    }

   return Scaffold(
     extendBody: true,
     appBar: AppBar(toolbarHeight:MediaQuery.of(context).size.height*0.17,
       title: Text(title,style: Theme.of(context).textTheme.bodyMedium,),
     ),
     bottomNavigationBar:BottomAppBar(
       shape: CircularNotchedRectangle(),
        notchMargin: 7,
       child: BottomNavigationBar(
         backgroundColor: Colors.transparent,
         elevation: 0,
         currentIndex:position,
         onTap: (index){
           position=index;
           setState(() {
           });
         },
         items: [
           BottomNavigationBarItem(icon: Icon(Icons.list),label:  localization!.list),
           BottomNavigationBarItem(icon: Icon(Icons.settings),label: localization.settings),
         ]),)
     ,
     floatingActionButton: FloatingActionButton(onPressed: (){
       OnAddTaskClickListener();
     },
         child: Icon(Icons.add,size: 30,),
       shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),side: BorderSide(color: (provider.appMode==ThemeMode.dark)? MyTheme.colorPrimaryDark:Colors.white,width: 4)) ,
       ),
     floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
   body: (position==0)? ToDosScreen(): SettingsScreen(),);
  }
  void OnAddTaskClickListener(){
    var provider=Provider.of<AppConfigProvider>(context,listen: false);
    showModalBottomSheet(context: context, builder:
    (context){
      return todoBottomSheet();
    },shape: RoundedRectangleBorder(side: BorderSide(color: (provider.appMode==ThemeMode.dark)? MyTheme.colorPurble:Colors.blueAccent,width: 2,)
        ,borderRadius: BorderRadius.only(topLeft: Radius.circular(22),topRight: Radius.circular(22)),
    ),backgroundColor: (provider.appMode==ThemeMode.dark)? MyTheme.colorPrimaryDark:Colors.white
    );
  }


}
