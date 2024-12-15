part of 'plugin_view_bloc.dart';

abstract class PluginViewState {}

class PluginViewInitialState extends PluginViewState {}

class PluginViewLoadingState extends PluginViewState {}

class PluginViewDataFetchState extends PluginViewState {
  final String ipAddress;
  final String city;
  final List<LastLoginModel> lastLoginModelList;

  PluginViewDataFetchState({required this.ipAddress, required this.city,required this.lastLoginModelList});
}

class PluginViewErrorState extends PluginViewState {
  final String errorMessage;

  PluginViewErrorState({required this.errorMessage});
}

class PluginViewDataCreateState extends PluginViewState {
  final List<LastLoginModel> lastLoginModelList;
  PluginViewDataCreateState(this.lastLoginModelList);
}



