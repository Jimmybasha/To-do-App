import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  final String btnText;
   void Function() buttonClick;

   CustomButton({required this.btnText,required this.buttonClick});


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
          style:ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 17,horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              )
          ),
          onPressed:buttonClick,
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                btnText,
                style:Theme.of(context).textTheme.bodySmall ,
              ),
              const  Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
              ),
            ],
          )
      );
  }
}
