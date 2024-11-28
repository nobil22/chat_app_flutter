import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mychat_app/constants.dart';
import 'package:mychat_app/models/message.dart';
import 'package:mychat_app/widget/chat_buble.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  static String id = 'chat page';
  TextEditingController controller = TextEditingController();
  final _scroller = ScrollController();

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // print(snapshot.data!.docs[0]['messages']);
          List<Message> messagelist = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagelist.add(Message.fromJson(snapshot.data!.docs[i]));
          }
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kPrimaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    kLogo,
                    height: 50,
                  ),
                  const Text('Chat',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                ],
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _scroller,
                    itemCount: messagelist.length,
                    itemBuilder: (context, index) {
                      return messagelist[index].id == email
                          ? chatbuble(
                              message: messagelist[index],
                            )
                          : chatbuble2(message: messagelist[index]);
                      //   message: messagelist[index],
                      // );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      messages.add({
                        kMessage: data,
                        kCreatedAt: DateTime.now(),
                        'id': email,
                      });
                      controller.clear();
                      _scroller.animateTo(
                        0,
                        duration: Duration(seconds: 1),
                        curve: Curves.easeIn,
                      );
                    },
                    decoration: InputDecoration(
                        hintText: 'Send Message',
                        suffix: const Icon(Icons.send),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: kPrimaryColor,
                            ),
                            borderRadius: BorderRadius.circular(16))),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Text('Loading...');
        }
      },
    );
  }
}
