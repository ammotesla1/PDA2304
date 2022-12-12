import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'theme_change_state.dart';

class ThemeChangeCubit extends Cubit<ThemeChangeState> {
  ThemeChangeCubit() : super(ThemeChangeInitial());

  Brightness currTheme = Brightness.light;

  void ThemeClick(){
    emit(OnThemeClick());

    if(currTheme == Brightness.light) { 
      currTheme = Brightness.dark;
      emit(OnThemeClick());
    } 
    else { 
      currTheme = Brightness.light; 
      emit(OnThemeClick());
    }
  }

}
