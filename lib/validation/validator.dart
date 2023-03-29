import 'package:form_validator/form_validator.dart';

class FormValidator {
  static final validEmail = ValidationBuilder().email('Provide a Valid Email').minLength(5).maxLength(60, 'at most 60 chars').build();
  static final validPassword = ValidationBuilder().required('Password is Required').minLength(6, 'At least 6 chars').maxLength(100, 'at most 100 chars').build();
  static final validPhoneNumber = ValidationBuilder().required('Required').maxLength(9, 'Provide a valid Phone Number').build();
  static final generalName = ValidationBuilder().required().build();
  static final requiredFiledValidation = ValidationBuilder().required('Required').build();
}
