part of 'app_bloc.dart';

abstract class AppState {
  const AppState();
}

class AppStateStarted extends AppState {
  const AppStateStarted();
}

class AppStateAuthenticated extends AppState {
  const AppStateAuthenticated();
}

class AppStateUnAuthenticated extends AppState {
  const AppStateUnAuthenticated();
}
