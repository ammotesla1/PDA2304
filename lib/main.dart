import 'package:flutter/material.dart';
import 'dart:html';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

var emailAuth = "";
var emailLink = "";
Future<void> main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();

  emailLink = window.location.href;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    final TextEditingController login = TextEditingController();
    final TextEditingController password = TextEditingController();
    final TextEditingController phone = TextEditingController();
    final TextEditingController capcha = TextEditingController();

    late ConfirmationResult confirmationResult_;

    var acs = ActionCodeSettings(
    url: window.location.href,
    handleCodeInApp: true);

    if (FirebaseAuth.instance.isSignInWithEmailLink(emailLink)) {
        try {
          FirebaseAuth.instance.signInWithEmailLink(email: emailAuth, emailLink: emailLink);
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
            ),

            body: const Center(
              child: Text("Успешная авторизация"),
            )
          );
        } catch (error) {
          login.text = "Ошибка авторизации";
        }
      }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 500,
                      height: 50,
                      child: TextFormField(
                        controller: login,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), labelText: "Почта"),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 10)),
                    SizedBox(
                      width: 500,
                      height: 50,
                      child: TextFormField(
                          controller: password,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(), labelText: "Пароль")),
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 25)),
                    SizedBox(
                      width: 500,
                      height: 70,
                      child: TextFormField(
                          controller: phone,
                          // maxLength: 10,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(), 
                              labelText: "Номер",
                              prefix: Text("+7"),
                              ),
                              keyboardType: TextInputType.number,
                              ),
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 10)),
                    SizedBox(
                      width: 500,
                      height: 50,
                      child: TextFormField(
                          controller: capcha,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(), labelText: "Код подтверждения")),
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 35)),

                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 150),
                          child: SizedBox(
                            width: 250,
                            height: 50,
                            child: Material(
                              color: Color.fromRGBO(198, 72, 200, 1),
                              borderRadius: BorderRadius.circular(5),
                              child: InkWell(
                                onTap: () async {
                        
                                    if(login.text.isEmpty && phone.text.isNotEmpty){
                                      try {
                                        ConfirmationResult confirmationResult = await FirebaseAuth.instance.signInWithPhoneNumber('+7' + phone.text);
                                        confirmationResult_ = confirmationResult;
                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Введите код и нажмите кнопку "Войти"')));
                                      } catch (e) {
                                        if(e.toString().contains('invalid-phone-number')) {
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Некорректный формат номера телефона')));
                                        } else if(e.toString().contains('missing-phone-number')) {
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Номер телефона не указан')));
                                        } else if(e.toString().contains('quota-exceeded')) {
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Превышен лимит отправки СМС')));
                                        } else if(e.toString().contains('operation-not-allowed')) {
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Операция не разрешена')));
                                        } else if(e.toString().contains('app-not-authorized')) {
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Приложение не авторизовано')));
                                        } else if(e.toString().contains('invalid-credential')) {
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Некорректные учетные данные')));
                                        } else if(e.toString().contains('user-disabled')) {
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Пользователь заблокирован')));
                                        } else if(e.toString().contains('user-not-found')) {
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Пользователь с таким номером не найден')));
                                        } else if(e.toString().contains('too-many-requests')) {
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Слишком много запросов на отправку СМС')));
                                        } else if(e.toString().contains('session-expired')) {
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Сессия истекла')));
                                        } else if(e.toString().contains('missing-verification-code')) {
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Код подтверждения не указан')));
                                        } else if(e.toString().contains('invalid-verification-code')) {
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Некорректный код подтверждения')));
                                        } else if(e.toString().contains('missing-verification-id')){
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Идентификатор верификации не указан')));
                                        } else if(e.toString().contains('invalid-verification-id')) {
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Некорректный идентификатор верификации')));
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                                        }
                                      } 
                                    }
                                    else {
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Заполните поле с номером телефона')));
                                    }
                                },
                                highlightColor: Colors.white.withOpacity(0.3),
                                splashColor: Colors.indigo.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(5),
                                child: const Align(
                                    alignment: Alignment.center,
                                    child: Text("Войти по номеру телефона", textAlign: TextAlign.center, style: TextStyle(color: Colors.white),)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                      width: 250,
                      height: 50,
                      child: Material(
                        color: Color.fromRGBO(198, 72, 200, 1),
                        borderRadius: BorderRadius.circular(5),
                        child: InkWell(
                          onTap: () async {
                            if((login.text.isNotEmpty && phone.text.isEmpty)) {
                                      try {
                                        await FirebaseAuth.instance.sendSignInLinkToEmail(email: login.text, actionCodeSettings: acs);
                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ссылка отправлена на почту')));
                                        emailAuth = login.text;
                                      } catch (e) {
                                        if(e.toString().contains('user-not-found')) {
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Пользователь с такой почтой не найден')));
                                        } else if(e.toString().contains('invalid-email')) {
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Некорректный формат почты')));
                                        } else if(e.toString().contains('too-many-requests')) {
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Слишком много запросов на отправку писем')));
                                        } else if(e.toString().contains('operation-not-allowed')) {
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Операция не разрешена')));
                                        } else if(e.toString().contains('quota-exceeded')) {
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Превышен лимит отправки писем')));
                                        } 
                                        else {
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                                        }
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Заполните почту')));
                                    }
                          },
                          highlightColor: Colors.white.withOpacity(0.3),
                          splashColor: Colors.indigo.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(5),
                          child: const Align(
                              alignment: Alignment.center,
                              child: Text("Войти по ссылке",
                                  textAlign: TextAlign.center, style: TextStyle(color: Colors.white),)),
                        ),
                      ),
                    ),
                        SizedBox(
                      width: 250,
                      height: 50,
                      child: Material(
                        color: Color.fromRGBO(198, 72, 200, 1),
                        borderRadius: BorderRadius.circular(5),
                        child: InkWell(
                          onTap: () async {
                            if(capcha.text.isEmpty){
                              try {
                                await FirebaseAuth.instance.signInWithEmailAndPassword(email: login.text, password: password.text);
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Успешная авторизация')));
                              } catch (e) {
                              if(e.toString().contains('user-not-found')) {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Пользователь с такой почтой не найден')));
                              } else if(e.toString().contains('wrong-password')) {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Неверный пароль')));
                              } else if(e.toString().contains('invalid-email')) {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Некорректный формат почты')));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                              }
                              }
                            } else{
                              try{
                                if(capcha.text.length < 6) throw Exception('Код подтверждения не валиден');

                                UserCredential userCredential = await confirmationResult_.confirm(capcha.text);

                                if(userCredential != null) {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Успешная авторизация')));
                                } else throw Exception('Ошибка при авторизации');
                                
                              } catch(e) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                              }
                            }
                          },
                          highlightColor: Colors.white.withOpacity(0.3),
                          splashColor: Colors.indigo.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(5),
                          child: const Align(
                              alignment: Alignment.center,
                              child: Text("Войти", textAlign: TextAlign.center, style: TextStyle(color: Colors.white),)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 250,
                      height: 50,
                      child: Material(
                        color: Color.fromRGBO(198, 72, 200, 1),
                        borderRadius: BorderRadius.circular(5),
                        child: InkWell(
                          onTap: () async {
                            try {
                              await FirebaseAuth.instance.createUserWithEmailAndPassword(email: login.text, password: password.text);
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Успешная регистрация')));
                            } catch (e) {
                              if(e.toString().contains('email-already-in-use')) {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Пользователь с такой почтой уже существует')));
                              } else if(e.toString().contains('weak-password')) {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Пароль должен быть не менее 6 символов')));
                              } else if(e.toString().contains('invalid-email')) {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Некорректный формат почты')));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                              }
                            }
                          },
                          highlightColor: Colors.white.withOpacity(0.3),
                          splashColor: Colors.indigo.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(5),
                          child: const Align(
                              alignment: Alignment.center,
                              child: Text("Регистрация",
                                  textAlign: TextAlign.center, style: TextStyle(color: Colors.white),)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 250,
                      height: 50,
                      child: Material(
                        color: Color.fromRGBO(198, 72, 200, 1),
                        borderRadius: BorderRadius.circular(5),
                        child: InkWell(
                          onTap: () async {
                            try {
                              await FirebaseAuth.instance.signInAnonymously();
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Вы вошли как гость!')));
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                            }
                          },
                          highlightColor: Colors.white.withOpacity(0.3),
                          splashColor: Colors.indigo.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(5),
                          child: const Align(
                              alignment: Alignment.center,
                              child: Text("Войти как гость",
                                  textAlign: TextAlign.center, style: TextStyle(color: Colors.white),)),
                        ),
                      ),
                    )
                    ],
                    ),
                  ],
                ),
      ),
    );
  }
}


