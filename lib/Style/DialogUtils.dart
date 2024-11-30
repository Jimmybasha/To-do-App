import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DialogUtils{

  static ShowLoading(BuildContext context){
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SizedBox(
          height: MediaQuery.of(context).size.height*0.1,
          child: const Center(
              child: CircularProgressIndicator()
          ),
        ),
      ),
    );
  }
  static showMessageDialog(
      {
    required BuildContext context,
    required String err,
    String? positiveActionTitle,
     void Function(BuildContext context)? positiveActionClick,
    String? negativeActionTitle,
    void Function(BuildContext context)? negativeActionClick,


      }
      ){
    showDialog(context: context, builder: (context)=> AlertDialog(
      content:  Text(err),
      actions: [
        if(positiveActionTitle!=null)
        TextButton(
            onPressed: (){
              positiveActionClick!(context);
            },
            child:  Text(positiveActionTitle)
        ),
        if(negativeActionTitle!=null)
        TextButton(
            onPressed: (){
              negativeActionClick!(context);
            },
            child:  Text(negativeActionTitle)
        )
      ],
     )
    );

  }
  static void showToast(String msg){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
  static void showDoneToast(String msg){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP_RIGHT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}