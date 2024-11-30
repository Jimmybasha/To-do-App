import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/FireBase/FireStoreHandler.dart';
import 'package:todoapp/Style/DialogUtils.dart';
import 'package:todoapp/Style/Reusable_Components/CustomFormField.dart';
import 'package:todoapp/Style/validation.dart';

import '../../../FireBase/Model/Task.dart';

class AddTaskBottomSheet extends StatefulWidget {



  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  late TextEditingController taskTitleController;
  late TextEditingController taskDescController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    taskTitleController = TextEditingController();
    taskDescController = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose

    taskTitleController.dispose();
    taskDescController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double keyboard = MediaQuery.of(context).viewInsets.bottom;
    return Padding(

      padding:  EdgeInsets.only(
        top: 22,
        left: 22,
        right: 22,
        bottom: keyboard

      ),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Add New Task",
              style:Theme.of(context).textTheme.titleSmall!.copyWith(
               fontWeight:FontWeight.w700
              ),
            ),
            SizedBox(height: height*0.05),
            CustomFormField(
                    labelText: "Enter task Title",
                    keyboard: TextInputType.text,
                    controller: taskTitleController,
                    validator: (value)=> Validation.fullNameValidator(value, "Task title can't be empty")
                ),
            SizedBox(height: height*0.05),
            CustomFormField(
                labelText: "Enter Your Task",
                keyboard: TextInputType.multiline,
                controller: taskDescController,
                maxlines: null,
                validator: (value)=> Validation.fullNameValidator(value, "Task  can't be empty")
            ),
            SizedBox(height: height*0.05),
            InkWell(
              onTap: (){
                showTaskDate();
                },
              child: Text(
                  selectedDate==null?"Date"
                      :DateFormat.yMd().format(selectedDate!)
                  ,
                   style:Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight:FontWeight.w900,
                     fontSize: 14
                   )
               ),
            ),
            SizedBox(height: height*0.05),
            ElevatedButton(
                onPressed: (){
                      addNewTask();
                },
                child:const Text("Add Task")
            )

          ],
        ),
      ),
    );
  }
  DateTime? selectedDate;

  addNewTask()async{
    
    if(formKey.currentState!.validate()||selectedDate==null){

      if(selectedDate!=null){

      }else{
        DialogUtils.showToast("Enter The Task Date");
        return;
      }
      //add new  Task
      DialogUtils.ShowLoading(context);
      await FireStoreHandler.createTask(
          FirebaseAuth.instance.currentUser!.uid.toString(),
        Task(
        id:  FirebaseAuth.instance.currentUser!.uid,
        date: Timestamp.fromDate(selectedDate!),
        description: taskDescController.text,
        title: taskTitleController.text
      )
      );
      Navigator.pop(context);
      DialogUtils.showMessageDialog(
          context: context,
          err: "Task Added Successfully",
          positiveActionTitle: "Ok",
          positiveActionClick: (context){
            Navigator.pop(context);
            Navigator.pop(context);
            },
      );
    }

  }
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
