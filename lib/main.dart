import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app.dart';
import 'core/blocs/app_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyC-B47gi3sYL3hWG3n9RPrESqQK_Qo51C4',
      appId: '1:855433570547:android:331c38b8a7cdf522e8ef86',
      messagingSenderId: '855433570547',
      projectId: 'myapp-53ac8',
      storageBucket: 'myapp-53ac8.firebasestorage.app',
    ),
  );
  runApp(
    BlocProvider(
      create: (context) => AppBloc()..add(const AppEventFetchUserData()),
      child: const App(),
    ),
  );
}
