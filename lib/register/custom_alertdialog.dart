
import 'package:flutter/material.dart';

class CustomAlertDialog{
  static void ShowLoading(BuildContext context,String txt){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        content: Row(children: [
          CircularProgressIndicator(),
          SizedBox(width: 9,),
          Text(txt),

        ],),);
    });
  }

  static void HideDialog(BuildContext context){
    Navigator.pop(context);
  }

  static void ShowCustomeDialog({required BuildContext context, String title= "",
    required String content,
    String? postitveActionTxt ,
    Function? positiveButtonAction,
    String? negativeActionTxt ,
    Function? negativeButtonAction,


  }){
    List<Widget> actionsList=[];
    if(postitveActionTxt != null){
      actionsList.add(TextButton(onPressed: (){
        Navigator.pop(context);
        //positiveButtonAction;
        if(positiveButtonAction!= null){
          positiveButtonAction.call();
        }
      }, child: Text(postitveActionTxt)));
    }
    if(negativeActionTxt != null){
      actionsList.add(TextButton(onPressed: (){
        Navigator.pop(context);
        if(negativeButtonAction != null){
          negativeButtonAction.call();
        }
      }, child: Text(negativeActionTxt)));
    }
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions:actionsList,
      );
    }
    );
  }
}