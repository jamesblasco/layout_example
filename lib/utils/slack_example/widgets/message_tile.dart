import 'package:flutter/material.dart';
import 'package:layout_example/utils/slack_example/providers/chat_messages.dart';

import 'chat_page.dart';

class MessageTile extends StatefulWidget {
  final Message chat;
  final bool sameUser;

  const MessageTile({Key? key, required this.chat, required this.sameUser})
      : super(key: key);

  @override
  _MessageTileState createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  var _hover = false;
  var text = '';
  var url = '';

  @override
  Widget build(BuildContext context) {
    text = widget.chat.text;

    return MouseRegion(
      onHover: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            color: _hover ? Colors.white.withOpacity(0.05) : Colors.transparent,
            child: Padding(
              padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: widget.sameUser ? 5 : 10,
                  bottom: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 /*  if (!widget.sameUser)
                    Container(
                      width: 40,
                      height: 40,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(
                          widget.chat.user.avatar,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ), */
                  SizedBox(width: 8 + (widget.sameUser ? 40.0 : 0.0)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!widget.sameUser)
                          Row(
                            children: [
                              Text(widget.chat.user.name,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(width: 5),
                             /*  if (widget.chat.user.status != null)
                                Text(widget.chat.user.status,
                                    style: TextStyle(
                                        color: Colors.white, height: 1.2),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis), */
                            ],
                          ),
                        if (!widget.sameUser) SizedBox(height: 6),
                        if (text.isNotEmpty)
                          Text(text, style: TextStyle(color: Colors.grey[400])),
                        if (url.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5),
                                Text(
                                  url.split('/')[url.split('/').length - 1],
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey[700]),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  constraints: BoxConstraints(maxWidth: 400),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.network(url),
                                  ),
                                ),
                              ],
                            ),
                          )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_hover)
            Positioned(
              top: 0,
              right: 20,
              child: Transform(
                transform: Matrix4.identity()..translate(0, -15),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF232529),
                        borderRadius: BorderRadius.circular(6),
                        border:
                            Border.all(color: Colors.grey[700]!, width: 0.5),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 4),
                      child: Material(
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            SizedBox(width: 5),
                            InkWell(
                              onTap: () {},
                              onHover: (_) {},
                              child: Tooltip(
                                message: 'Add reaction',
                                verticalOffset: -55,
                                textStyle: TextStyle(
                                    fontSize: 12, color: Colors.white),
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: Colors.grey[700]!, width: 0.5)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 4),
                                  child: Icon(Icons.insert_emoticon,
                                      color: Colors.grey, size: 18),
                                ),
                              ),
                            ),
                            SizedBox(width: 6),
                            InkWell(
                              onTap: () {},
                              onHover: (_) {},
                              child: Tooltip(
                                message: 'Start a thread',
                                verticalOffset: -55,
                                textStyle: TextStyle(
                                    fontSize: 12, color: Colors.white),
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: Colors.grey[700]!, width: 0.5)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 4),
                                  child: Icon(Icons.chat,
                                      color: Colors.grey, size: 18),
                                ),
                              ),
                            ),
                            SizedBox(width: 6),
                            InkWell(
                              onTap: () {},
                              onHover: (_) {},
                              child: Tooltip(
                                message: 'Share a message...',
                                verticalOffset: -55,
                                textStyle: TextStyle(
                                    fontSize: 12, color: Colors.white),
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: Colors.grey[700]!, width: 0.5)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 4),
                                  child: Icon(Icons.forward,
                                      color: Colors.grey, size: 18),
                                ),
                              ),
                            ),
                            SizedBox(width: 6),
                            InkWell(
                              onTap: () {},
                              onHover: (_) {},
                              child: Tooltip(
                                message: 'Save',
                                verticalOffset: -55,
                                textStyle: TextStyle(
                                    fontSize: 12, color: Colors.white),
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: Colors.grey[700]!, width: 0.5)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 4),
                                  child: Icon(Icons.bookmark_border,
                                      color: Colors.grey, size: 18),
                                ),
                              ),
                            ),
                            SizedBox(width: 4),
                            InkWell(
                              onTap: () {},
                              onHover: (_) {},
                              child: Tooltip(
                                message: 'More actions',
                                verticalOffset: -55,
                                textStyle: TextStyle(
                                    fontSize: 12, color: Colors.white),
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: Colors.grey[700]!, width: 0.5)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 4),
                                  child: Icon(Icons.more_vert,
                                      color: Colors.grey, size: 18),
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
