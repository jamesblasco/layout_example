import 'package:flutter/material.dart';
import 'package:layout_example/utils/slack_example/models/channel_data.dart';
import 'package:layout_example/utils/slack_example/providers/chat_messages.dart';
import 'package:layout_example/utils/slack_example/providers/workspace_provider.dart';
import 'package:layout_example/utils/slack_example/widgets/rail_navigation.dart';
import 'package:provider/provider.dart';

import 'chat_page.dart';

class SlackController extends StatelessWidget {
  final Widget child;

  const SlackController({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (c) => WorkspacesProvider()),
        ProxyProvider<WorkspacesProvider, WorkspaceData>(
          update: (context, value, previous) {
            return context.read<WorkspacesProvider>().selected;
          },
        ),
        ChangeNotifierProxyProvider<WorkspaceData, ChannelProvider>(
          create: (context) =>
              ChannelProvider(context.read<WorkspaceData>().channels),
          update: (context, value, previous) {
            return ChannelProvider(context.read<WorkspaceData>().channels);
          },
        ),
        ProxyProvider<ChannelProvider, ChannelData>(
          update: (context, value, previous) {
            return context.read<ChannelProvider>().selected;
          },
        ),
        ChangeNotifierProxyProvider<ChannelData, ChatProvider>(
          create: (context) => ChatProvider(context.read<ChannelData>().id),
          update: (context, value, previous) {
            return ChatProvider(context.read<ChannelData>().id);
          },
        ),
      ],
      child: child,
    );
  }
}
