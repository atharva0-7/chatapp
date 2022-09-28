abstract class ChatUserEvent {}

class GetChatUserEvent implements ChatUserEvent {
  final String uid;
  GetChatUserEvent(this.uid);
}
