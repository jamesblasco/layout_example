import 'package:flutter/material.dart';
import 'package:layout/layout.dart';

import 'package:layout_example/utils/layout_indicator_bar.dart';
import 'package:layout_example/utils/slack_example/widgets/channel_bar.dart';
import 'package:layout_example/utils/slack_example/widgets/providers.dart';

import 'utils/slack_example/slack_example.dart';



class DashboardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Layout(
      child: SlackController(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark().copyWith(
              backgroundColor: Color(0xFF1D2229),
              scaffoldBackgroundColor: Color(0xFF1D2229)),
          builder: (context, child) {
            Widget widget = child!;
            widget = Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: widget),
                LayoutBar(),
              ],
            );

            return widget;
          },
          home: SlackPage(),
        ),
      ),
    );
  }
}

final size = LayoutValue<Size>.fromBreakpoint(xs: Size(0, 0), md: Size(30, 30));

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMobile = isMobileLayout.resolve(context);

    return DashboardLayout(
      body: Builder(
        builder: (c) => Scaffold(
          appBar: AppBar(
            title: Text('App Bar'),
            leading: isMobile
                ? IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(c).openDrawer();
                    },
                  )
                : null,
            actions: [
              if (isMobile)
                IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(c).openEndDrawer();
                  },
                )
            ],
          ),
        ),
      ),
      topBar: AppBar(
        title: Text('Top Bar'),
      ),
      leftSidebar: Container(
        height: double.infinity,
        width: 200,
        color: Colors.red,
      ),
      rightSidebar:  Container(
        height: double.infinity,
        width: 200,
        color: Colors.blue,
      ),
      navigationTrail: NavigationRail(
        destinations: [
          NavigationRailDestination(
            icon: Icon(Icons.mail),
            label: Text('mail'),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.mail),
            label: Text('mail'),
          )
        ],
        onDestinationSelected: (value) {},
        selectedIndex: 0,
      ),
      bottomBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: 'Mail',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: 'Mail',
          )
        ],
      ),
    );
  }
}

class SlackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DashboardLayout(
        body: ChatPage(),
        topBar: WindowBar(),
        leftSidebar: ChannelBar(),
        rightSidebar: InfoBar(),
        navigationTrail: WorkspaceRailNavigation(),
        bottomBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.mail),
              label: 'Mail',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.mail),
              label: 'Mail',
            )
          ],
        ),
      ),
    );
  }
}

final isMobileLayout = LayoutValue.fromBreakpoint(
  xs: true,
  sm: false,
  md: false,
  lg: false,
  xl: false,
);

final rightSidebarAlwaysVisible = LayoutValue.fromBreakpoint(
  xs: false,
  sm: false,
  md: true,
  lg: true,
  xl: true,
);

class DashboardLayout extends StatelessWidget {
  final Widget body;
  final Widget leftSidebar;
  final Widget navigationTrail;
  final Widget rightSidebar;
  final Widget bottomBar;
  final PreferredSizeWidget topBar;

  const DashboardLayout({
    Key? key,
    required this.navigationTrail,
    required this.body,
    required this.leftSidebar,
    required this.rightSidebar,
    required this.bottomBar,
    required this.topBar,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final isMobile = isMobileLayout.resolve(context);
    return Column(
      children: [
        if (!isMobile)
          SizedBox.fromSize(size: topBar.preferredSize, child: topBar),
        Expanded(
          child: Row(
            children: [
              if (!isMobile) navigationTrail,
              if (!isMobile) leftSidebar,
              Expanded(
                child: Scaffold(
                  drawer: isMobile ? leftSidebar : null,
                  endDrawer: !rightSidebarAlwaysVisible.resolve(context)
                      ? rightSidebar
                      : null,
                  body: body,
                  bottomNavigationBar: isMobile ? bottomBar : null,
                ),
              ),
              if (rightSidebarAlwaysVisible.resolve(context)) rightSidebar,
            ],
          ),
        ),
      ],
    );
  }
}
