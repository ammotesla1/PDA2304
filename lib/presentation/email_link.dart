import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_firebase/app_router.dart';

class EmailLinkSignIn extends StatefulWidget {
  const EmailLinkSignIn({super.key});

  @override
  State<EmailLinkSignIn> createState() => _EmailLinkSignInState();
}

class _EmailLinkSignInState extends State<EmailLinkSignIn> {
  TextEditingController _loginCtrl = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                const Text('Дорбо пожаловать!',
                  style: TextStyle(
                    fontSize: 32,
                  ),
                ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        Navigator.pushReplacementNamed(context, signInPage);
                      },
                      child: Text('Назад')
                    ),
                  ],
                ),

                const Spacer(),
              ],
            ),
          ),
        )
    );
  }
}