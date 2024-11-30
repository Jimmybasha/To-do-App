import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/UI/Home/Widgets/tabs/Tasks%20Tab/SettingsTab.dart';
import 'package:todoapp/UI/Home/Widgets/tabs/Tasks%20Tab/TasksTab.dart';
import 'package:todoapp/UI/Login/LoginScreen.dart';

import 'AddTaskBottomSheet.dart';

class HomeScreen extends StatefulWidget {
  static const routeName="home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex=0;
  bool createBtnPressed = false;
  DateTime selectedDate = DateTime.now();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      floatingActionButtonLocation:FloatingActionButtonLocation.centerDocked ,
      floatingActionButton: FloatingActionButton(
          onPressed: (){

            showModalBottomSheet(
              isScrollControlled: true,
              shape:const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15)
                )
              ) ,
                context: context,
                builder: (context)=>AddTaskBottomSheet(),
            );
          },
          child:createBtnPressed?
         const Icon(
            Icons.check,
            color:Colors.white ,
          )
            :
          const   Icon(
            Icons.add,
            color:Colors.white ,
          ),

      ),

      bottomNavigationBar:  BottomAppBar(
        notchMargin: 10,
        shape:const CircularNotchedRectangle() ,
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex:currentIndex ,
            onTap: (value){
                setState(() {
                    currentIndex=value;
                });
                },

            items:const [
               BottomNavigationBarItem(
                   label: "",
                   icon: Icon(
               Icons.list,
                size: 30,
              )

              ),  BottomNavigationBarItem(label: "",icon: Icon(
               Icons.settings,
                size: 30,
              )
              ),
        ]
        ),
      ),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            clipBehavior:Clip.none ,
            children: [

              AppBar(
                title:const Text("To Do List"),
                actions: [
                  IconButton(onPressed: (){
                    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                    FirebaseAuth.instance.signOut();
                  }, icon: const Icon(Icons.logout))
                ],

              ),
             currentIndex==0?Positioned(
               left: 0,
               right: 0,
               bottom: -33,
               child: EasyInfiniteDateTimeLine(
                 showTimelineHeader:false ,
                 dayProps:  const EasyDayProps(
                   height:79,
                   width: 58,
                   dayStructure:DayStructure.dayStrDayNum ,
                   inactiveDayStyle: DayStyle(
                     decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.all(Radius.circular(15))
                     )
                   )
                 ),

                 focusDate:selectedDate ,
                 firstDate:DateTime.now() ,
                 lastDate: DateTime.now().add(
                     const Duration(days: 365)
                 ),
                 onDateChange: (date) {
                   // Handle the selected date.
                   setState(() {
                     selectedDate=date;
                   });
                 },
               ),
             ):const Text(""),
            ],
          ),
          Expanded(child: currentIndex==0
              ?TasksTab(selectedDate: selectedDate)
              :const SettingsTab()
          ),
        ],
      ),
    );
  }
}
