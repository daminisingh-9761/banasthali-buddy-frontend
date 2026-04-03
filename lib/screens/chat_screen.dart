import 'package:flutter/material.dart';
import '../services/chat_service.dart';
import 'booking_success_screen.dart';
import 'dart:async';

class ChatScreen extends StatefulWidget {

  final String bookingId;

  const ChatScreen({
    super.key,
    required this.bookingId
  });

  @override
  State<ChatScreen> createState()
  => _ChatScreenState();
}


class _ChatScreenState
    extends State<ChatScreen> {

  List messages = [];

  TextEditingController controller
  = TextEditingController();

  ScrollController scrollController =
  ScrollController();

  Timer? timer;


  loadMessages() async {

    print("CHAT API CALLING...");
    print("BOOKING ID: ${widget.bookingId}");

    var data =
    await ChatService.getMessages(
        widget.bookingId
    );

    print("CHAT RESPONSE:");
    print(data);

    setState(() {

      messages = data;

    });

    Future.delayed(

      const Duration(milliseconds: 200),

          (){

        if(scrollController.hasClients){

          scrollController.jumpTo(

              scrollController.position.maxScrollExtent

          );

        }

      },

    );

  }


  send() async {

    if(controller.text.isEmpty) return;

    print("SENDING MESSAGE...");
    print(controller.text);

    await ChatService.sendMessage(

        widget.bookingId,
        "user",
        controller.text

    );

    print("MESSAGE SENT");

    controller.clear();

    loadMessages();

  }


  @override
  void initState() {

    super.initState();

    loadMessages();

    timer = Timer.periodic(

      const Duration(seconds: 3),

          (t) => loadMessages(),

    );
  }


  @override
  void dispose() {

    timer?.cancel();

    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      const Color(0xFFEAF3F1),

      appBar: AppBar(

        backgroundColor:
        const Color(0xFF2F6F6D),

        title:
        const Text(

            "Chat with Driver",

            style: TextStyle(
                color: Colors.white
            )
        ),

        iconTheme:
        const IconThemeData(
            color: Colors.white
        ),

      ),

      /// 🔥 ONLY CHANGE BELOW (STACK ADDED)
      body: Stack(
        children: [

          /// 🔹 BACKGROUND IMAGE
          Positioned.fill(
            child: Image.asset(
              "assets/images/route.jpeg",
              fit: BoxFit.cover,
            ),
          ),

          /// 🔹 ORIGINAL CONTENT (UNCHANGED)
          Column(

            children: [

              Expanded(

                child: ListView.builder(

                  controller: scrollController,

                  itemCount:
                  messages.length,

                  itemBuilder:

                      (context,index){

                    var msg =
                    messages[index];

                    bool isMe =

                        msg["senderId"]
                            ==
                            "user";


                    return Align(

                      alignment:

                      isMe
                          ?

                      Alignment
                          .centerRight

                          :

                      Alignment
                          .centerLeft,


                      child: Container(

                        margin:
                        const EdgeInsets
                            .symmetric(
                            vertical: 6,
                            horizontal: 10),

                        padding:
                        const EdgeInsets
                            .symmetric(
                            vertical: 10,
                            horizontal: 14),


                        decoration:
                        BoxDecoration(

                          color:

                          isMe
                              ?

                          const Color(0xFF2F6F6D)

                              :

                          Colors.white,


                          borderRadius:

                          BorderRadius
                              .circular(14),

                          boxShadow: [

                            BoxShadow(

                                color:
                                Colors.black12,

                                blurRadius: 3

                            )

                          ],

                        ),


                        child:

                        Column(

                          crossAxisAlignment:
                          CrossAxisAlignment.start,

                          children: [

                            Text(

                              msg["message"],

                              style: TextStyle(

                                color:
                                isMe
                                    ?

                                Colors.white
                                    :

                                Colors.black87,

                                fontSize: 15,

                              ),

                            ),

                            const SizedBox(height: 4),

                            Text(

                              msg["timestamp"]
                                  .toString()
                                  .substring(11,16),

                              style: TextStyle(

                                fontSize: 11,

                                color:
                                isMe
                                    ?

                                Colors.white70
                                    :

                                Colors.grey,

                              ),

                            )

                          ],

                        ),

                      ),

                    );

                  },
                ),
              ),



              Padding(

                padding:
                const EdgeInsets.all(8),

                child: Row(

                  children: [

                    Expanded(

                      child: TextField(

                        controller:
                        controller,

                        decoration:

                        InputDecoration(

                          hintText:
                          "Type message",

                          filled: true,

                          fillColor:
                          Colors.white,

                          contentPadding:
                          const EdgeInsets
                              .symmetric(
                              horizontal: 16),

                          border:
                          OutlineInputBorder(

                            borderRadius:
                            BorderRadius.circular(30),

                            borderSide:
                            BorderSide.none,

                          ),

                        ),

                      ),

                    ),

                    const SizedBox(width: 6),

                    CircleAvatar(

                      backgroundColor:
                      const Color(0xFF2F6F6D),

                      child:

                      IconButton(

                        icon:
                        const Icon(
                            Icons.send,
                            color: Colors.white),

                        onPressed: send,

                      ),

                    )

                  ],

                ),

              ),



              ElevatedButton(

                style: ElevatedButton.styleFrom(

                  backgroundColor:
                  const Color(0xFF2F6F6D),

                ),

                child:

                const Text(
                    "Complete Booking"
                ),

                onPressed: () {

                  Navigator.pushReplacement(

                    context,

                    MaterialPageRoute(

                      builder:

                          (_)

                      =>

                      const BookingSuccessScreen(),

                    ),
                  );
                },
              ),

              const SizedBox(height: 10)

            ],
          ),
        ],
      ),
    );
  }
}