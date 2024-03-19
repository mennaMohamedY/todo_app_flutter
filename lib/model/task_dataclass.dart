
import 'package:todo_app/firebaseutils/constants.dart';

class Task{
  String id;
  bool isDone;
  String taskTitle;
  String taskDescription;
  DateTime taskTime;

  Task({
    this.id='',
    this.isDone=false,
    required this.taskDescription,
    required this.taskTitle,
    required this.taskTime
});


  //convert from object to Json(Map)

  Map<String,dynamic> ConvertToJson(){
    //b7wl mn objext l map
    return{
      Constants.id : id,
      Constants.isDone : isDone,
      Constants.taskTitle : taskTitle,
      Constants.taskDescription : taskDescription,
      Constants.taskTime : taskTime.millisecondsSinceEpoch
    };
  }

  //convert from json(map) to object
  Task.ConvertToObject(Map<String, dynamic> data):this(
    id: data[Constants.id] ,
    taskTitle: data[Constants.taskTitle],
    taskDescription: data[Constants.taskDescription],
    taskTime: DateTime.fromMillisecondsSinceEpoch(data[Constants.taskTime]),
    isDone: data[Constants.isDone]
  );


}