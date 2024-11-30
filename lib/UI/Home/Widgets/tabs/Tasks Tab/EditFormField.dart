import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../FireBase/FireStoreHandler.dart';
import '../../../../../FireBase/Model/Task.dart';
import '../../../../../Style/Reusable_Components/CustomFormField.dart';
import '../../../../../Style/validation.dart';

class EditFormField extends StatefulWidget {

  static const routeName = "EditField";
  const EditFormField({super.key});

  @override
  State<EditFormField> createState() => _EditFormFieldState();
}

class _EditFormFieldState extends State<EditFormField> {


  late TextEditingController editTitleController;
  late TextEditingController editDescriptionController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();


  @override
  void initState() {
    // TODO: implement initState
    editTitleController = TextEditingController();
    editDescriptionController = TextEditingController();


    // editTitleController.text=widget.task.title!;
    // editDescriptionController.text=widget.task.description!;
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    editTitleController.dispose();
    editDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as Task;


    editTitleController.text=args.title??"";
    editDescriptionController.text=args.description??"";

    return Scaffold(
      appBar:
      AppBar(
        title:const Text("To Do List"),


      ),

      body:  Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Center(
            child: Card(

              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(

                  children: [
                    const Text("Edit task"),
                    const SizedBox(height: 15,),
                    CustomFormField(
                        labelText: "Task Title",
                        keyboard: TextInputType.text,
                        controller: editTitleController,
                        validator: (value){
                          return Validation.fullNameValidator(editTitleController.text, "Title Can't be Empty");
                        }
                    ),
                    const SizedBox(height: 15,),
                    CustomFormField(
                        labelText: "Task Description",
                        keyboard: TextInputType.text,
                        controller: editDescriptionController,
                        validator: (value){
                          return Validation.fullNameValidator(editDescriptionController.text, "Description Can't be Empty");
                        }
                    ),
                    const SizedBox(height: 15,),

                    InkWell(
                      onTap: (){
                        showTaskDate();
                      },
                      child: Text(
                          selectedDate==null
                              ?DateFormat.yMd().format(args.date!.toDate())
                              :DateFormat.yMd().format(selectedDate!)
                          ,
                          style:Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontWeight:FontWeight.w900,
                              fontSize: 14
                          )
                      ),
                    ),
                    const SizedBox(height: 15,),
                    ElevatedButton(

                        onPressed: (){

                          if(formKey.currentState!.validate()){
                            FireStoreHandler.EditTasks(
                                FirebaseAuth.instance.currentUser!.uid,
                                args.id??"",
                                Task(
                                    title: editTitleController.text,
                                    description: editDescriptionController.text,
                                    date: Timestamp.fromDate(selectedDate??args.date!.toDate())

                                ),
                            );
                            Navigator.pop(context);
                          }else{
                            return;
                          }
                        },
                        child: const Text("Edit task")
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),

    );

  }
  DateTime? selectedDate;
  showTaskDate()async{
    selectedDate = await showDatePicker(
        context: context,
        initialDate:selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(
            const Duration(
                days: 365
            )
        )
    );
    setState(() {

    });
  }
}
