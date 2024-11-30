

class User{
  static const String collectionName="User";
  String? id;
  String? fullName;
  String? email;
  int? age;

  User({this.id,this.fullName,this.email,this.age});

  Map<String,dynamic> toFireStore(){
    return{
      "id":id,
      "fullName":fullName,
      "age":age,
      "email":email
    };
  }

  User.fromFireStore(Map<String,dynamic>? data){

        id= data?["id"];

        fullName= data?["fullName"];

        email= data?["email"];

        age= data?["age"];


  }

}