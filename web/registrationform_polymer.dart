import 'package:polymer/polymer.dart';

List <Map> users = [
  {
    'username'  :   'admin',
    'mail' :        'admin@admin.com',
  },
  
  {
    'username'  :   'user',
    'mail' :        'user@user.com',
  }
];

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
  
  void validate(){
    validateUsername();
    validateMail();
    validatePassword();
    validateCpassword();
  }
  
  bool validateUsername() => !isEmpty(username, "username") && !alreadyExist(username, "username") && isCorrectLength(username, "username", 3, 10);
  bool validateMail() => !isEmpty(mail, "mail") && !alreadyExist(mail, "mail");
  bool validatePassword() => !isEmpty(password, "password") && isCorrectLength(password, "password", 6, 8);
  bool validateCpassword() => !isEmpty(cPassword, "cPassword") && isEqualPass();
  
  bool isEmpty(String field, String type){
    var error = "";
    if(field.trim().isEmpty)
      error = "This field is required";
    setError(type, error);
    return field.trim().isEmpty;
  }
  
  bool isEqualPass(){
    var error = "Password must match!";
    if(cPassword != password)
      setError("cPassword", error);
    return cPassword == password;
  }
  
  bool alreadyExist(String field, String type){
    var error = "This $type already exixt";
    for(final user in users){
      if(field.compareTo(user[type]) == 0){
          setError(type, error);
          return true;
      }
    }
    return false;
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
    }
  }
  
}