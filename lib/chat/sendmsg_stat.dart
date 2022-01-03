import 'package:equatable/equatable.dart';

class SendMsgStat extends Equatable {
 // List? chat;
  String? chatId = "";
  String? senderId = "";
  String? receiverId = "";
  String? message = "";
  String? timeStamp = "";
  String? uid = "";

  SendMsgStat({
    //this.chat,
    this.chatId,
    this.senderId,
    this.receiverId,
    this.message,
    this.timeStamp,
    this.uid,
  });

  @override
  List<Object?> get props =>
      [chatId, senderId, receiverId, message, timeStamp, uid];

  SendMsgStat copyWith({
    //required List chat,
    String? chatId,
    String? senderId,
    String? receiverId,
    String? message,
    String? timeStamp,
    String? uid,
  }) {
    return SendMsgStat(
     // chat: chat ?? this.chat,
      chatId: chatId ?? this.chatId,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      message: message ?? this.message,
      timeStamp: timeStamp ?? this.timeStamp,
      uid: uid ?? this.uid,
    );
  }
}
