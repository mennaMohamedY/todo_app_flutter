
//import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firebaseutils/firebase_utils.dart';
import 'package:todo_app/model/user_dataclass.dart';
import 'package:todo_app/providers/user_provider.dart';
import 'package:todo_app/theming/mytheme.dart';
import 'package:todo_app/providers/app_config_provider.dart';
import 'package:todo_app/register/custom_alertdialog.dart';
import 'package:todo_app/register/registerscreen.dart';
import 'package:todo_app/register/textformfield.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../homescreen.dart';

class LoginScreen extends StatefulWidget {
  static String routeName="LoginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey=GlobalKey<FormState>();
  TextEditingController emailController=TextEditingController(text: "menna@menna.com");
  TextEditingController passwordController=TextEditingController(text: "123456");
  bool hidePass=true;


  @override
  Widget build(BuildContext context) {
    var localization=AppLocalizations.of(context);


    var provider=Provider.of<AppConfigProvider>(context);
    return  Scaffold(body: Container(
        color: (provider.appMode==ThemeMode.dark)? Color(0xff2A333C): Colors.white,
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 22,),
          Image.asset((provider.appMode==ThemeMode.dark)? "assets/images/book_tree3.JPG":"assets/images/book_tree4.JPG" , height: MediaQuery.of(context).size.height*0.3,width: MediaQuery.of(context).size.height*0.3,
            fit: BoxFit.fill,),
          Text(localization!.taskOrganizer,textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w900,fontSize: 22,
              color: (provider.appMode==ThemeMode.dark)?Colors.white:Colors.black),),
          SizedBox(height: 11,),
          Text(localization!.appOverView,textAlign: TextAlign.center,style: TextStyle(fontSize: 15,
              color: (provider.appMode==ThemeMode.dark)?Colors.white:Colors.black,
              fontWeight: FontWeight.w400),),
            SizedBox(height: 12,),
            Expanded(
              child: Stack(alignment: Alignment.topCenter ,children: [
                Container(margin: EdgeInsets.only(top: 29), decoration: BoxDecoration(
                    color:(provider.appMode==ThemeMode.dark)?Colors.white:Color(0xff2A333C),
                    borderRadius:BorderRadius.only(topLeft: Radius.circular(52),topRight: Radius.circular(52)) ),
                ),
                Container(padding:EdgeInsets.all(9),decoration: BoxDecoration(
                    color:(provider.appMode==ThemeMode.dark)?Color(0xff2A333C):Colors.white
                    ,borderRadius: BorderRadius.circular(15) ),
                    child: Container( padding:EdgeInsets.all(12),decoration: BoxDecoration(
                        color:(provider.appMode==ThemeMode.dark)?Colors.white:Color(0xff2A333C),borderRadius: BorderRadius.circular(12) ),child: Text(localization!.getStarted,style: TextStyle(
                        color:(provider.appMode==ThemeMode.dark)?Color(0xff2A333C):Colors.white ,fontSize: 15),),)),
                Container(
                  margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.1,
                  left:MediaQuery.of(context).size.height*0.02 ,
                  right: MediaQuery.of(context).size.height*0.02),
                  child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [Form(
                            key:formKey ,child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CustomTextFormFieldd(txtController: emailController,labelTxt: localization!.email,
                                validator:
                                (formTxt){
                              if(formTxt!.isEmpty || formTxt==null){
                                return localization!.emailError;
                              }
                              return null;
                            }),
                            SizedBox(height: 9,),
                          Stack(alignment: AlignmentDirectional.centerEnd,
                              children: [CustomTextFormFieldd(
                                txtController: passwordController,
                                labelTxt: localization!.password,validator:
                                  (formTxt){
                                if(formTxt!.isEmpty || formTxt==null){
                                  return localization!.passwordError;
                                }
                                if(formTxt.length<6){
                                  return localization.passwordLengthError;
                                }
                                return null;
                              },obscureTxtValue: hidePass,),
                                TextButton(onPressed: (){
                                  if(hidePass){
                                    hidePass=false;
                                  }else{
                                    hidePass=true;
                                  }
                                  setState(() {

                                  });
                                }, child: Icon(Icons.remove_red_eye,
                                  color: (provider.appMode==ThemeMode.dark)?Color(0xff2A333C):MyTheme.colorPrimary,))

                              ]),
                          SizedBox(height: 12,),
                            TextButton(onPressed: (){
                              Navigator.pushReplacementNamed(context, RegisterScreen.routeName);
                            }, child:Text(localization!.createAccount,style: TextStyle(
                              color: (provider.appMode==ThemeMode.dark)?MyTheme.colorPurble:MyTheme.colorPrimary
                            ),) ),
                            SizedBox(height: 12,),
                            ElevatedButton(onPressed: (){
                              Login();
                            }, child: Text(localization!.login,style:TextStyle( // Text styles
                                color: (provider.appMode==ThemeMode.dark)?Colors.white:Colors.black,
                                fontSize: 18,fontWeight: FontWeight.bold) ,),
                              style: ElevatedButton.styleFrom( // ElevatedButton styles
                                primary: (provider.appMode==ThemeMode.dark)?Color(0xff2A333C):Colors.white,
                                padding: EdgeInsets.fromLTRB(20, 10, 20, 10), // Some padding example
                                shape: RoundedRectangleBorder( // Border
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color:(provider.appMode==ThemeMode.dark)?Color(0xff2A333C):MyTheme.colorPrimary ),
                                ),
                                textStyle: TextStyle( // Text styles
                                  color: (provider.appMode==ThemeMode.dark)?Colors.white:Colors.black,
                                  fontSize: 18,
                                  overflow: TextOverflow.ellipsis,
                                ),)
                            )

                          ],
                        ))],
                      )),
                )


              ],),
            )


        ],)
    ),);
  }

  void Login()async{
    var userProvider=Provider.of<UserProvider>(context,listen: false);

    if(formKey.currentState!.validate() == true){
      //add acc to firebase
      CustomAlertDialog.ShowLoading(context,"Loading...");
      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
        );
        print("displayedName ${credential.user?.displayName}");
        var currentUSer= await FirebaseFireStoreUtils.getUserFromFireStore(credential.user!.uid);
        if(currentUSer == null){
          return;
        }
        userProvider.updateUser(currentUSer!);

        //userProvider.ChangeUser(currentUser);
        ///hide load
        CustomAlertDialog.HideDialog(context);

        ///show success dialog
        CustomAlertDialog.ShowCustomeDialog(context: context,
            content:"Successful sign in!",postitveActionTxt: "OK",
            positiveButtonAction: (){
              Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            });

      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
          ///hide load
          CustomAlertDialog.HideDialog(context);

          ///show failure dialog
          CustomAlertDialog.ShowCustomeDialog(context: context,
              content:"No user found for that email.!");
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
          ///hide load
          CustomAlertDialog.HideDialog(context);

          ///show failure dialog
          CustomAlertDialog.ShowCustomeDialog(context: context,
              content:"Wrong password provided for that user.");

        }else{
          print("error ${e}");
          CustomAlertDialog.HideDialog(context);

          ///show failure dialog
          CustomAlertDialog.ShowCustomeDialog(context: context,
              content:"invalid-credential, The supplied auth credential is incorrect");
        }
      }
    }
  }
}
