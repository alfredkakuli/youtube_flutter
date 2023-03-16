import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Gender { male, female }

enum ScreenSize { sm, md, lg, xl, xxl }

const sm = 576.0;
const md = 768.0;
const lg = 992.0;
const xl = 1200.0;
const xxl = 1400.0;

class SharedProperties extends StatelessWidget {
  static const phone_numbers = ['AE', 'SA', 'KE'];
  static const baseUrl = 'https://lidta.com/lidta_laravel_back_office/public/api/v1/';

  static var accessToken;
  static var expiryTime;
  static var userEmail;
  static var userImageUrl;
  static var currencySymbol = "AED";

  static getAccessToken() async {
    final userinfo = await SharedPreferences.getInstance();
    final String? logedInUser = userinfo.getString('user');
    if (logedInUser != null) {
      final tokenString = json.decode(logedInUser);
      accessToken = tokenString['access_token'];
      expiryTime = tokenString['expires_in'];
      expiryTime = tokenString['expires_in'];
      userEmail = tokenString['email'];
      userImageUrl = tokenString['users_image_url'];
      return accessToken;
    }
  }

  static getExpiryTime() async {
    final userinfo = await SharedPreferences.getInstance();
    final String? logedInUser = userinfo.getString('user');
    if (logedInUser != null) {
      final tokenString = json.decode(logedInUser);
      final _accessToken = tokenString['access_token'];
      final _expiryTime = tokenString['expires_in'];
      final _userEmail = tokenString['email'];
      accessToken = _accessToken;
      expiryTime = _expiryTime;
      userEmail = _userEmail;
      return expiryTime;
    }
  }

  static final validEmail = ValidationBuilder().email('Please Provide a Valid Email').minLength(5).maxLength(60, 'at most 60 chars').build();
  static final validPassword = ValidationBuilder().required('Password is Required').minLength(6, 'at least 6 chars').maxLength(100, 'at most 100 chars').build();
  static final validPhoneNumber = ValidationBuilder().required('Required').maxLength(9, 'Invalid Phone Number').build();
  static final generalName = ValidationBuilder().required().build();
  static final validVerifyToken = ValidationBuilder().required('Token Number is Required').minLength(6, 'at least 6 chars').maxLength(100, 'at most 100 chars').build();
  static final validUserName = ValidationBuilder().required('A Valid Username').minLength(3, 'min 3 Chars').build();
  static final validDate = ValidationBuilder().required('D.O.B Required').build();
  static final requiredFiledValidation = ValidationBuilder().required('Required').build();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
