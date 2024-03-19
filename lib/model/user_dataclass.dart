
import 'package:todo_app/firebaseutils/constants.dart';

class Users{
  String? id;
  String? username;
  String? email;
  Users({required this.id, required this.email, required this.username});

  //from json to object
   Users.FromFireStore(Map<String,dynamic> data):this(id: data[Constants.id],email: data[Constants.email],username:data[Constants.userName] );



  //from object to json
 Map<String,dynamic> toFireStore(){
  return {
    Constants.id : id,
    Constants.userName : username,
    Constants.email: email

  };
}

}
