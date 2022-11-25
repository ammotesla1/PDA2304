import 'package:flutter/material.dart';
import 'package:pr2/app_route.dart';
import 'package:pr2/data/repositories/auth_repository_impl.dart';

class Client extends StatefulWidget{
  const Client({super.key});

  @override
  State<Client> createState() => ClientState();
}

class ClientState extends State<Client>{


  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          color: Color.fromARGB(255, 244, 216, 124),
          child: Column(
            children: [
              const Text("Окно пользователя",style: TextStyle(height: 40)),

              Material(
                      color: Color.fromARGB(255, 215, 71, 102),
                      borderRadius: BorderRadius.circular(5),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, loginScreen);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 150,
                          height: 50,
                          child: const Text('Выйти',
                            style: TextStyle(
                              color: Color.fromARGB(255, 209, 255, 100),
                            ),),
                        ),),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}