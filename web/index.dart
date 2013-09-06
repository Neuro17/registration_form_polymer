import 'dart:html';
import 'registrationform_polymer.dart';

void main(){
  query("#registration_form_template").model = new RegistrationForm();
}