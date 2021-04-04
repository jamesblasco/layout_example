import 'package:flutter/material.dart';
import 'package:layout/layout.dart';
import 'package:layout_example/utils/slack_example/models/channel_data.dart';
import 'package:layout_example/utils/slack_example/providers/chat_messages.dart';
import 'package:provider/provider.dart';

import 'chat_page.dart';

class InfoBar extends StatelessWidget {
  const InfoBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final isMobile = isMobileValue.resolve(context);
    final data = context.read<ChannelData>();
    if (!context.select((ChatProvider chat) => chat.rightSidebar) && !isMobile)
      return Container();
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          border:
              Border(left: BorderSide(color: Theme.of(context).dividerColor))),
      width: 300,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 65,
            child: Row(
              children: [
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Flexible(
                        child: Text('Información',
                            style: Theme.of(context).textTheme.bodyText1),
                      ),
                      Gutter(4),
                      Flexible(
                        child: Text('#${data.name}',
                            style: Theme.of(context).textTheme.caption),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.white, size: 24),
                  onPressed: () {
                    if (isMobile) {
                      return Navigator.of(context).pop();
                    }
                    context.read<ChatProvider>().rightSidebar = false;
                  },
                ),
                SizedBox(width: 15),
              ],
            ),
          ),
          Divider(height: 1),
          Gutter(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AvatarItem(text: 'Añadir', icon: Icons.person_add),
              Gutter(8),
              AvatarItem(text: 'Buscar', icon: Icons.search),
              Gutter(8),
              AvatarItem(text: 'Llamar', icon: Icons.phone),
              Gutter(8),
              AvatarItem(text: 'Más', icon: Icons.menu)
            ],
          ),
          Gutter(),
          Divider(height: 1),
          Gutter(),
          Expanded(
            child: ListView(
              children: [
                ExpansionTile(title: Text('Acerca del Canal')),
                ExpansionTile(title: Text('Miembros')),
                ExpansionTile(title: Text('Accessos directos')),
                ExpansionTile(title: Text('Chinchetas')),
                ExpansionTile(title: Text('Archivos')),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class AvatarItem extends StatelessWidget {
  final String text;
  final IconData icon;

  const AvatarItem({Key? key, required this.text, required this.icon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 24,
          child: Icon(icon),
        ),
        Gutter(8),
        Text(text),
      ],
    );
  }
}
