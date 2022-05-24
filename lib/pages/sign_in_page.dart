import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_auth/cubits/signin/signin_cubit.dart';
import 'package:flutter_bloc_auth/models/custom_error.dart';
import 'package:validators/validators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? email, password;

  void submit() {
    setState(() {
      autovalidateMode = AutovalidateMode.always;
    });
    final form = formkey.currentState;
    if (form == null || !form.validate()) return;

    form.save();
    print('email = $email , password  = $password');
    context.read<SigninCubit>().signIn(email: email!, password: password!);
  }

  errorDialog(BuildContext context, CustomError error) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(error.code),
            content: Text(error.plugin + '\n' + error.message),
            actions: [
              CupertinoDialogAction(
                child: const Text('OK'),
                onPressed: () => Navigator.pop(context),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocConsumer<SigninCubit, SignInState>(
          listener: (context, state) {
            if (state.signInStatus == SignInStatus.error) {
              errorDialog(context, state.error);
            }
          },
          builder: (context, state) {
            return Scaffold(
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Form(
                    key: formkey,
                    autovalidateMode: autovalidateMode,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Icon(
                          Icons.flutter_dash,
                          size: MediaQuery.of(context).size.height * 0.3,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          autocorrect: false,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email),
                          ),
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Must Contain a email';
                            }
                            if (!isEmail(value.trim())) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                          onSaved: (String? value) {
                            email = value;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          autocorrect: false,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            labelText: 'password',
                            prefixIcon: Icon(Icons.email),
                          ),
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Password cant be null";
                            }
                            if (value.trim().length < 6) {
                              return "password must be atleast 6 characters";
                            }
                            return null;
                          },
                          onSaved: (String? value) {
                            password = value;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed:
                              state.signInStatus == SignInStatus.submitting
                                  ? null
                                  : submit,
                          child: Text(
                              state.signInStatus == SignInStatus.submitting
                                  ? '...Loading'
                                  : 'Sign in'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/SignUp');
                          },
                          child: const Text('Sign up'),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
