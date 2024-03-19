

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/register/register_interface.dart';

import '../firebaseutils/firebase_utils.dart';
import '../model/user_dataclass.dart';
import '../providers/user_provider.dart';
import 'custom_alertdialog.dart';

class RegisterScreenViewModel extends ChangeNotifier{
  late RegisterNavigator registerNavigator;
  void Login(String email, String password,String name)async{

    //de hn3ml feha eh
    //i want to store the user in global provider so that i can use it any where
    //var userProvider=Provider.of<UserProvider>(context,listen: false);

    //add acc to firebase
    //CustomAlertDialog.ShowLoading(context,"Loading...");
    registerNavigator.showLoading;
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      var currentUser=Users(id: credential.user?.uid, email: email, username: name);
      FirebaseFireStoreUtils.addUserToFireStore(currentUser);
      //userProvider.updateUser(currentUser);
      registerNavigator.addUserToGlobalProvider(currentUser);

      ///hide load
      //CustomAlertDialog.HideDialog(context);
      registerNavigator.hideLoading;

      ///show success dialog
      // CustomAlertDialog.ShowCustomeDialog(context: context,
      //     content:"Account Created successfully!",postitveActionTxt: "OK",
      //     positiveButtonAction: (){
      //       Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      //     });
      registerNavigator.showPositiveDialog("Account Created successfully!");

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        ///show dialog
        ///        ///hide load
        //CustomAlertDialog.HideDialog(context);
        registerNavigator.hideLoading;

        ///show failure dialog
        // CustomAlertDialog.ShowCustomeDialog(context: context,
        //     content:"The password provided is too weak!");
        registerNavigator.showNegativeDialog("The password provided is too weak!");

      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        ///show dialog
        ///hide load
        //CustomAlertDialog.HideDialog(context);
        registerNavigator.hideLoading;

        ///show failure dialog
        // CustomAlertDialog.ShowCustomeDialog(context: context,
        //     content:"The account already exists for that email!");
        registerNavigator.showNegativeDialog("The account already exists for that email!");
      }
    } catch (e) {
      print(e);
      ///show error
      print(" error: ${e}");
      //CustomAlertDialog.HideDialog(context);

      ///show failure dialog
      // CustomAlertDialog.ShowCustomeDialog(context: context,
      //     content:"The account already exists for that email!");

    }
  }

}