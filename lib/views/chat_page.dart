import 'package:flutter/material.dart';
import 'package:flutter_app/models/msg.dart';
import 'package:flutter_app/models/user.dart';
import 'package:flutter_app/services/routeServices.dart';
/* import 'package:flutter_app/views/my_profile.dart';
import 'package:flutter_app/views/result_routes.dart';
import 'package:flutter_app/views/route_list_page.dart'; */
import 'package:web_date_picker/web_date_picker.dart';
import '../models/route.dart';
import '../widgets/drawer.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  IO.Socket? socket;
  List<MsgModel> listMsg = [];

  TextEditingController _msgController = TextEditingController();
  @override
  void initState() {
    super.initState();
    connect();
  }

  void connect() {
    socket = IO.io("http://localhost:3000", <String, dynamic>{
      "transports": ["websockets"],
      "autoConnect": false,
    });
    socket!.connect();
    socket!.onConnect((_) {});
  }

  void sendMsg(String msg, String senderName) {
    socket!.emit('sendMsg', {
      "type": "ownMsg",
      "msg": msg,
      "senderName": senderName,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4cbfa6),
        title: const Text("Route chat"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _msgController,
                    decoration: const InputDecoration(
                      hintText: "Type here",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(
                          width: 2,
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          name = prefs.getString("name");
                          sendMsg(_msgController.text, name);
                        },
                        icon: const Icon(
                          Icons.send,
                          color: Color(0xFF4cbfa6),
                          size: 26,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
