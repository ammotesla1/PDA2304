part of 'click_cubit.dart';

@immutable
abstract class ClickState {}

class ClickInitial extends ClickState {}

class ClickLight extends ClickState{}

class ClickDark extends ClickState{}

class ClickDarkMinus extends ClickState{}

class ClickLightMinus extends ClickState{}

class OnClick extends ClickState{}