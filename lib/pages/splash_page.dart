import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_auth/blocs/auth/auth_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        print('listener = $state');
        if (state.authstatus == AuthStatus.unauthenticated) {
          Navigator.pushNamed(context, '/SignIn');
        } else if (state.authstatus == AuthStatus.authenticated) {
          Navigator.pushNamed(context, '/Home');
        }
      },
      builder: (context, state) {
        print('builder : $state');
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
