
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/app_config_provider.dart';
import 'package:todo_app/register/textformfield.dart';
typedef validateFun=String? Function(String?)?;


class CustomTextFormFieldd extends StatelessWidget {
  String labelTxt;
 // String errorTxt;
  validateFun validator;
  bool obscureTxtValue=false;
  TextEditingController txtController;

  CustomTextFormFieldd({required this.labelTxt,required this.validator,required this.txtController,this.obscureTxtValue=false});

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<AppConfigProvider>(context);
    return TextFormField(
      validator: validator,
      decoration: InputDecoration(
        labelText: labelTxt,
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)
          ,borderSide:BorderSide(width: 2,
              color:(provider.appMode==ThemeMode.dark)?Color(0xff2A333C):Colors.white  ) ,),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)
            ,borderSide:BorderSide(width: 2,
                color:(provider.appMode==ThemeMode.dark)?Color(0xff2A333C):Colors.white  ) ),
        labelStyle: TextStyle(color:
        (provider.appMode==ThemeMode.dark)?Color(0xff2A333C):Colors.white ,fontSize: 15 ),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)
            ,borderSide:BorderSide(width: 2,color:Colors.red ) ),
        errorStyle: TextStyle(color: Colors.red),
      focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)
          ,borderSide:BorderSide(width: 2,color:Colors.red ) ),
    ),
      style: TextStyle(color: (provider.appMode==ThemeMode.dark)?Color(0xff2A333C):Colors.white ),
     controller: txtController,
      obscureText:obscureTxtValue ,

    );
  }
}
