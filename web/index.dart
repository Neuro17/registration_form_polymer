import 'dart:html';
import 'Registrationform_polymer.dart';

void main(){
  query("#registration_form_template").model = new RegistrationForm();
}