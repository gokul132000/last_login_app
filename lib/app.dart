import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/widget/primary_scaffold.dart';

import 'core/blocs/app_bloc.dart';
import 'features/authentication/presentation/pages/sign_in_page.dart';
import 'features/home_main/prensentation/pages/plugin_view_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      debugShowCheckedModeBanner: false,
      home: const AuthRouter(),
    );
  }
}

class AuthRouter extends StatelessWidget {
  const AuthRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        if (state is AppStateAuthenticated) {
          return const PluginViewPage();
        } else if (state is AppStateUnAuthenticated) {
          return SignInPage();
        } else {
          return const PrimaryScaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}