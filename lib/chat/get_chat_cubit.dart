import 'package:blocexample/chat/get_chat_stat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetChatCubit extends Cubit<GetChatStat> {
  String reciever;

  GetChatCubit(this.reciever) : super(ChatInitialState()) {
    getChatList(reciever);
  }

  DatabaseReference firebasedatabase =
      FirebaseDatabase.instance.ref().child("Chat");

  Future<void> getChatList(recieverid) async {
    List getchatlist = [];
    emit(ChatLoadingState());

    firebasedatabase
        .child(
            getChatRoomId(FirebaseAuth.instance.currentUser!.uid, recieverid))
        .onValue
        .listen((event) {
      // print("Value::::MESSAGE:::${event.snapshot.value}"); Print("Value")
      var value = event.snapshot.value as Map;
      getchatlist.clear();
      Map map = value;
      print("AAAAAAAAANNNNNNNN : ${map}");
      map.forEach((key, value) {
        print("Value::::MESSAGE:::${event.snapshot.value}");
        getchatlist.add(value);
        print("Value::::MESSAGE:::${key}");
      });

      emit(ChatLoadedState(getchatlist));

      Change<ChatLoadedState> change = Change(
          currentState: ChatLoadedState(getchatlist),
          nextState: ChatLoadedState(getchatlist));
      // change.currentState.chatdata.addAll(getchatlist);
      onChange(change);
    });
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }
}
