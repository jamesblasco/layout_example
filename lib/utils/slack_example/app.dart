import 'package:flutter/material.dart';
import 'package:layout/layout.dart';
import 'package:layout_example/utils/slack_example/widgets/chat_page.dart';
import 'package:layout_example/utils/slack_example/widgets/rail_navigation.dart';

import 'widgets/channel_bar.dart';
import 'widgets/info_bar.dart';
import 'widgets/providers.dart';
import 'widgets/windows_bar.dart';

class _DashboardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Layout(
      child: SlackController(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark().copyWith(
              backgroundColor: Color(0xFF1D2229),
              scaffoldBackgroundColor: Color(0xFF1D2229)),
          home: _DashboardPage(),
        ),
      ),
    );
  }
}

class _DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _DashboardLayout(
      leftSidebar: ChannelBar(),
      rightSidebar: InfoBar(),
      body: ChatPage(),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.mail), label: 'Mail'),
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat')
      ]),
      topBar: WindowBar(),
      railNavigation: WorkspaceRailNavigation(),
    );
  }
}

class _DashboardLayout extends StatelessWidget {
  final Widget railNavigation;
  final Widget leftSidebar;
  final Widget rightSidebar;
  final Widget bottomNavigationBar;
  final Widget body;
  final PreferredSizeWidget topBar;

  const _DashboardLayout({
    Key? key,
    required this.leftSidebar,
    required this.rightSidebar,
    required this.body,
    required this.bottomNavigationBar,
    required this.topBar,
    required this.railNavigation,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final isMobile = isMobileValue.resolve(context);
    final medium = context.breakpoint >= LayoutBreakpoint.md;
    return Scaffold(
      endDrawer: isMobile ? rightSidebar : null,
      drawer: !medium ? leftSidebar : null,
      appBar: context.breakpoint > LayoutBreakpoint.xs ? topBar : null,
      bottomNavigationBar: context.breakpoint == LayoutBreakpoint.xs
          ? bottomNavigationBar
          : null,
      body: Row(
        children: [
          if (context.breakpoint > LayoutBreakpoint.xs) railNavigation,
          if (medium) leftSidebar,
          Expanded(
            child: Layout(
              child: body,
            ),
          ),
          if (!isMobile) rightSidebar,
        ],
      ),
    );
  }
}
