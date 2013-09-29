import 'package:polymer/polymer.dart';
import 'dart:html';
import 'dart:json' as JSON;

@CustomTag("my-registration-form")
class RegistrationForm extends PolymerElement with ObservableMixin {
  
  @observable
  String  username = "",
          userError = "",
          mail = "",
          mailError = "",
          password = "",
          passError = "",
          cPassword = "",
          cPassError= "";  
  
  @observable String checkUsername = 'http://localhost:8082/checkUsername';
  @observable String checkMail = 'http://localhost:8082/checkMail';
  @observable bool test = false;
  
  void validate(){
    if(validateUsername() && validateMail() && validatePassword() && validateCpassword())
      window.alert("Your account is ready!");
  }
  
  bool validateUsername() => !isEmpty(username, "username") && isCorrectLength(username, "username", 3, 10) && !alreadyExist(username, "username", checkUsername);
  bool validateMail() => !isEmpty(mail, "mail") && isEmail() && !alreadyExist(mail, "mail", checkMail);
  bool validatePassword() => !isEmpty(password, "password") && isCorrectLength(password, "password", 6, 8);
  bool validateCpassword() => !isEmpty(cPassword, "cPassword") && isEqualPass();
  
  bool isEmpty(String field, String type){
    var error = "";
    if(field.trim().isEmpty)
      error = "This field is required";
    setError(type, error);
    return field.trim().isEmpty;
  }
  
  bool isEmail() {
    var error = "Insert a valid email address";
    RegExp exp = new RegExp(r'\b[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}\b');
    if(!exp.hasMatch(mail))
      setError("mail", error);
    return exp.hasMatch(mail);
  }
  
  bool isEqualPass(){
    var error = "Password must match!";
    if(cPassword != password)
      setError("cPassword", error);
    return cPassword == password;
  }
  
  bool alreadyExist(String field, String type, String action){
    var error = "";
      HttpRequest.request(action,
          method: "post",
          sendData: JSON.stringify({type: field}))
        .then((HttpRequest req) {
          error = req.responseText;
          setError(type, error);
        })
        .catchError((e) => print(e));
      return !error.trim().isEmpty;
  }
  
  bool isCorrectLength(String field, String type, int min, int max){
    var error = "$type must be between $min and $max";
    if(field.trim().length < min || field.trim().length > max)
      setError(type, error);
    return !(field.trim().length < min) && !(field.trim().length > max);
  }
  
  void setError(String type, String error){
    switch(type){
      case 'username':
        userError = error;
        break;
      case 'mail':
        mailError = error;
        break;
      case 'password':
        passError = error;
        break;
      case 'cPassword':
        cPassError = error;
        break;
    }
  }
  
}