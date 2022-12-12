import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'list_state.dart';

class ListCubit extends Cubit<ListState> {
  ListCubit() : super(ListInitial());

  int el_counter = 0;
  List<String> elements = <String>[];

  void ClickAdd(int count, Brightness currTheme){

    if(currTheme == Brightness.light){
      elements.add("Число: $count; Тема: Светлая");
    } else {
      elements.add("Число: $count; Тема: Тёмная".replaceAll("Entry", ""));
    }

    
    el_counter++;

    emit(OnClickAdd());
  }

  void ClickDel(){

    if(elements.isNotEmpty){

      elements.removeAt(el_counter-1);
      
      el_counter--;

      if(el_counter == 0){
        emit(EmptyList());
      } else{
        emit(OnClickDel());
      }
    }

  }
}
