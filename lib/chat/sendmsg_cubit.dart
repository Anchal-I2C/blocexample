import 'package:bloc/bloc.dart';
import 'package:blocexample/chat/sendmsg_stat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class SendMsgCubit extends Cubit<SendMsgStat> {
  SendMsgCubit() : super(SendMsgStat());

  //late Query query;
  DatabaseReference reference = FirebaseDatabase.instance.ref();

  Future<void> sendMessage(String recieverId) async {
    String? key = reference.push().key;
    if (state.message!.isNotEmpty) {
      print("DATA=====");
      reference
          .child("Chat")
          .child(getChatRoomId(
              FirebaseAuth.instance.currentUser!.uid.toString(), recieverId))
          .child(key!)
          .set({
        "message": state.message,
        "senderId": FirebaseAuth.instance.currentUser!.uid,
        "receiverId": recieverId,
        "timestamp": DateTime.now().millisecondsSinceEpoch,
      });
    }
  }
}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
