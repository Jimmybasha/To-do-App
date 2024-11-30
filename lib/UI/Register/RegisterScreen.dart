import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/FireBase/FireBaseAuthCodes.dart';
import 'package:todoapp/FireBase/FireStoreHandler.dart';
import 'package:todoapp/FireBase/Model/User.dart' as MyUser;
import 'package:todoapp/Style/Reusable_Components/CustomButton.dart';
import 'package:todoapp/Style/Reusable_Components/CustomFormField.dart';
import 'package:todoapp/Style/validation.dart';
import 'package:todoapp/UI/Home/Widgets/HomeScreen.dart';
import 'package:todoapp/UI/Login/LoginScreen.dart';

import '../../Style/DialogUtils.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName="RegisterScreen";



  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController fullNameController;
  late TextEditingController EmailController;
  late TextEditingController PasswordController;
  late TextEditingController PasswordConfirmationController;
  late TextEditingController AgeController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {

    // TODO: implement initState

    fullNameController=TextEditingController();
    EmailController = TextEditingController();
    PasswordController = TextEditingController();
    PasswordConfirmationController = TextEditingController();
    AgeController = TextEditingController();
    super.initState();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    fullNameController.dispose();
    EmailController.dispose();
    PasswordController.dispose();
    PasswordConfirmationController.dispose();
    AgeController.dispose();
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
          elevation: 0,
          title:const Text(
            "Create Account"
          ),
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
              ),
          centerTitle: true,
        ),
        backgroundColor: Colors.transparent,
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomFormField(
                  labelText: "Full Name",
                  controller:fullNameController,
                  keyboard: TextInputType.name,
                  validator:(value)=>Validation.fullNameValidator(value,"Enter your Full Name")
              ),
              SizedBox(
                height: height*0.02,
              ),
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
                labelText: "Age",
                keyboard: TextInputType.number,
                controller: AgeController,
                  validator:(value)=>Validation.fullNameValidator(value,"Please Enter your Age")
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
                      return "Password can't be empty";
                    }
                    if(value.length<8){
                      return "Password can't be less than 8 Characters";
                    }
                    return null;
                  },
              ),
              SizedBox(
                height: height*0.02,
              ),
              CustomFormField(
                  labelText: "Password Confirmation",
                  keyboard: TextInputType.visiblePassword,
                  invisiblePassword: true,
                  controller: PasswordConfirmationController,
                  validator:(value){
                    if(value!=PasswordController.value.text){
                      return "Password isn't matching";
                    }
                    return null;
                  },
              ),

              SizedBox(
                height: height*0.06,
              ),
               CustomButton(
                 btnText: "Create Account",
                 buttonClick:CreateAccount,
               ),
            ],
            ),
          ),
        ),
      ),
    )
      ),
    );

  }
  CreateAccount()async{

    if(formKey.currentState!.validate()){
      //Create Acc
      try{
        DialogUtils.ShowLoading(context);
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: EmailController.text,
          password: PasswordController.text
        );
        await FireStoreHandler.createUser(
            MyUser.User(
                id: userCredential.user!.uid,
                email: EmailController.text,
                age: int.parse(AgeController.text),
              fullName: fullNameController.text,

            )
         );
        Navigator.pop(context);
        DialogUtils.showMessageDialog(
            context: context,
            err: "Account Created Successfully",
            positiveActionTitle: "Ok",
            positiveActionClick: (context){
              Navigator.of(context).pushNamedAndRemoveUntil(HomeScreen.routeName,(route)=>false);
              ;
            }
        );
          }on FirebaseAuthException catch(e){
        Navigator.pop(context);
        if (e.code == FireBaseAuthCodes.weakPass) {
          DialogUtils.showMessageDialog(
              context: context,
              err: "Weak Password",
              positiveActionTitle: "Ok",
              negativeActionClick: (context){
                Navigator.pop(context);
              }
          );
        } else if (e.code == FireBaseAuthCodes.emailAlreadyInUse) {
          DialogUtils.showMessageDialog(
              context: context,
              err:  "Email Already in Use",
            positiveActionTitle: "Ok",
            positiveActionClick:(context){
                Navigator.pop(context);
              }

          );
        }
      }
    }
  }
}
