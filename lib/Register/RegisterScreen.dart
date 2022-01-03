import 'package:blocexample/Register/RegisterCubit.dart';
import 'package:blocexample/Register/registerStat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final key = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: BlocProvider(
        create: (context) => RegisterCubit(),
        child: SingleChildScrollView(
          child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: BlocBuilder<RegisterCubit, RegisterStat>(
                builder: (context, state) => Form(
                  key: key,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: nameController,
                        validator: (value) {
                          return validateName(value!);
                        },
                        decoration: InputDecoration(hintText: 'Name'),
                        onChanged: (value) {
                          state.name = value;
                        },
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
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
                                .read<RegisterCubit>()
                                .signInWithCredentials(context);
                          }
                        },
                        child: Text("SignIn"),
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }

  validateName(String value) {
    if (value.isEmpty)
      return "Name Can't Be Empty..!";
    else
      return value.length < 2 ? "Please Enter Minimum 2 character..! " : null;
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
