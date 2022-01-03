import 'package:blocexample/Register/registerStat.dart';
import 'package:blocexample/login/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterStat> {
  RegisterCubit() : super(RegisterStat());

  Future<void> signInWithCredentials(context) async {
    DatabaseReference firebasedatabase = FirebaseDatabase.instance.ref();
    if (state.email != null && state.email!.isEmpty) {
      print("Email is empty");
    } else if (state.password != null && state.password!.isEmpty) {
      print("Password is empty");
    } else {
      try {
        FirebaseAuth auth = FirebaseAuth.instance;
        await auth
            .createUserWithEmailAndPassword(
                email: state.email!, password: state.password!)
            .then((value) {
          firebasedatabase
              .child("User")
              .child(FirebaseAuth.instance.currentUser!.uid)
              .set({
            "name" : state.name,
            "email" : value.user!.email,
            "password":state.password,
            "id" : value.user!.uid,
              });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
          print("==Success==");
        }).catchError((onError) {
          print("Faild===== $onError");
        });
      } on Exception catch (e) {
        print("error===: ${e.toString()}");
      }
    }
  }
}
