import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/FireBase/FireStoreHandler.dart';
import 'package:todoapp/Style/DialogUtils.dart';
import 'package:todoapp/Style/Reusable_Components/CustomFormField.dart';
import 'package:todoapp/Style/validation.dart';
import 'package:todoapp/UI/Home/Widgets/tabs/Tasks%20Tab/EditFormField.dart';
import '../../../../../FireBase/Model/Task.dart';

class TaskItem extends StatefulWidget {


  final Task task;



   const TaskItem({required this.task});


  @override
  State<TaskItem> createState() => _TaskItemState();
}


class _TaskItemState extends State<TaskItem> {

  @override
  Widget build(BuildContext context) {



    return Slidable(

      startActionPane: ActionPane(
        extentRatio:widget.task.isDone==false?0.45:0.25 ,
          motion: const DrawerMotion(),
          children: [
            SlidableAction(

              label: "Delete",
              backgroundColor: Colors.red,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15)
              ),
              onPressed:(context) {
                   deleteTask();
            },
            ),
           ...(!widget.task.isDone!
           ?
           [
             SlidableAction(
              label: "Edit",
              backgroundColor: Colors.blueGrey,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15)
              ),

             onPressed: (context) {
               Navigator.pushNamed(context, EditFormField.routeName,arguments:widget.task);
             },

            )]
            :[]),

          ],
      ),

      child: Container(
        padding:const  EdgeInsets.all(10),
        decoration: BoxDecoration(
        color: Colors.white,
            borderRadius: BorderRadius.circular(15)
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(
                width:5,
                height:double.infinity ,
                  decoration: BoxDecoration(
                  color: widget.task.isDone==false?Theme.of(context).colorScheme.primary:CupertinoColors.activeGreen,
                  ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.task.title??"",
                          style: widget.task.isDone==false?Theme.of(context).textTheme.titleMedium:Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: CupertinoColors.activeGreen
                          ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10,),
                      Text(widget.task.description??"",style: widget.task.isDone==false?Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: 14,
                        color: Colors.black,

                      ):Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: 14,
                        color: Colors.greenAccent,

                      ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                    ],
                  ),
                ),
              ),
          const SizedBox(width: 10,),
              widget.task.isDone==false?ElevatedButton(
                  onPressed:() {
                //Assignment
                    FireStoreHandler.isDone(FirebaseAuth.instance.currentUser!.uid,widget.task.id!,true);
                    DialogUtils.showDoneToast("Congratulations on finishing ur TASK !!!!");
                  },
                  child:const Icon(
                    Icons.check
                  )
              ):const Text("Done!",style: TextStyle(
                color: CupertinoColors.activeGreen,
                fontSize: 22
              ),),


            ],
          ),
        ),
      ),
    );
  }

  deleteTask()async{

    DialogUtils.showMessageDialog(
        context: context,
        err: "Are u sure you want to Delete this task ?",
        positiveActionTitle: "Yes",
        positiveActionClick: (context)async{
          DialogUtils.ShowLoading(context);
          await FireStoreHandler.deleteTask(FirebaseAuth.instance.currentUser!.uid,widget.task.id??"");
          Navigator.pop(context);
          Navigator.pop(context);
          DialogUtils.showToast("Task Deleted Succesfully");
        },
      negativeActionTitle: "No",
      negativeActionClick: (context) {
        Navigator.pop(context);

      },

    );


  }




}
