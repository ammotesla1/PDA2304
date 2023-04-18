import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/app_router.dart';
import 'package:flutter_firebase/presentation/signIn.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _loginCtrl = TextEditingController();
    TextEditingController _passwordCtrl = TextEditingController();

    GlobalKey<FormState> _key = GlobalKey();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _key,
            child: Column(
              children: [
                const Text('Ваш профиль',
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
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        changeProfile(_loginCtrl.text);
                          
                        //Navigator.pushReplacementNamed(context, signInPage);
                      }, 
                      child: Text('Изменить профиль')
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

  Future<void> changeProfile(String email) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: userEmail, password: userPwd)
        .then((userCredential) {
      userCredential.user?.updateEmail(email);
    });

    await userChange(email);
  }

  Future<void> userChange(String email) async {
    final user = FirebaseFirestore.instance.collection("users");
    if (email != ""){
      return user
          .doc(userAutoId)
          .set({'email': email, 'password': userPwd})
          .then((value) => print("User updated"))
          .catchError((error) => print(error.toString()));
    }
  }
}