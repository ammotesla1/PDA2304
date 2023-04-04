import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TestStatePage extends StatefulWidget {
  const TestStatePage({super.key});

  @override
  State<TestStatePage> createState() => _TestStatePageState();
}

final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

TextEditingController _email = TextEditingController();
TextEditingController _password = TextEditingController();

GlobalKey<FormState> _key = GlobalKey();

class _TestStatePageState extends State<TestStatePage> {

  @override
  Widget build(BuildContext context) {

    double c_width = MediaQuery.of(context).size.width*0.4;

    return Scaffold(
      
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15,15,0,15),
        child: Column(
          children: [
            Expanded(
              flex: 30,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
                    child: TextFormField(
                      controller: _email,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Email',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: (){
                            _email.clear();
                          },
                        )
                      ),
                    ),
                  ),
              
                  Container(
                    margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
                    child: TextFormField(
                      controller: _password,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Пароль',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: (){
                            _password.clear();
                          },
                        )
                      ),
                    ),
                  ),
              
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: ElevatedButton(
                              onPressed: () async {
                                try {
                                  insertData();
                                } catch (e) {
                                  print(e);
                                }
                              },
                              child: Text('Создать', style: TextStyle(fontSize: 18))
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                                          child: ElevatedButton(
                        onPressed: () async {
                          try {
                            Navigator.pop(context);
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: Text('Назад', style: TextStyle(fontSize: 18))
                                          ),
                                        ),
                      ),
                    ],
                  ),
              

                  
                ],
              ),
            ),
      
            Expanded(
              flex: 70,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("users").snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if(snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, i){
                        final DocumentSnapshot documentSnapshot = snapshot.data!.docs[i];
                        return Card(
                          margin: const EdgeInsets.fromLTRB(15,0,15,15),
                          color: Color.fromRGBO(240, 244, 206, 0.86),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text("Email: ${documentSnapshot['email']}", style: TextStyle(fontSize: 22,)),
                                Spacer(),

                                Text("Пароль: ${documentSnapshot['password']}", style: TextStyle(fontSize: 22)),
                                Spacer(),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      
                                      onPressed: () {
                                        updateData(documentSnapshot);
                                      },
                                      style: ButtonStyle(alignment: Alignment.centerRight),
                                      child:const Text("Изменить")
                                    ),
                                    const SizedBox(width: 8),
                                    ElevatedButton(
                                      onPressed: () {
                                        deleteData(documentSnapshot.id);
                                      },
                                      style: ButtonStyle(alignment: Alignment.centerRight),                                      
                                      child:const Text("Удалить"),
                                    ),
                                  ],
                                ),
                              ],
                              
                            ),
                          ),
                        );
                      },
                    );
                  }
                  if(snapshot.hasError) {
                    return Text("Ошибка загрузки данных", style: TextStyle(fontSize: 22));
                  }
                  return const Center(
                    child: Text("Подождите", style: TextStyle(fontSize: 22))
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> insertData() async {
    final String email = _email.text;
    final String password = _password.text;

    if(_email.text.isNotEmpty && _password.text.isNotEmpty) {
      await FirebaseFirestore.instance.collection("users")
        .add({"email": email, "password": password});

      _email.clear();
      _password.clear();

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Успешное добавление данных!")));
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Заполните все поля!")));
    }
  }

  Future<void> updateData([DocumentSnapshot? documentSnapshot]) async {
    final String email = _email.text;
    final String password = _password.text;

    if(_email.text.isNotEmpty && _password.text.isNotEmpty) {
      await FirebaseFirestore.instance.collection("users")
        .doc(documentSnapshot!.id)
        .update({"email": email, "password": password});

      _email.clear();
      _password.clear();

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Запись успешно обновлена!")));
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Заполните все поля!")));
    }
  }

  Future<void> deleteData(String id) async {
    await FirebaseFirestore.instance.collection("users")
      .doc(id)
      .delete();
    
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Запись успешно удалена!")));
  }
}