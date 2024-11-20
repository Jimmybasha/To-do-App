class Validation{

  static String? fullNameValidator(String? value,String msg){
    if(value==null||value.isEmpty){
      return msg;
    }
    return null;
  }




  static String? EmailAddressValidator(String? value){
      String? res = fullNameValidator(value,"Enter your email Address");
      if(res==null){
      return isEmailValid(value!);
      }
      return res;
  }

  static String? isEmailValid(String email){

    final bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);

    if(emailValid){
      return null;
    }
    return "Email Should End with @.com";
  }


}