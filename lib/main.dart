import 'package:flutter/material.dart';
import 'package:pr5/screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(MyApp(sharedPreferences));
}

class MyApp extends StatelessWidget {
  const MyApp(this.sharedPreferences, {super.key});

  final SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(

          primarySwatch: Colors.purple,
        ),
        home: MyHomePage(sharedPreferences, title: 'SharedPreferences',),
      );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage(this.sharedPreferences, {super.key, required this.title});
  final SharedPreferences sharedPreferences;
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 500,
              height: 50,
              child: TextField(
                controller: _controller,
                style: Theme.of(context).textTheme.headline4,
                decoration: InputDecoration(
                hintText: 'Введите строку',
                
              ),
              ),
            ),

            const Padding(padding: EdgeInsets.only(bottom: 25)),

            ElevatedButton(onPressed: () => {

              widget.sharedPreferences.setString('text', _controller.text),
              Navigator.push(context, MaterialPageRoute(builder: (_) => Screen(widget.sharedPreferences),
              ))
            }, 
            style: ElevatedButton.styleFrom(primary: Color.fromARGB(255, 50, 147, 69)),
            child: const Text('Запомню то что ты написал сейчас')),

            const Padding(padding: EdgeInsets.only(bottom: 25)),

            ElevatedButton(onPressed: () => {
            
              widget.sharedPreferences.getString('text'),
              Navigator.push(context, MaterialPageRoute(builder: (_) => Screen(widget.sharedPreferences),
              )),
            },
            style: ElevatedButton.styleFrom(primary: Color.fromARGB(255, 142, 74, 166)),
             child: const Text('Вывожу то что ты написал раньше'))
          ],
        ),
      )
    );
  }
}
