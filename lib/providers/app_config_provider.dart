

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/user_provider.dart';

import '../firebaseutils/firebase_utils.dart';
import '../model/task_dataclass.dart';

class AppConfigProvider extends ChangeNotifier{
  var appLanguage='en';
  var appMode=ThemeMode.light;
  List<Task> tasksList=[];
  var selectedDate=DateTime.now();

  void ChangeLanguage(String lang){
    if(appLanguage==lang){
      return;
    }
    appLanguage=lang;
    notifyListeners();
  }

  void ChangeAppThemeMode(ThemeMode appThemeMode){
    if(appMode == appThemeMode){
      return;
    }
    appMode=appThemeMode;
    notifyListeners();
  }

  void ChangeTasksList(String uid)async{
    //var collectionRef= FirebaseFireStoreUtils.getCollectionRef();
    //var usersProvider=Provider.of<UserProvider>(context);
    QuerySnapshot<Task> querySnapshot = await FirebaseFireStoreUtils.getTasksCollectionRef(uid).get();
    //m3ana QueryDocumentSnapshot<Task> and we want to convert it to List<Task>
    tasksList =querySnapshot.docs.map((document) {
      return document.data();
    }).toList();
    print("tasksLength: ${tasksList.length}");

    //arrange tasks per day
    tasksList=tasksList.where((task) {
      if(selectedDate.year == task.taskTime.year &&  selectedDate.month == task.taskTime.month && selectedDate.day == task.taskTime.day){
        return true;
      }
      else return false;
    }).toList();

    //arrange tasks by date in descending order
    tasksList.sort((task1,task2){
      return task1.taskTime.compareTo(task2.taskTime);
    });
   //tasksList= tasksList.reversed.toList();
    notifyListeners();


  }

  void ChangeSelectedDate(DateTime newSelectedDate,String uid){
    if(selectedDate==newSelectedDate){
      return;
    }
    selectedDate = newSelectedDate;
    ChangeTasksList(uid);
    //notifyListeners();
  }


}