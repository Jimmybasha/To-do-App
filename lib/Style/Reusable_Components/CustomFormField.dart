import 'package:flutter/material.dart';
typedef validationFunc = String? Function(String?)?;
class CustomFormField extends StatefulWidget {

  final String labelText;
  final TextInputType keyboard ;
  final TextEditingController controller;
  final validationFunc validator;
  bool invisiblePassword;

  CustomFormField({required this.labelText ,required this.keyboard , this.invisiblePassword=false,required this.controller,required this.validator });

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool isVisible=false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator ,
      keyboardType: widget.keyboard,
      obscureText:
      widget.invisiblePassword?
      isVisible?
          false
          :true
          :false,
      controller: widget.controller,

      style: Theme.of(context).textTheme.titleSmall,
      decoration: InputDecoration(
        suffixIcon:  widget.invisiblePassword?
        IconButton(
            onPressed: (){
              setState(() {
              isVisible=!isVisible;
              });
            },
            icon: Icon(
              isVisible?
              Icons.visibility_outlined:
              Icons.visibility_off_outlined,
              color: Theme.of(context).colorScheme.primary,
            )
        )
            :null,
          labelText: widget.labelText,
          labelStyle: Theme.of(context).textTheme.labelSmall
      ),
    );
  }
}
