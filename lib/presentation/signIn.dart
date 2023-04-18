import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/app_router.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  static String verify="";

  @override
  State<SignIn> createState() => _SignInState();
}

var email = "";
var userAutoId = "";
var userEmail = "";
var userPwd = "";

class _SignInState extends State<SignIn> {
  TextEditingController _loginCtrl = TextEditingController();
  TextEditingController _passwordCtrl = TextEditingController();
  TextEditingController _phoneCtrl = TextEditingController();

  GlobalKey<FormState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    _phoneCtrl.text = "+7";
    if (FirebaseAuth.instance.isSignInWithEmailLink(window.location.href)) {
      try {
        FirebaseAuth.instance.signInWithEmailLink(email: email, emailLink: window.location.href);
        Navigator.pushReplacementNamed(context, emailLinkPage);
        
      } catch (error) {
        print('Error signing in with email link.');
      }
    }

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

                const Spacer(),

                Container(
                  margin: EdgeInsets.only(bottom: 10.0),
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
                  margin: EdgeInsets.only(bottom: 10.0),
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

                Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  child: TextFormField(
                    controller: _phoneCtrl,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Телефон',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: (){
                          _phoneCtrl.clear();
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
                          try{
                            await FirebaseAuth.instance.signInWithEmailAndPassword(email: _loginCtrl.text, password: _passwordCtrl.text).then((value) => {
                            });
                            final currentUser = FirebaseAuth.instance.currentUser;
                            final currentUserId = FirebaseFirestore.instance.collection("users").doc(currentUser!.uid);
                            userAutoId = currentUserId.id;
                            userEmail = currentUser.email.toString();
                            userPwd = _passwordCtrl.text;
                            Navigator.pushReplacementNamed(context, test);
                          }
                          catch(e){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                          }
                      },
                      child: Text('Войти')
                    ),

                    const SizedBox(width: 20),

                    ElevatedButton(
                      onPressed: () async {
                        if (_key.currentState!.validate()) {
                          await FirebaseAuth.instance.signInAnonymously();
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Теперь интернет анонимен")));
                          Navigator.pushReplacementNamed(context, test);
                        }
                        else{
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Интернет не анонимен")));
                        }
                      },
                      child: Text('Войти как гость')
                    ),

                    const SizedBox(width: 20),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            //isip_v.i.malahov@mpt.ru
                            //qwerty22.12.12.qq@gmail.com
                            if (_key.currentState!.validate()) {
                              var acs = ActionCodeSettings(
                                url: window.location.href,
                                handleCodeInApp: true);

                              await FirebaseAuth.instance.sendSignInLinkToEmail(email: _loginCtrl.text, actionCodeSettings: acs)
                                .catchError((onError) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Не удалось отправить код $onError"))))
                                .then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Код выслан на почту"))));
                                email = _loginCtrl.text;
                            }
                            else{

                            }
                          },
                          child: Text('Отправить Email код')
                        ),
                      ],
                    ),

                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () async {                
                          try{
                            await FirebaseAuth.instance.verifyPhoneNumber(
                              phoneNumber: _phoneCtrl.text,
                              verificationCompleted: (PhoneAuthCredential credential) {},
                              verificationFailed: (FirebaseAuthException e) {},
                              codeSent: (String verificationId, int? resendToken) {
                                SignIn.verify=verificationId;
                                Navigator.pushReplacementNamed(context, phoneNumber);
                              },
                              codeAutoRetrievalTimeout: (String verificationId) {},
                            );
                          } catch (e) {
                            print(e);
                          }
                      },
                      child: Text('Войти по коду на телефон')
                    ),

                    const SizedBox(width: 20),
                    ElevatedButton(
                        onPressed: () {
                          try{
                            Navigator.pushReplacementNamed(context, signUpPage);
                          }
                          catch(e){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                          }
                          
                        },
                        child: Text('Регистрация')
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