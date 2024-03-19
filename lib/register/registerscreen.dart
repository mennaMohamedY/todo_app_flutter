
//import 'dart:html';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firebaseutils/firebase_utils.dart';
import 'package:todo_app/homescreen.dart';
import 'package:todo_app/model/user_dataclass.dart';
import 'package:todo_app/providers/user_provider.dart';
import 'package:todo_app/register/register_interface.dart';
import 'package:todo_app/register/registerscreen_viewmodel.dart';
import 'package:todo_app/theming/mytheme.dart';
import 'package:todo_app/providers/app_config_provider.dart';
import 'package:todo_app/register/custom_alertdialog.dart';
import 'package:todo_app/register/textformfield.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterScreen extends StatefulWidget {
  static String routeName="RegisterScreen";

  @override
  State<RegisterScreen> createState() => _LoginScreenState();
}


class _LoginScreenState extends State<RegisterScreen> implements RegisterNavigator {
  var formKey=GlobalKey<FormState>();
  TextEditingController nameController=TextEditingController(text: "menna");
  TextEditingController emailController=TextEditingController(text: "menna@menna.com");
  TextEditingController passwordController=TextEditingController(text: "123456");
  TextEditingController confirmPassController=TextEditingController(text: "123456");

  bool hideConfirmPass=true;
  bool hidePass=true;
  RegisterScreenViewModel registerScreenViewModel=RegisterScreenViewModel();

  @override
  void initState() {
    registerScreenViewModel.registerNavigator=this;
  }

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
                            CustomTextFormFieldd(txtController: nameController,labelTxt: localization!.yourName,
                                validator:
                                (formTxt){
                              if(formTxt!.isEmpty || formTxt==null){
                                return localization!.yourNameError;
                              }
                              return null;
                            }),
                            SizedBox(height: 9,),
                            CustomTextFormFieldd(txtController: emailController,labelTxt: localization!.email,validator:
                                (formTxt){
                              if(formTxt!.isEmpty || formTxt==null){
                                return localization!.emailError;
                              }
                              final bool emailValid =
                              RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(formTxt);
                              if(!emailValid){
                                return localization.invalidEmail;
                              }

                              return null;
                            }),
                          SizedBox(height: 12,),
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
                            Stack(alignment: AlignmentDirectional.centerEnd,
                              children: [CustomTextFormFieldd( txtController: confirmPassController,
                                  labelTxt: localization!.confirmPassword,
                                  validator: (formTxt){
                                if(formTxt!.isEmpty || formTxt==null){
                                  return localization!.passwordError;
                                }
                                if(formTxt.toString() != passwordController.text){
                                  //print(passwordController);
                                  return localization!.confirmPasswordError;
                                }
                                return null;
                              },obscureTxtValue: hideConfirmPass),
                                TextButton(onPressed: (){
                                  if(hideConfirmPass){
                                    hideConfirmPass=false;
                                  }else{
                                    hideConfirmPass=true;
                                  }
                                  setState(() {

                                  });
                                }, child: Icon(Icons.remove_red_eye,
                                  color: (provider.appMode==ThemeMode.dark)?Color(0xff2A333C):MyTheme.colorPrimary,))
                            ]),
                            SizedBox(height: 12,),
                            ElevatedButton(onPressed: (){
                              Login();
                              //login2();
                            }, child: Text(localization!.register,style:TextStyle( // Text styles
                                color: (provider.appMode==ThemeMode.dark)?Colors.white:Colors.black,
                                fontSize: 18,fontWeight: FontWeight.bold) ,),
                              style: ElevatedButton.styleFrom( // ElevatedButton styles
                                backgroundColor: (provider.appMode==ThemeMode.dark)?Color(0xff2A333C):Colors.white,
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
    if(formKey.currentState!.validate() == true){
      registerScreenViewModel.Login(emailController.text, passwordController.text, nameController.text);
    }
  }

  @override
  void addUserToGlobalProvider(Users user) {
    var userProvider=Provider.of<UserProvider>(context,listen: false);
    userProvider.updateUser(user);
  }

  @override
  void hideLoading() {
    CustomAlertDialog.HideDialog(context);

  }

  @override
  void showPositiveDialog(String msg) {
    ///show success dialog
    CustomAlertDialog.ShowCustomeDialog(context: context,
        content:msg,postitveActionTxt: "OK",
        positiveButtonAction: (){
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        });
  }

  @override
  void showLoading() {
    CustomAlertDialog.ShowLoading(context, 'Loading....');
  }

  @override
  void showNegativeDialog(String msg) {
    CustomAlertDialog.ShowCustomeDialog(context: context,
        content:msg,negativeActionTxt: "OK",
    );
  }


}
