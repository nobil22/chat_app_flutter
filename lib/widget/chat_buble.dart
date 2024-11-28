import 'package:flutter/material.dart';
import 'package:mychat_app/constants.dart';
import 'package:mychat_app/models/message.dart';

class chatbuble extends StatelessWidget {
  const chatbuble({
    super.key,
    required this.message,
  });
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.only(left: 16, top: 32, bottom: 32, right: 32),
        decoration: const BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomRight: Radius.circular(32),
            )),
        child: Text(
          // 'send',
          message.messages,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class chatbuble2 extends StatelessWidget {
  const chatbuble2({
    super.key,
    required this.message,
  });
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.only(left: 16, top: 32, bottom: 32, right: 32),
        decoration: const BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomLeft: Radius.circular(32),
            )),
        child: Text(
          // 'send',
          message.messages,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
