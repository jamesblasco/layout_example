import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:layout/layout.dart';
import 'package:layout_example/utils/slack_example/models/channel_data.dart';
import 'package:layout_example/utils/slack_example/models/user_data.dart';
import 'package:layout_example/utils/slack_example/providers/chat_messages.dart';
import 'package:provider/provider.dart';

import 'message_tile.dart';

final isMobileValue = LayoutValue.fromBreakpoint(
    xs: true, sm: false, md: false, lg: false, xl: false);

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMobile = isMobileValue.resolve(context);
    final channel = context.watch<ChannelData>();
    final messages = context.watch<ChatProvider>().messages;
    return Column(
      children: [
        Container(
          height: 65,
          child: Row(
            children: [
              if (isMobile)
                GestureDetector(
                  // onTap: () => _rightController.reverse(),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Icon(Icons.arrow_back_ios,
                        color: Colors.white, size: 14),
                  ),
                ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          channel.private
                              ? Icon(Icons.lock, color: Colors.white, size: 14)
                              : Text('\u0023',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600)),
                          SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              channel.name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(
                            Icons.person_outline,
                            color: Color(0xFFC7C8CA),
                            size: 18,
                          ),
                          SizedBox(width: 4),
                          Text('${channel.users.length}',
                              style: TextStyle(color: Color(0xFFC7C8CA))),
                          SizedBox(width: 8),
                          Container(
                              height: 12, width: 1, color: Color(0x80C7C8CA)),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(channel.topic ?? 'Add a topic',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.6),
                                    fontSize: 12),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
              if (isMobile)
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Icon(
                    Icons.search,
                    color: Colors.white.withOpacity(0.6),
                    size: 20,
                  ),
                ),
              IconButton(
                  onPressed: () {
                    final chat = context.read<ChatProvider>();
                    chat.rightSidebar = !chat.rightSidebar;
                    Scaffold.of(context).openEndDrawer();
                  },
                  color: Colors.white.withOpacity(0.6),
                  icon: Icon(
                    Icons.info_outline,
                    size: 20,
                  )),
              SizedBox(width: 20),
            ],
          ),
        ),
        Divider(height: 1),
        Expanded(
          child: ListView.builder(
            reverse: true,
            physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 10),
            itemBuilder: (context, index) {
              final chat = messages[index];
              var sameUser = index + 1 <= messages.length - 1 &&
                  messages[index + 1].user.id == chat.user.id;
              return MessageTile(chat: chat, sameUser: sameUser);
            },
            itemCount: messages.length,
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(minHeight: 100),
          child: Container(
            margin: const EdgeInsets.only(left: 20, right: 20, bottom: 25),
            decoration: BoxDecoration(
              color: Color(0xFF232529),
              border: Border.all(color: Color(0xFF565856), width: 1),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    //controller: _textController,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.6), fontSize: 14),
                    maxLines: null,
                    // onChanged: (text) => setState(() {}),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Message #${channel.name}',
                      hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.4), fontSize: 14),
                    ),
                  ),
                ),
                Container(
                  height: 30,
                  child: Row(
                    children: [
                      SizedBox(width: 8),
                      Icon(Icons.whatshot, color: Color(0xFFC7C8CA), size: 18),
                      SizedBox(width: 8),
                      Container(width: 1, height: 25, color: Color(0x40C7C8CA)),
                      SizedBox(width: 8),
                      Icon(Icons.format_bold,
                          color: Colors.grey[700], size: 18),
                      SizedBox(width: 8),
                      RotatedBox(
                          quarterTurns: 1,
                          child: Icon(Icons.link,
                              color: Colors.grey[700], size: 18)),
                      SizedBox(width: 8),
                      Icon(Icons.format_list_numbered,
                          color: Colors.grey[700], size: 18),
                      SizedBox(width: 8),
                      Icon(Icons.format_indent_increase,
                          color: Colors.grey[700], size: 18),
                      Expanded(child: SizedBox()),
                      Icon(Icons.mood, color: Colors.grey[300], size: 18),
                      SizedBox(width: 8),
                      Icon(Icons.attach_file,
                          color: Colors.grey[300], size: 18),
                      SizedBox(width: 8),
                      GestureDetector(
                        /*   onTap: _textController.text.isNotEmpty
                            ? () {
                                setState(() {
                                  _workspaces[_currentIndex]
                                      .first
                                      .channels[_workspaces[_currentIndex]
                                          .first
                                          .currentChannel]
                                      .chats
                                      .add(Chat()
                                        ..user = Utils.userLogged
                                        ..text = _textController.text
                                        ..timestamp = DateTime.now()
                                            .millisecondsSinceEpoch);
                                  _textController.clear();
                                });
                              }
                            : null, */
                        child: Container(
                          height: 30,
                          width: 30,
                          /*   decoration: BoxDecoration(
                              color: _textController.text.isNotEmpty
                                  ? Color(0xFF007A5A)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(4)), */
                          child: Center(
                              child: Icon(Icons.send,
                                  color: Color(0xFFC7C8CA), size: 16)),
                        ),
                      ),
                      SizedBox(width: 5),
                    ],
                  ),
                ),
                SizedBox(height: 4),
              ],
            ),
          ),
        )
      ],
    );
  }
}
