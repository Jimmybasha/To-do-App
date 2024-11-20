import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/FireBase/FireBaseAuthCodes.dart';
import 'package:todoapp/Style/AppColors.dart';
import 'package:todoapp/UI/Register/RegisterScreen.dart';

import '../../Style/Reusable_Components/CustomButton.dart';
import '../../Style/Reusable_Components/CustomFormField.dart';
import '../../Style/validation.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName="loginScreen";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}



class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController EmailController;
  late TextEditingController PasswordController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    EmailController = TextEditingController();
    PasswordController = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    EmailController.dispose();
    PasswordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage("assets/images/back.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:Colors.transparent ,
          title:const Text(
              "Login"
          ),
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.transparent,
        body:  Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomFormField(
                  labelText: "Email Address",
                  keyboard: TextInputType.emailAddress,
                  controller: EmailController,
                  validator:Validation.EmailAddressValidator,
                ),
                SizedBox(
                  height: height*0.02,
                ),
                CustomFormField(
                  labelText: "Password",
                  keyboard: TextInputType.visiblePassword,
                  invisiblePassword: true,
                  controller: PasswordController,
                  validator: (value){
                    if(value==null||value.isEmpty){
                      return "Invalid Password ";
                    }
                    return null;
                  },
                ),

                SizedBox(
                  height: height*0.06,
                ),
                CustomButton(
                  btnText: "Login",
                  buttonClick:LoginFunction,
                ),
                SizedBox(
                  height: height*0.02,
                ),
                TextButton(
                    onPressed: (){
                      Navigator.of(context).pushNamed(RegisterScreen.routeName);
                    },
                    child: const Text("Don't Have Account? , Create New One ")
                )
              ],
            ),
          ),
        ),
      ),
    )

    ),
    );
  }
  LoginFunction()async{
    if(formKey.currentState!.validate()){
      //Login account
      try{
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: SizedBox(
                    height: MediaQuery.of(context).size.height*0.1,
                child: const Center(
                    child: CircularProgressIndicator()
                ),
              ),
            ),
        );
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: EmailController.text,
            password: PasswordController.text
        );
        Navigator.pop(context);
      }on FirebaseAuthException catch(e){
        Navigator.pop(context);
        if(e.code==FireBaseAuthCodes.userNotFound){
          showDialog(
              context: context,
              builder: (context)=>AlertDialog(
                content:Text(FireBaseAuthCodes.userNotFound),
                actions: [
                  TextButton(onPressed: (){
                    Navigator.pop(context);
                    },
                      child: const Text("Ok")
                  )
                ],
              )
          );
        }else if(e.code==FireBaseAuthCodes.wrongPassword){
          showDialog(
              context: context,
              builder: (context)=>AlertDialog(
                content:const Text(FireBaseAuthCodes.wrongPassword),
                actions: [
                  TextButton(onPressed: (){
                    Navigator.pop(context);
                  },
                      child: const Text("Ok")
                  )
                ],
              )
          );
        }
      }

    }
  }
}
