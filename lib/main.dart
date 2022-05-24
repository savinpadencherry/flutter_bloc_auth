import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_auth/blocs/auth/auth_bloc.dart';
import 'package:flutter_bloc_auth/cubits/profile/profile_cubit.dart';
import 'package:flutter_bloc_auth/cubits/signin/signin_cubit.dart';
import 'package:flutter_bloc_auth/cubits/signup/signup_cubit.dart';
import 'package:flutter_bloc_auth/pages/Sign_up.dart';
import 'package:flutter_bloc_auth/pages/home_page.dart';
import 'package:flutter_bloc_auth/pages/profile_page.dart';
import 'package:flutter_bloc_auth/pages/sign_in_page.dart';
import 'package:flutter_bloc_auth/pages/splash_page.dart';
import 'package:flutter_bloc_auth/repositories/auth_repositories.dart';
import 'package:flutter_bloc_auth/repositories/profile_repository.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(
            firebaseFirestore: FirebaseFirestore.instance,
            firebaseAuth: FirebaseAuth.instance,
          ),
        ),
        RepositoryProvider(
          create: (context) => ProfileRepository(
            firebaseFirestore: FirebaseFirestore.instance,
          ),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<SigninCubit>(
            create: (context) => SigninCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<SignupCubit>(
            create: (context) => SignupCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<ProfileCubit>(
            create: (context) => ProfileCubit(
              profileRepository: context.read<ProfileRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
          ),
          home: const SplashScreen(),
          routes: {
            '/SignUp': (context) => const SignUp(),
            '/SignIn': (context) => const SignIn(),
            '/Profile': (context) => const ProfilePage(),
            '/Home': (context) => const HomePage()
          },
        ),
      ),
    );
  }
}
