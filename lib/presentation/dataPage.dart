import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_firebase/app_router.dart';

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
        child: Row(
          children: [
            Expanded(
              flex: 30,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10.0),
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
                    margin: EdgeInsets.only(bottom: 10.0),
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
              
                  Container(
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
              
                  const SizedBox(height: 8),

                  Container(
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          Navigator.pushReplacementNamed(context, signInPage);
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: Text('Назад', style: TextStyle(fontSize: 18))
                    ),
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
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text("Название: ${documentSnapshot['name']}", style: TextStyle(fontSize: 22)),
                                // Text("Описание: ${documentSnapshot['description']}", style: TextStyle(fontSize: 22)),
                                // Text("Категория: ${documentSnapshot['category']}", style: TextStyle(fontSize: 22)),
                                // Text("Дата: ${documentSnapshot['date']}", style: TextStyle(fontSize: 22)),
                                // Text("Сумма: ${documentSnapshot['sum']}", style: TextStyle(fontSize: 22)),
                                Text("Email: ${documentSnapshot['email']}", style: TextStyle(fontSize: 22)),
                                Text("Пароль: ${documentSnapshot['password']}", style: TextStyle(fontSize: 22)),
                                
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    SizedBox(height: 5),
                                    ElevatedButton(
                                      onPressed: () {
                                        _email.text = documentSnapshot['email'];
                                        _password.text = documentSnapshot['password'];
                                      },
                                      child: const Icon(Icons.search)
                                    ),
                                    const SizedBox(width: 8),
                                    ElevatedButton(
                                      onPressed: () {
                                        updateData(documentSnapshot);
                                      },
                                      child: const Icon(Icons.edit)
                                    ),
                                    const SizedBox(width: 8),
                                    ElevatedButton(
                                      onPressed: () {
                                        deleteData(documentSnapshot.id);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red
                                      ),
                                      child: const Icon(Icons.delete),
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
                    child: Text("Loading...", style: TextStyle(fontSize: 22))
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