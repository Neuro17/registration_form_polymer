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
    isEmptyUsername();
    isEmptyPassword();
    isEmptyCpassword();
    isEmptyMail();
    isEqualPass();
  }
  
  bool isEmptyUsername(){
    if(username.trim().isEmpty)
      userError = "This field is required!";
    return username.trim().isEmpty;
  }
  
  bool isEmptyMail(){
    if(mail.trim().isEmpty)
      mailError = "This field is required!";
    return mail.trim().isEmpty;
  }
  
  bool isEmptyPassword(){
    if(password.trim().isEmpty)
      passError = "This field is required!";
    return password.trim().isEmpty;
  }
  
  bool isEmptyCpassword(){
    if(cPassword.trim().isEmpty)
      cPassError = "This field is required!";
    return cPassword.trim().isEmpty;
  }
  
  bool isEqualPass(){
    if(cPassword != password)
      cPassError = "Password must match";
  }
  
  bool alreadyExistMail() {
    mailError = alreadyExist(mail, "mail");
    return !mailError.trim().isEmpty;
  }
  
  bool alreadyExistUsername() {
    userError = alreadyExist(username, "username");
    return !userError.trim().isEmpty;
  }
  
  String alreadyExist(String field, String type){
    for(final user in users){
      if(field.compareTo(user[type]) == 0){
          return "This $type already exixt";           
      }
    }
    return "";
  }
  
}