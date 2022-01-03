import 'package:blocexample/userlist/userlist_state.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserlistCubit extends Cubit<UserlistState> {
  UserlistCubit() : super(InitialState()) {
    getList();
  }

  DatabaseReference firebasedatabase =
      FirebaseDatabase.instance.ref().child("User");

  Future<void> getList() async {
    List list = [];
    emit(LoadingState());

    firebasedatabase.onValue.listen((event) {
      var value = event.snapshot.value as Map;
      Map map = value;
      map.forEach((key, value) {
        list.add(value);
      });

      emit(LoadedState(list));
    });
  }
}
