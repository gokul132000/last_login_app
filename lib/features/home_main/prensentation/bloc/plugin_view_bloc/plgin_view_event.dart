part of 'plugin_view_bloc.dart';

abstract class PluginViewEvent {}

class PluginViewFetchIPEvent extends PluginViewEvent {}

class PluginViewSaveEvent extends PluginViewEvent{
  final LastLoginModel moneyVieModel;
  PluginViewSaveEvent(this.moneyVieModel);
}




