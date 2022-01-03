import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'LoginState.dart';
import 'home_page.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState());

  Future<void> logInWithCredentials(context) async {
    if (state.email != null && state.email!.isEmpty) {
      print("Email is empty");
    } else if (state.password != null && state.password!.isEmpty) {
      print("Password is empty");
    } else {
      try {
        FirebaseAuth auth = FirebaseAuth.instance;
        await auth
            .signInWithEmailAndPassword(
                email: state.email!, password: state.password!)
            .then((value) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
          print("Success");
        }).catchError((onError) {
          print("Faild ${onError}");
        });
      } on Exception catch (e) {
        print("error ${e.toString()}");
      }
    }
  }
}
