import 'package:flutter/material.dart';
import 'package:layout/layout.dart';
import 'package:layout_example/utils/slack_example/widgets/rail_navigation.dart';
import 'package:provider/provider.dart';

class ChannelBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final worspace = context.read<WorkspaceData>();
    return Container(
      width: 260,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      height: double.infinity,
      child: Column(
        children: [
          Container(
            height: 65,
            width: 260,
            child: Row(
              children: [
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(worspace.name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600)),
                          SizedBox(width: 4),
                          Icon(Icons.keyboard_arrow_down,
                              color: Colors.white, size: 14),
                        ],
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Icon(Icons.edit, color: Color(0xFF1C2128), size: 18),
                ),
                SizedBox(width: 15),
              ],
            ),
          ),
          Divider(height: 1),
          Expanded(
            child: ListView(
              children: [
                Gutter(12),
                ...[
                  ChannelTile(
                      icon: Icons.subject, text: 'Hilos de conversación'),
                  ChannelTile(icon: Icons.drafts, text: 'Borradores'),
                  ChannelTile(
                      icon: Icons.drafts, text: 'Menciones y reacciones'),
                  ChannelTile(icon: Icons.menu, text: 'Más'),
                  ChannelTile(icon: Icons.menu, text: 'Mentions & Reactions'),
                ],
                Divider(),
                ChannelTile(icon: Icons.arrow_drop_down, text: 'Canales'),
                for (final channel in worspace.channels)
                  ChannelTile(
                    icon: Icons.tag_faces,
                    text: channel.name,
                    leadingPadding: 32,
                  ),
                Gutter(),
                ChannelTile(icon: Icons.arrow_drop_down, text: 'Mensajes'),
                for (final chat in worspace.chats)
                  ChannelTile(
                    icon: Icons.tag_faces,
                    text: chat.name,
                    leadingPadding: 32,
                  ),
                Gutter(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ChannelTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final GestureTapCallback? onTap;
  final double leadingPadding;

  const ChannelTile(
      {Key? key,
      required this.icon,
      required this.text,
      this.onTap,
      this.leadingPadding = 12})
      : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () => {},
      child: SizedBox(
        height: 30,
        child: Row(
          children: [
            Gutter(leadingPadding),
            Container(
              height: 30,
              child: Icon(icon, color: Color(0xFFC7C8CA), size: 15),
            ),
            SizedBox(width: 10),
            Container(
              child: Text(text,
                  style: TextStyle(color: Color(0xFFC7C8CA), fontSize: 14)),
            ),
          ],
        ),
      ),
    );
  }
}
