import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:mychat_app/constants.dart';
import 'package:mychat_app/models/message.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);
        List<Message> messagelist=[];
  ChatCubit() : super(ChatInitial());
  void sendMessages({required String message, required String email}) {
    messages.add({
      kMessage: message,
      kCreatedAt: DateTime.now(),
      'id': email,
    });
  }

  void getMessages() {
    messages.orderBy(kCreatedAt, descending: true).snapshots().listen((event) {
    messagelist.clear();
      for (var doc in event.docs) {
        messagelist.add(Message.fromJson(doc));
      }
      emit(ChatSuccess(messages:messagelist));
    });
  }
}
