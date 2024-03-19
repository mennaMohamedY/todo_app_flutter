

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/register/register_interface.dart';

import '../../firebaseutils/firebase_utils.dart';
import '../custom_alertdialog.dart';

class LoginViewModel extends ChangeNotifier{
   late RegisterNavigator loginNavigator;
  void Login(String email,String password)async {
    //add acc to firebase
    //CustomAlertDialog.ShowLoading(context,"Loading...");
    loginNavigator.showLoading();
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      print("displayedName ${credential.user?.displayName}");
      var currentUSer = await FirebaseFireStoreUtils.getUserFromFireStore(
          credential.user!.uid);
      if (currentUSer == null) {
        return;
      }
      //userProvider.updateUser(currentUSer!);
      loginNavigator.addUserToGlobalProvider(currentUSer);

      //userProvider.ChangeUser(currentUser);
      ///hide load
      //CustomAlertDialog.HideDialog(context);
      loginNavigator.hideLoading();

      ///show success dialog
      // CustomAlertDialog.ShowCustomeDialog(context: context,
      //     content:"Successful sign in!",postitveActionTxt: "OK",
      //     positiveButtonAction: (){
      //       Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      //     });
      loginNavigator.showPositiveDialog("Successful sign in!");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');

        ///hide load
        //CustomAlertDialog.HideDialog(context);
        loginNavigator.hideLoading();

        ///show failure dialog
        // CustomAlertDialog.ShowCustomeDialog(context: context,
        //     content:"No user found for that email.!");
        loginNavigator.showNegativeDialog("No user found for that email.!");
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');

        ///hide load
        //CustomAlertDialog.HideDialog(context);
        loginNavigator.hideLoading();

        ///show failure dialog
        // CustomAlertDialog.ShowCustomeDialog(context: context,
        //     content:"Wrong password provided for that user.");
        loginNavigator.showNegativeDialog("Wrong password provided for that user.");
      } else {
        print("error ${e}");
        //CustomAlertDialog.HideDialog(context);
        loginNavigator.hideLoading();

        ///show failure dialog
        //   CustomAlertDialog.ShowCustomeDialog(context: context,
        //       content:"invalid-credential, The supplied auth credential is incorrect");
        // }
        loginNavigator.showNegativeDialog(
            "invalid-credential, The supplied auth credential is incorrect");
      }
    }
  }
}