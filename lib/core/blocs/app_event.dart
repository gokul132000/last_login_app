part of 'app_bloc.dart';

abstract class AppEvent {
  const AppEvent();
}

class AppEventInit extends AppEvent {
  const AppEventInit();
}

class AppEventFetchUserData extends AppEvent {
  const AppEventFetchUserData();
}
