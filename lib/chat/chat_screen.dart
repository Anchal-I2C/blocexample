import 'package:blocexample/chat/sendmsg_cubit.dart';
import 'package:blocexample/chat/get_chat_cubit.dart';
import 'package:blocexample/chat/get_chat_stat.dart';
import 'package:blocexample/chat/sendmsg_stat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: must_be_immutable
class ChatScreen extends StatefulWidget {
  String id;
  String name;

  ChatScreen({Key? key, required this.id, required this.name})
      : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();

  //ScrollController scrollController = ScrollController();
  // GetChatCubit getChatCubit = GetChatCubit();

  @override
  void initState() {
    // messageController.addListener(() { });
    // getChatCubit.getChatList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) {
        return SendMsgCubit();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:
              BlocBuilder<SendMsgCubit, SendMsgStat>(builder: (context, stat) {
            print("Name..${widget.name}");
            return Text(widget.name);
          }),
        ),
        body: BlocProvider(
          create: (context) {
            return GetChatCubit(widget.id);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<GetChatCubit, GetChatStat>(
                  builder: (context, stat) {
                    if (stat is ChatLoadingState) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (stat is ChatErrorState) {
                      return Center(
                        child: Icon(Icons.close),
                      );
                    } else if (stat is ChatLoadedState) {
                      print("chatlist : ${stat.chatdata}");
                      return Expanded(
                        child: ListView.builder(
                            //controller: scrollController,
                            shrinkWrap: true,
                            itemCount: stat.chatdata.length,
                            itemBuilder: (context, index) {
                              // return Container(
                              //   child: Text("${stat.chatdata[index]["message"]}"),
                              // );
                              return Row(
                                mainAxisAlignment: (stat.chatdata[index]
                                            ["senderId"] ==
                                        FirebaseAuth.instance.currentUser!.uid)
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: (stat.chatdata[index]
                                                  ["senderId"] ==
                                              FirebaseAuth
                                                  .instance.currentUser!.uid)
                                          ? Colors.blue
                                          : Color(0xffE8E8E8),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(12),
                                        topLeft: Radius.circular(12),
                                        bottomLeft: (stat.chatdata[index]
                                                    ["senderId"] ==
                                                FirebaseAuth
                                                    .instance.currentUser!.uid)
                                            ? Radius.circular(12)
                                            : Radius.circular(12),
                                        bottomRight: (stat.chatdata[index]
                                                    ["senderId"] ==
                                                FirebaseAuth
                                                    .instance.currentUser!.uid)
                                            ? Radius.circular(12)
                                            : Radius.circular(12),
                                      ),
                                    ),
                                    width: width * 0.4,
                                    padding: EdgeInsets.symmetric(
                                      vertical: height * 0.01,
                                      horizontal: width * 0.015,
                                    ),
                                    margin: EdgeInsets.symmetric(
                                      vertical: height * 0.005,
                                      horizontal: width * 0.02,
                                    ),
                                    child: Text("${stat.chatdata[index]["message"]}"),
                                    //Text(stat.chatdata[index]["message"]),
                                  ),
                                ],
                              );
                            }),
                      );
                    } else {
                      return Center(
                        child: Text("No Data found"),
                      );
                    }
                  },
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 48,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color(0xffF2F3F2),
                        borderRadius: BorderRadius.circular(
                          30,
                        ),
                        border: Border.all(
                          color: Colors.grey,
                        )),
                    child: BlocBuilder<SendMsgCubit, SendMsgStat>(
                      builder: (context, stat) => TextField(
                        onChanged: (value) {
                          stat.message = value;
                        },
                        controller: messageController,
                        maxLines: 2,
                        cursorColor: Colors.blue,
                        decoration: InputDecoration(
                          hintText: "Message here...",
                          contentPadding: EdgeInsets.all(10),
                          hintStyle: TextStyle(
                            color: Color(0xffBDBDBD),
                            fontFamily: "PoppinsMedium",
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              // scrollController.animateTo(
                              //     scrollController.position.maxScrollExtent,
                              //     duration: Duration(milliseconds: 100),
                              //     curve: Curves.easeInOut);
                              context
                                  .read<SendMsgCubit>()
                                  .sendMessage(widget.id);
                              messageController.clear();
                            },
                            icon: Icon(
                              Icons.arrow_forward,
                              color: Colors.blue,
                            ),
                          ),

                          // : null,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
