import 'package:cloud_firestore/cloud_firestore.dart';

class Task{


  static String collectionName="Tasks";

  String? id;
  String? description;
  String? title;
  Timestamp? date;
  bool? isDone;

    Task({this.id,this.description,this.title,this.date,this.isDone=false});

    Task.fromFireStore(Map<String,dynamic>? data){

      id = data?["id"];
      description = data?["description"];
      title = data?["title"];
      date = data?["date"];
      isDone = data?["isDone"];
    }


    Map<String , dynamic> toFireStore(){
      return {

        "id":id,
        "description":description,
        "title":title,
        "date":date,
        "isDone":isDone

      };

    }

}