import 'package:flutter/widgets.dart';
import 'package:layout_example/utils/slack_example/models/user_data.dart';

Map<String, List<Message>> _cacheMessages = {};

class ChatProvider extends ChangeNotifier {
  final String id;

  ChatProvider(this.id);

  bool _rightSidebar = false;
  bool get rightSidebar => _rightSidebar;
  set rightSidebar(bool value) {
    if (value != _rightSidebar) {
      _rightSidebar = value;
      notifyListeners();
    }
  }

  late final List<Message> messages = _cacheMessages.putIfAbsent(id, () => []);

  void addMessage(Message message) {
    messages.add(message);
  }
}

class Message {
  final String text;
  final DateTime date;
  final UserData user;

  Message(this.text, this.date, this.user);
}
