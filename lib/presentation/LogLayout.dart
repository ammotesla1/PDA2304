import 'package:flutter/material.dart';
import 'package:pr2/app_route.dart';
import 'package:pr2/data/repositories/auth_repository_impl.dart';
import 'package:pr2/domain/entity/role_entity.dart';

import '../domain/usecases/auth.dart';

class Login extends StatefulWidget{
  const Login({super.key});

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login>{

  final loginEditingController =  TextEditingController();
  final passwordEditingController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey();

  final AuthRepositoryImpl authRepositoryImpl = AuthRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _key,
          child: Container(
          alignment: Alignment.center,
          color: Color.fromARGB(255, 235, 201, 201),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              SizedBox(
                width: 420,
                height: 100,
                child: TextFormField(
                controller: loginEditingController,
                maxLength: 100,
                
                
                

                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                  labelStyle: const TextStyle(color: Colors.black),
                  border: const OutlineInputBorder(),
                  labelText: 'Логин',
                  suffixIcon: IconButton(onPressed: (){
                    loginEditingController.clear();
                  },
                  icon: const Icon(Icons.clear),
                  ), 
                ),

                validator: (value){
                  
                  if(value!.isEmpty){
                    return 'Введите логин!';
                  }
                  if(value.length < 4){
                    return 'Логин должен быть не меньше 4 символов!';
                  }
                  return null;
                }
              ),),

              SizedBox(
                width: 420,
                height: 145,
                child: TextFormField(
                controller: passwordEditingController,
                maxLength: 100,

                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                  labelStyle: const TextStyle(color: Colors.black),
                  border: const OutlineInputBorder(),
                  labelText: 'Пароль',
                  suffixIcon: IconButton(onPressed: (){
                    passwordEditingController.clear();
                  }, icon: const Icon(Icons.clear)), 
                ),

                validator: (value){
                  
                  if(value!.isEmpty){
                    return 'Введите пароль!';
                  }
                  if(value.length < 8){
                    return 'Пароль должен быть не меньше 8 символов!';
                  }
                  if(!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(value)){
                    return 'Пароль должен содержать:\n - Только латиницу; - Одну большую букву\n - Одну маленькую букву; - Одну цифру\n - Один спец. символ';
                  }
                  return null;
                }
              ),),

              const Padding(padding: EdgeInsets.only(top: 55)),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    color: Color.fromARGB(255, 125, 37, 139),
                    borderRadius: BorderRadius.circular(5),
                    child: InkWell(
                      onTap: () {
                        if(_key.currentState!.validate()){
                          signIn();
                        }
                        else{}
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 100,
                        height: 50,
                        child: const Text('Вход',
                          style: TextStyle(
                            color: Colors.white,
                          ),),
                        
                        
                      ),),
                  ),

              const Padding(padding: EdgeInsets.only(left: 5)),

                  Material(
                    color: Color.fromARGB(255, 125, 37, 139),
                    borderRadius: BorderRadius.circular(5),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, registrationScreen);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 150,
                        height: 50,
                        child: const Text('Назад',
                          style: TextStyle(
                            color: Colors.white,
                          ),),
                      ),),
                  ),
                ],
              )
            ],
          ),),
        )
      )
    );
  }
      void signIn() async {
        var result = await Auth(authRepositoryImpl).singIn(
        AuthParams(
          login: loginEditingController.text, 
          password: passwordEditingController.text, 
          )
        );
        
        result.fold((l){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Неверный логин или пароль!'),
            ),
          );
        }, 

      (r) {
        switch(r){
          case RoleEnum.admin: {
            Navigator.pushReplacementNamed(context, adminScreen);
            break;
          }
          case RoleEnum.user: {
            Navigator.pushReplacementNamed(context, userScreen);
            break;
          }
        }
      });
  }
}