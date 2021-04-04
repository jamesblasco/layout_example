import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:layout/layout.dart';
import 'package:layout_example/utils/slack_example/models/channel_data.dart';
import 'package:layout_example/utils/slack_example/providers/workspace_provider.dart';

import 'package:provider/provider.dart';

class WorkspaceRailNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final worskpaces = context.read<WorkspacesProvider>();
    return Container(
      width: 58,
      height: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Theme.of(context).dividerColor,
          ),
        ),
      ),
      child: ReorderableListView(
        buildDefaultDragHandles: false,
        padding: const EdgeInsets.only(top: 10),
        onReorder: worskpaces.reorderWorkspaces,
        children: [
          for (final worskpace in worskpaces.workspaces)
            WorkspaceItem(
              key: ValueKey('Workspace${worskpace.id}'),
              workspace: worskpace,
            ),
        ],
        scrollDirection: Axis.vertical,
      ),
    );
  }
}

class WorkspaceData {
  final String id;
  final String? logo;
  final String name;
  final String url;

  final List<ChannelData> channels;
  final List<ChannelData> chats;

  WorkspaceData({
    this.logo,
    required this.name,
    required this.id,
    required this.url,
    this.chats = const [],
    this.channels = const [],
  });
}

class WorkspaceItem extends StatefulWidget {
  final WorkspaceData workspace;

  const WorkspaceItem({
    Key? key,
    required this.workspace,
  }) : super(key: key);

  @override
  WorkspaceItemState createState() => WorkspaceItemState();
}

class WorkspaceItemState extends State<WorkspaceItem> {
  bool _hover = false;

  @override
  void initState() {
    super.initState();
  }

  updateHover(bool hover) {
    setState(() => _hover = hover);
  }

  @override
  Widget build(BuildContext context) {
    final bool selected = context.select(
      (WorkspacesProvider w) => w.isSelected(widget.workspace),
    );
    return GestureDetector(
      onTap: () => context.read<WorkspacesProvider>().select(widget.workspace),
      child: AspectRatio(
        aspectRatio: 1,
        child: Stack(
          children: [
            MouseRegion(
              onHover: (_) => updateHover(true),
              onExit: (_) => updateHover(false),
              child: Container(
                padding: const EdgeInsets.all(3),
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: selected
                        ? Colors.white
                        : _hover
                            ? Colors.white.withOpacity(0.2)
                            : Colors.transparent,
                    width: 3,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: widget.workspace.logo == null
                      ? Center(
                          child: Text(
                            widget.workspace.name.substring(0, 1),
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      : Image.network(widget.workspace.logo!),
                ),
              ),
            ),
            AnimatedOpacity(
              opacity: selected ? 0 : 1,
              duration: Duration(milliseconds: 200),
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Align(
                  alignment: Alignment.topRight,
                  child: ClipOval(
                    child: Container(
                      width: 12,
                      height: 12,
                      color: Color(0xFE1D2229),
                      padding: const EdgeInsets.all(3),
                      child: ClipOval(
                        child: Container(
                          width: 12,
                          height: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
