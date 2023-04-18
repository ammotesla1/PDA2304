import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/app_router.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _loginCtrl = TextEditingController();
  TextEditingController _passwordCtrl = TextEditingController();

  GlobalKey<FormState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _key,
            child: Column(
              children: [
                const Text('Регистрация',
                  style: TextStyle(
                    fontSize: 32,
                  ),
                ),

                const Spacer(),

                Container(
                  margin: const EdgeInsets.only(bottom: 10.0),
                  child: TextFormField(
                    controller: _loginCtrl,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Email',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: (){
                          _loginCtrl.clear();
                        },
                      )
                    ),
                  ),
                ),
                
                Container(
                  margin: const EdgeInsets.only(bottom: 10.0),
                  child: TextFormField(
                    controller: _passwordCtrl,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Пароль',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: (){
                          _passwordCtrl.clear();
                        },
                      )
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if(_key.currentState!.validate()){
                          await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _loginCtrl.text, password: _passwordCtrl.text);
                          await FirebaseFirestore.instance.collection("users")
                            .add({"email": _loginCtrl.text, "password": _passwordCtrl.text});
                          
                          Navigator.pushReplacementNamed(context, signInPage);
                        }
                      }, 
                      child: Text('Подтвердить')
                    ),

                    const SizedBox(width: 20),

                    ElevatedButton(
                      onPressed: (){
                        Navigator.pushReplacementNamed(context, signInPage);
                      }, 
                      child: Text('Назад')
                    ),
                  ],
                ),

                const Spacer(),
              ]
            ),
          ),
        )
      ),
    );
  }
}