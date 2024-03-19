

import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/firebaseutils/constants.dart';
import 'package:todo_app/model/task_dataclass.dart';
import 'package:todo_app/model/user_dataclass.dart';

class FirebaseFireStoreUtils{

  // static CollectionReference<Task> getCollectionRef(){
  //   return FirebaseFirestore.instance.collection(Constants.CollectionName)
  //       .withConverter<Task>(
  //     //y3ne mn json l object
  //       fromFirestore: (snapshot, options) {
  //        return Task.ConvertToObject(snapshot.data()!);
  //       },
  //     //y3ne mn object ljson
  //       toFirestore: (task, options) {
  //        return task.ConvertToJson();
  //       },);
  // }
  // static Future<void> addTask(Task task){
  //   var collectionRef=getCollectionRef();
  //   var docRef=collectionRef.doc();
  //   task.id = docRef.id;
  //   return docRef.set(task);
  // }

  static CollectionReference<Task> getTasksCollectionRef(String userId){
    //usersCollection
    var collectionRef=usersCollectionRef();
    //currentUser doc
    var docRef=collectionRef.doc(userId);
    //make tasks collection
    var tasksCollectionRef=docRef.collection(Constants.tasksCollectionName).withConverter<Task>(
        fromFirestore: ((snapshot,_)=>Task.ConvertToObject(snapshot.data()!)),
        toFirestore: (task,_)=>task.ConvertToJson());
    return tasksCollectionRef;
  }

  static Future<void> addTask(Task task,String userId){
    var taskDocRef=getTasksCollectionRef(userId).doc();
    //store the generated id
    task.id = taskDocRef.id;
    //add task inside the tasks docRef
    return taskDocRef.set(task);
  }

  // static void DeleteTask(Task task){
  //   getCollectionRef().doc(task.id).delete();
  // }
  static void DeleteTask(Task task,String userID){
    getTasksCollectionRef(userID).doc(task.id).delete();
  }
  // static void EditTask(Task task,Map<String,dynamic> newData){
  //   getCollectionRef().doc(task.id).update(newData);
  // }
  static void EditTask(String taskID,Map<String,dynamic> newData,String userId){
    getTasksCollectionRef(userId).doc(taskID).update(newData);
  }

  static CollectionReference<Users> usersCollectionRef(){
    return FirebaseFirestore.instance.collection(Constants.usersCollectionName)
    .withConverter<Users>(
        fromFirestore: ((snapshot,options)=> Users.FromFireStore(snapshot.data()!) ),
        toFirestore: (Users,_)=>Users.toFireStore()
    );
  }
  static Future<void> addUserToFireStore(Users user){
    return usersCollectionRef().doc(user.id).set(user);
  }

  static Future<Users?> getUserFromFireStore(String userid)async{
    var userDocumentRef=await usersCollectionRef().doc(userid).get();
    return userDocumentRef.data();

  }



}