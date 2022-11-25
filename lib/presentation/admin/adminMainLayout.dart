import 'package:flutter/material.dart';
import 'package:pr2/app_route.dart';
import 'package:pr2/data/repositories/auth_repository_impl.dart';

class Admin extends StatefulWidget{
  const Admin({super.key});

  @override
  State<Admin> createState() => AdminState();
}

class AdminState extends State<Admin>{

  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Color.fromARGB(255, 140, 190, 251),
          alignment: Alignment.center,
          child: Column(
            children: [
              
              const Text("Окно админа", style: TextStyle(height: 40)),

              Material(
                      color: Color.fromARGB(255, 94, 1, 94),
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
                              color: Color.fromARGB(255, 36, 247, 50),
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