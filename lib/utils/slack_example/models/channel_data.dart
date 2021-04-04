import 'package:flutter/material.dart';
import 'package:layout_example/utils/slack_example/models/user_data.dart';



class ChannelData {
  final String id;
  final String name;
  final String? topic;
  final List<String> users;
  final bool private;

  ChannelData({
    required this.name,
    required this.id,
    this.topic,
    this.users = const [],
    this.private = false,
  });
}

class MockChannelData {
  static final ChannelData general = ChannelData(
    id: 'general',
    name: 'General',
    topic: 'General channel',
    users: [
      MockUsers.jaime.id,
      MockUsers.argel.id,
    ],
  );
  static final ChannelData avisos = ChannelData(
    id: 'avisos',
    name: 'Avisos',
    topic: 'Avisos',
    users: [
      MockUsers.jaime.id,
      MockUsers.argel.id,
    ],
  );
}

class ChannelProvider extends ChangeNotifier {
  final List<ChannelData> channels;

  ChannelProvider(this.channels);

  late ChannelData _selected = channels.first;
  ChannelData get selected => _selected;

  bool isSelected(ChannelData data) => data.id == _selected.id;
  void select(ChannelData data) {
    if (data.id == _selected.id) {
      return;
    }
    _selected = data;
    notifyListeners();
  }
}
