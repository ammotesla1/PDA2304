import 'package:flutter/material.dart';
import 'package:pr2/app_route.dart';
import 'package:pr2/data/repositories/auth_repository_impl.dart';

class Registration extends StatefulWidget{
  const Registration({super.key});

  @override
  State<Registration> createState() => RegistrationState();
}

class RegistrationState extends State<Registration>{

  final loginEditingController =  TextEditingController();
  final passwordEditingController = TextEditingController();
  final surnameEditingController = TextEditingController();
  final nameEditingController = TextEditingController();
  final middlenameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey();

  final AuthRepositoryImpl authRepositoryImpl = AuthRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          key: _key,
          child: Container(
          padding: EdgeInsets.only(left: 5, right: 5),
          alignment: Alignment.center,
          color: Color.fromARGB(255, 235, 201, 201),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              SizedBox(
                width: 300,
                height: 70,
                child: TextFormField(
                controller: emailEditingController,
                maxLength: 100,
                keyboardType: TextInputType.emailAddress,

                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                  labelStyle: const TextStyle(color: Colors.black),
                  border: const OutlineInputBorder(),
                  labelText: 'Почта',
                  suffixIcon: IconButton(onPressed: (){
                    emailEditingController.clear();
                  }, icon: const Icon(Icons.clear)), 
                ),
                validator: (value){
                  
                  if(value!.isEmpty){
                    return 'Введите почту!';
                  }
                  if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)){
                    return 'Невалидная почта!';
                  }
                }
              ),),


              SizedBox(
                width: 300,
                height: 70,
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
                  if(value.length < 4 || value.length > 100){
                    return 'Логин должен быть не меньше 4 символов и должен быть не больше 100 символов!';
                  }
              
                  return null;
                }
              ),),

              SizedBox(
                width: 300,
                height: 70,
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

              SizedBox(
                width: 300,
                height: 70,
                child: TextFormField(
                controller: surnameEditingController,
                maxLength: 100,

                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                  labelStyle: const TextStyle(color: Colors.black),
                  border: const OutlineInputBorder(),
                  labelText: 'Фамилия',
                  suffixIcon: IconButton(onPressed: (){
                    surnameEditingController.clear();
                  }, icon: const Icon(Icons.clear)), 
                ),

                validator: (value){
                  
                  if(value!.isEmpty){
                    return 'Введите фамилию!';
                  }
                }
              ),),

              SizedBox(
                width: 300,
                height: 70,
                child: TextFormField(
                controller: nameEditingController,
                maxLength: 100,

                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                  labelStyle: const TextStyle(color: Colors.black),
                  border: const OutlineInputBorder(),
                  labelText: 'Имя',
                  suffixIcon: IconButton(onPressed: (){
                    nameEditingController.clear();
                  }, icon: const Icon(Icons.clear)), 
                ),

                validator: (value){
                  
                  if(value!.isEmpty){
                    return 'Введите имя!';
                  }
                }
              ),),

              SizedBox(
                width: 300,
                height: 70,
                child: TextField(
                controller: middlenameEditingController,
                maxLength: 100,

                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                  labelStyle: const TextStyle(color: Colors.black),
                  border: const OutlineInputBorder(),
                  labelText: 'Отчество',
                  suffixIcon: IconButton(onPressed: (){
                    middlenameEditingController.clear();
                  }, icon: const Icon(Icons.clear)), 
                ),
              ),),

              
              const Padding(padding: EdgeInsets.only(top: 15)),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    color: Color.fromARGB(255, 125, 37, 139),
                    borderRadius: BorderRadius.circular(5),
                    child: InkWell(
                      onTap: () {
                        if(_key.currentState!.validate()){
                          authRepositoryImpl.signUp(loginEditingController.text, passwordEditingController.text, surnameEditingController.text, nameEditingController.text, middlenameEditingController.text, emailEditingController.text);
                          Navigator.pushReplacementNamed(context, loginScreen);
                        }
                        else{}
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 230,
                        height: 50,
                        child: const Text('Зарегестрироваться',
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
                        Navigator.pushReplacementNamed(context, loginScreen);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 100,
                        height: 50,
                        child: const Text('Войти',
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
}