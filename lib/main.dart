import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase/app_router.dart';
import 'package:flutter_firebase/presentation/signIn.dart';
import 'firebase_options.dart';

var link = "";

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  link = window.location.href;
  runApp(MaterialApp(home: App(),));

  WidgetsFlutterBinding.ensureInitialized();
}

class App extends StatelessWidget {
    App({super.key});
    AppRouter router = AppRouter();

  @override
  Widget build(BuildContext context) {

    if (FirebaseAuth.instance.isSignInWithEmailLink(link)) {
      try {
        // The client SDK will parse the code from the link for you.
        FirebaseAuth.instance.signInWithEmailLink(email: email, emailLink: link);
        return MaterialApp(
          onGenerateRoute: router.generateRouter,
          initialRoute: emailLinkPage,
        );
        
      } catch (error) {
        print('Error signing in with email link.');
      }
    }
    else {
    }
    return MaterialApp(
      onGenerateRoute: router.generateRouter,
      initialRoute: signUpPage,
    );
    
  }
}