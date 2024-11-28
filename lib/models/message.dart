import 'package:mychat_app/constants.dart';

class Message {
  final String messages;
final String id;
  Message( this.messages, this.id);
  factory Message.fromJson( jesonData) {
    return Message(jesonData[kMessage],jesonData['id']);
  }
}