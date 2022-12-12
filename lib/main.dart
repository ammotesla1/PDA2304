import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pr4/cubit/click_cubit.dart';
import 'package:flutter_pr4/listCubit/cubit/list_cubit.dart';
import 'package:flutter_pr4/themeCubit/cubit/theme_change_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ThemeChangeCubit(),
        child: BlocProvider(
          create: (context) => ClickCubit(),
          child: BlocProvider(
            create: (context) => ListCubit(),
            child: BlocBuilder<ThemeChangeCubit, ThemeChangeState>(
              builder: (context, state) {
                if (state is OnThemeClick) {
                  return MaterialApp(
                    title: 'Flutter Demo',
                    theme: ThemeData(
                      brightness: context.read<ThemeChangeCubit>().currTheme,
                      primarySwatch: Colors.blue,
                    ),
                    home: const MyHomePage(),
                  );
                }
                
                return MaterialApp(
                  title: 'Flutter Demo',
                  theme: ThemeData(
                    brightness: Brightness.light,
                    primarySwatch: Colors.blue,
                  ),
                  home: const MyHomePage(),
                );
              },
            ),
          ),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("cubit-demo"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Нажмите на кнопку:',
                  ),
                  BlocBuilder<ClickCubit, ClickState>(
                      builder: (context, state) {
                    if (state is OnClick) {
                      return Text(
                        context.read<ClickCubit>().count.toString(),
                        style: Theme.of(context).textTheme.headline4,
                      );
                    }

                    return Text(
                      "Цифра",
                      style: Theme.of(context).textTheme.headline4,
                    );
                  })
                ],
              ),

              const Padding(padding: EdgeInsets.only(bottom: 25)),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'История нажатий:',
                  ),

                  BlocBuilder<ListCubit, ListState>(
                    builder: (context, state) {
                      if(state is OnClickAdd || state is OnClickDel){
                        return SizedBox(
                          height: 400,
                          width: 600,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            padding: const EdgeInsets.all(8),
                            itemCount: context.read<ListCubit>().el_counter,
                            itemBuilder: (context, index) {
                              return Padding(padding: const EdgeInsets.only(bottom: 5),
                              child: Container(
                                height: 50,
                                width: 100,
                                color: Colors.deepPurple,
                                child: Center(child: Text('${(context.read<ListCubit>().elements)[index]}')),
                              ));
                            } 
                          ),
                        );
                      }

                      if (state is EmptyList) {
                      return SizedBox(
                        height: 400,
                        width: 600,
                        child: Text(
                          "Список пуст!",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      );
                    }
                    
                    return Text(
                        "Список пуст!",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline4,
                      );
                    },
                  )
                ],
              )
            ],
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            BlocBuilder<ThemeChangeCubit, ThemeChangeState>(
              builder: (context, state) {
                if (context.read<ThemeChangeCubit>().currTheme ==
                    Brightness.light) {
                  return FloatingActionButton(
                    onPressed: () {
                      context.read<ClickCubit>().ClickLight();
                      context.read<ListCubit>().ClickAdd(context.read<ClickCubit>().count, context.read<ThemeChangeCubit>().currTheme);
                    },
                    tooltip: 'Increment',
                    child: const Icon(Icons.add),
                  );
                } else {
                  return FloatingActionButton(
                    onPressed: () {
                      context.read<ClickCubit>().ClickDark();
                      context.read<ListCubit>().ClickAdd(context.read<ClickCubit>().count, context.read<ThemeChangeCubit>().currTheme);
                    },
                    tooltip: 'Increment',
                    child: const Icon(Icons.add),
                  );
                }
              },
            ),
            BlocBuilder<ThemeChangeCubit, ThemeChangeState>(
              builder: (context, state) {
                if (context.read<ThemeChangeCubit>().currTheme ==
                    Brightness.light) {
                  return FloatingActionButton(
                    onPressed: () {
                      context.read<ClickCubit>().ClickLightMinus();
                      context.read<ListCubit>().ClickAdd(context.read<ClickCubit>().count, context.read<ThemeChangeCubit>().currTheme);
                    },
                    tooltip: 'Decrement',
                    child: const Icon(Icons.remove),
                  );
                } else {
                  return FloatingActionButton(
                    onPressed: () {
                      context.read<ClickCubit>().ClickDarkMinus();
                      context.read<ListCubit>().ClickAdd(context.read<ClickCubit>().count, context.read<ThemeChangeCubit>().currTheme);
                    },
                    tooltip: 'Decrement',
                    child: const Icon(Icons.remove),
                  );
                }
              },
            ),


            const Padding(padding: EdgeInsets.only(left: 100)),
            FloatingActionButton(
              onPressed: () {
                context.read<ThemeChangeCubit>().ThemeClick();
              },
              tooltip: 'Поменяй тему',
              child: const Icon(Icons.brightness_4),
            ),
          ],
        ));
  }
}
