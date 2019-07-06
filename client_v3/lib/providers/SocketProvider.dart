import 'package:client_v3/constants/apiUrl.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:web_socket_channel/io.dart';

class SocketProvider {
  final channel = IOWebSocketChannel.connect(socketUrl);
  final data = BehaviorSubject<dynamic>.seeded(null);
  bool sentAdd = false;

  SocketProvider() {
    channel.stream.listen((d) {
      debugPrint("[message]" + d.toString());
      data.add(d);
    });
  }
}
