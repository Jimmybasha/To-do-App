import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/FireBase/FireStoreHandler.dart';
import 'package:todoapp/Style/DialogUtils.dart';
import 'package:todoapp/UI/Home/Widgets/HomeScreen.dart';
import 'package:todoapp/UI/Home/Widgets/tabs/Tasks%20Tab/TaskItem.dart';

class TasksTab extends StatefulWidget {
  DateTime selectedDate;
   TasksTab({required this.selectedDate});

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [

          const SizedBox(height: 20,),
          Expanded(
            child: StreamBuilder(
                stream: FireStoreHandler.getTasksListen(FirebaseAuth.instance.currentUser!.uid ,widget.selectedDate ),
                builder: (context, snapshot) {
                  if(snapshot.connectionState==ConnectionState.waiting){
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }else if(snapshot.hasError){
                    return Column(
                      children: [
                        Text(snapshot.error.toString()),
                        ElevatedButton(onPressed: (){

                        },
                            child: const Text("Try Again"))
                      ],
                    );
                  }
                  var tasksList = snapshot.data??[];
                  return ListView.separated(

                      itemBuilder: (context, index) => TaskItem(task: tasksList[index]),

                      separatorBuilder: (context, index) =>const SizedBox(height: 20),

                      itemCount: tasksList.length

                  );
                },
            ),
          ),
        ],
      ),
    );
  }
}
