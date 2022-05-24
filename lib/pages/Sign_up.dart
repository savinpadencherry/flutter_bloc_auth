import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_auth/cubits/signup/signup_cubit.dart';
import 'package:validators/validators.dart';

import '../models/custom_error.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> signUpformkey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? name, email, password;
  TextEditingController _passwordController = TextEditingController();

  void submit() {
    print('function called');
    setState(() {
      autovalidateMode = AutovalidateMode.always;
    });
    final form = signUpformkey.currentState;
    if (form == null || !form.validate()) return;
    form.save();
    print('email = $email , password  = $password, name  = $name');
    context
        .read<SignupCubit>()
        .signUp(name: name!, email: email!, password: password!);
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
        child: BlocConsumer<SignupCubit, SignupState>(
          listener: (context, state) {
            if (state.signUpStatus == SignUpStatus.error) {
              errorDialog(context, state.error);
            }
          },
          builder: (context, state) {
            return Scaffold(
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Form(
                    key: signUpformkey,
                    autovalidateMode: autovalidateMode,
                    child: ListView(
                      shrinkWrap: true,
                      reverse: true,
                      children: [
                        Icon(
                          Icons.flutter_dash,
                          size: MediaQuery.of(context).size.height * 0.3,
                        ),
                        TextFormField(
                          autocorrect: false,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            labelText: 'Name',
                            prefixIcon: Icon(Icons.email),
                          ),
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Must Contain a Name';
                            }
                            return null;
                          },
                          onSaved: (String? value) {
                            name = value;
                          },
                        ),
                        const SizedBox(
                          height: 20,
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
                          controller: _passwordController,
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
                        TextFormField(
                          autocorrect: false,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            labelText: 'Confirm password',
                            prefixIcon: Icon(Icons.email),
                          ),
                          validator: (String? value) {
                            if (_passwordController.text != value) {
                              return "Passwords dont match";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed:
                              state.signUpStatus == SignUpStatus.submitting
                                  ? null
                                  : submit,
                          child: Text(
                              state.signUpStatus == SignUpStatus.submitting
                                  ? '...Loading'
                                  : 'Sign Up'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/SignIn');
                          },
                          child: const Text('Sign In'),
                        )
                      ].reversed.toList(),
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
