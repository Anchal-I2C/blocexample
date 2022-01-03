import 'package:equatable/equatable.dart';

abstract class GetChatStat extends Equatable {
}

class ChatInitialState extends GetChatStat {
  @override
  List<Object> get props => [];
}
class ChatLoadingState extends GetChatStat {
  @override
  List<Object> get props => [];
}
class ChatLoadedState extends GetChatStat {
  ChatLoadedState(this.chatdata);

  List chatdata;

  @override
  List<Object> get props => [chatdata];
}
class ChatErrorState extends GetChatStat {
  @override
  List<Object> get props => [];
}
