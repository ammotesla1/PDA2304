
import 'package:flutter/material.dart';
import 'package:pr2/main.dart';
import 'package:pr2/presentation/LogLayout.dart';
import 'package:pr2/presentation/RegLayout.dart';
import 'package:pr2/presentation/admin/adminMainLayout.dart';
import 'package:pr2/presentation/client/clientMainLayout.dart';

const registrationScreen = 'regScreen';
const loginScreen = 'logScreen';
const userScreen = 'userScreen';
const adminScreen = 'adminScreen';

class AppRouter{

  Route<dynamic>? generataRoute(RouteSettings routeSettings) {
    switch(routeSettings.name){

      case registrationScreen:
        return MaterialPageRoute(builder: (_) => Registration());

      case loginScreen:
        return MaterialPageRoute(builder: (_) => Login());

      case userScreen:
        return MaterialPageRoute(builder: (_) => Client());

      case adminScreen:
        return MaterialPageRoute(builder: (_) => Admin());
    }
  }
}