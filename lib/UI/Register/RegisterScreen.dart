import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/FireBase/FireBaseAuthCodes.dart';
import 'package:todoapp/Style/Reusable_Components/CustomButton.dart';
import 'package:todoapp/Style/Reusable_Components/CustomFormField.dart';
import 'package:todoapp/Style/validation.dart';

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
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {

    // TODO: implement initState

    fullNameController=TextEditingController();
    EmailController = TextEditingController();
    PasswordController = TextEditingController();
    PasswordConfirmationController = TextEditingController();
    super.initState();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    fullNameController.dispose();
    EmailController.dispose();
    PasswordController.dispose();
    PasswordConfirmationController.dispose();
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
                  validator:(value){
                   return  Validation.fullNameValidator(value,"Enter your Full Name");
                    },
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
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: EmailController.text,
          password: PasswordController.text);
          }on FirebaseAuthException catch(e){
        if (e.code == FireBaseAuthCodes.weakPass) {
          print('The password provided is too weak.');
        } else if (e.code == FireBaseAuthCodes.emailAlreadyInUse) {
          print('The account already exists for that email.');
        }
      }catch(e){
          print(e);
      }
    }
  }
}
