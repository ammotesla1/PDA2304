import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'click_state.dart';

class ClickCubit extends Cubit<ClickState> {
  ClickCubit() : super(ClickInitial());

  int count = 0;

  void ClickLight() {

    count++;
    emit(OnClick());
  }

  void ClickDark() {

    count+=2;
    emit(OnClick());
  }

  void ClickLightMinus() {

    count--;
    emit(OnClick());
  }

  void ClickDarkMinus() {

    count-=2;
    emit(OnClick());
  }
}
