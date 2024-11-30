import 'package:cloud_firestore/cloud_firestore.dart';

import 'Model/Task.dart';
import 'Model/User.dart';

class FireStoreHandler{

  static CollectionReference<User>  getUserCollection(){
    var collection = FirebaseFirestore.instance.collection(User.collectionName)
        .withConverter(
      fromFirestore: (snapshot, options) {
        return User.fromFireStore(snapshot.data()
        );
      },
      toFirestore: (user, options) {
        return user.toFireStore();
      },
    );
    return collection;
  }

  static Future<void> createUser(User user)async{
    var collection = getUserCollection();
    var docRef = collection.doc(user.id);
   await docRef.set(user);
  }

  static CollectionReference<Task>  getTasksCollection(String userId){
    //To Create a collection inside the Document of the User Collection
    var collection = getUserCollection().doc(userId)
        .collection(Task.collectionName)
        .withConverter(
      //Data to be received from fireStore we must receive it using the object key ex: object[key]
      fromFirestore: (snapshot, options) {
        return Task.fromFireStore(snapshot.data());
      },
      //To Be send it must be sent as a json object
      toFirestore: (task, options) {
        return task.toFireStore();
      },
    );
    return collection;
  }

  static Future<void> createTask(String userId,Task task)async{
    //return the Collection(Task)
    var collection = getTasksCollection(userId);
    //Created a new Document inside the Collection(Task)
    var docRef = collection.doc();
    task.id=docRef.id;
    //Inserting Data into the Task Document
    return await docRef.set(task);
  }

  static Future<List<Task>> getTasks(String userId) async {

    //1) get TasksCollection for a  specific user
    var collection = getTasksCollection(userId);
    //list all the Documents
    var querySnapshot =  await collection.get();
    //return  all the Documents
    var queryList = querySnapshot.docs;

    //Change From List of Doc into list of Tasks
    var tasksList =   queryList.map(
    (toElement)=> toElement.data()
    ).toList();

  return tasksList;


  }


  static Future<void> deleteTask(String userId,String taskId){

    var collection = getTasksCollection(userId);

    return collection.doc(taskId).delete();

  }


  static Stream<List<Task>> getTasksListen(String userId,DateTime selectedDate)async*{

    var newDateTime = selectedDate.copyWith(
      hour: 0,
      minute: 0,
      second: 0,
      microsecond: 0,
      millisecond: 0,
    );
    print(newDateTime);
    var collection = getTasksCollection(userId).where("date",isEqualTo: Timestamp.fromDate(newDateTime));
    var queryStream = collection.snapshots();
    var tasksStream = queryStream.map(
        ((convert)=>convert.docs.map(
            (doc)=>doc.data()
        ).toList()
        )
    );

    yield* tasksStream;
  }

  static Future<void> EditTasks (String userId,String taskId,Task newTaskSpecs)async{
  var collection = getTasksCollection(userId);
  var task = collection.doc(taskId);
  return await task.update({"title":newTaskSpecs.title,"description":newTaskSpecs.description,"date":newTaskSpecs.date});

  }
  static Future<void> isDone (String userId,String taskId,bool isDone)async{
    var collection = getTasksCollection(userId);
    var task = collection.doc(taskId);
    return await task.update({"isDone":isDone,});

  }

}