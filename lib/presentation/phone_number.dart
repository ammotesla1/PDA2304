import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_firebase/app_router.dart';
import 'package:flutter_firebase/presentation/signIn.dart';
import 'package:pinput/pinput.dart';

class PhoneSignIn extends StatefulWidget {
  const PhoneSignIn({super.key});

  @override
  State<PhoneSignIn> createState() => _PhoneSignInState();
}

class _PhoneSignInState extends State<PhoneSignIn> {
  TextEditingController _pinCtrl = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey();

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _key,
            child: Column(
              children: [
                const Spacer(),

                const Text('Введите код из СМС:',
                  style: TextStyle(
                    fontSize: 32,
                  ),
                ),

                const SizedBox(height: 20),

                Pinput(
                   defaultPinTheme: defaultPinTheme,
                  length: 6,
                  controller: _pinCtrl,
                  showCursor: true,
                ),

                const SizedBox(height: 20),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        try{
                          PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: SignIn.verify, smsCode: _pinCtrl.text);
                          await auth.signInWithCredential(credential);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Успешно! Вы авторизовались с помощью СМС!")));
                          Navigator.pushReplacementNamed(context, test);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Неверный код!")));
                        }
                        
                      }, 
                      child: Text('Подтвердить код')
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