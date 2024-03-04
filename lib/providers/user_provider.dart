import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/user_dataclass.dart';

class UserProvider extends ChangeNotifier{
  Users? currentUser;

  void updateUser(Users newUser){
    currentUser=newUser;
  }


}