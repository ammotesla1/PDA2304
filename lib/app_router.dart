import 'package:flutter/material.dart';
import 'package:flutter_firebase/presentation/dataPage.dart';
import 'package:flutter_firebase/presentation/email_link.dart';
import 'package:flutter_firebase/presentation/phone_number.dart';
import 'package:flutter_firebase/presentation/profile.dart';
import 'package:flutter_firebase/presentation/signIn.dart';
import 'package:flutter_firebase/presentation/signUp.dart';

const String signInPage = 'signInPage';
const String signUpPage = 'signUpPage';
const String emailLinkPage = 'emailLinkPage';
const String phoneNumber = 'phoneNumber';
const String profile = 'profile';
const String test = 'test';

class AppRouter{
  Route<dynamic>? generateRouter(RouteSettings settings){
    switch(settings.name){
      case signInPage :{
        return MaterialPageRoute(builder: (builder) => SignIn());
      }
      case signUpPage :{
        return MaterialPageRoute(builder: (builder) => SignUp());
      }
      case emailLinkPage :{
        return MaterialPageRoute(builder: (builder) => EmailLinkSignIn());
      }
      case phoneNumber :{
        return MaterialPageRoute(builder: (builder) => PhoneSignIn());
      }
      case test :{
        return MaterialPageRoute(builder: (builder) => TestStatePage());
      }
      case profile :{
        return MaterialPageRoute(builder: (builder) => Profile());
      }
    }
  }
}