import 'package:blocexample/Register/RegisterScreen.dart';
import 'package:blocexample/login/LoginCubit.dart';
import 'package:blocexample/login/LoginState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final key = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: BlocProvider(
        create: (context) => LoginCubit(),
        child: SingleChildScrollView(
          child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  return Form(
                    key: key,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: emailController,
                          validator: (value) {
                            return validateEmail(value!);
                          },
                          decoration: InputDecoration(hintText: 'Email'),
                          onChanged: (value) {
                            state.email = value;
                          },
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                          controller: passwordController,
                          validator: (value) {
                            return validatePassword(value!);
                          },
                          decoration: InputDecoration(hintText: 'Password'),
                          onChanged: (value) {
                            state.password = value;
                          },
                        ),
                        SizedBox(height: 20),
                        MaterialButton(
                          color: Colors.blue,
                          onPressed: () {
                            if (key.currentState!.validate()) {
                              context
                                  .read<LoginCubit>()
                                  .logInWithCredentials(context);
                            }
                          },
                          child: Text("Login"),
                        ),
                        SizedBox(height: 20),
                        MaterialButton(
                          color: Colors.blue,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterScreen()),
                            );
                          },
                          child: Text("SignIn"),
                        ),
                      ],
                    ),
                  );
                },
              )),
        ),
      ),
    );
  }

  validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty)
      return "Email Can't Be Empty..!";
    else
      return !regex.hasMatch(value) ? "Please Enter a Valid Email..!" : null;
  }

  validatePassword(String value) {
    if (value.isEmpty) {
      return "Password Must Be Required..!";
    } else {
      return value.length < 6
          ? "Please Enter Minimum 6 character Password..!"
          : null;
    }
  }
}
