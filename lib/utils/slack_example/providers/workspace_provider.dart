
import 'package:flutter/cupertino.dart';
import 'package:layout_example/utils/slack_example/models/channel_data.dart';
import 'package:layout_example/utils/slack_example/widgets/rail_navigation.dart';

class WorkspacesProvider extends ChangeNotifier {
  List<WorkspaceData> _workspaces = [
    WorkspaceData(
      id: 'flutter_es',
      name: 'Flutter ES',
      url: 'flutter_es.slack.com',
      channels: [MockChannelData.avisos, MockChannelData.general],
      chats: [MockChannelData.avisos, MockChannelData.general],
    ),
    WorkspaceData(
      id: 'flutteristas',
      name: 'Flutteristas',
      url: 'flutteristas.slack.com',
      channels: [MockChannelData.avisos, MockChannelData.general],
      chats: [MockChannelData.avisos, MockChannelData.general],
    ),
    WorkspaceData(
      id: 'flutterstudygroup',
      name: 'Flutter Study Group',
      url: 'flutterstudygroup.slack.com',
      channels: [MockChannelData.avisos, MockChannelData.general],
      chats: [MockChannelData.avisos, MockChannelData.general],
    ),
  ];

  List<WorkspaceData> get workspaces => _workspaces.toList();

  late WorkspaceData _selected = _workspaces.first;
  WorkspaceData get selected => _selected;

  bool isSelected(WorkspaceData data) => data.id == _selected.id;
  void select(WorkspaceData data) {
    if (data.id == _selected.id) {
      return;
    }
    _selected = data;
    notifyListeners();
  }

  void reorderWorkspaces(int oldIndex, int newIndex) {
    if (newIndex < _workspaces.length) {
      final item = _workspaces.removeAt(newIndex);
      _workspaces.insert(oldIndex, item);
      notifyListeners();
    }
  }
}
