import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

const String SERVER_ADDRESS = "ws://172.16.0.6:3000";

class WSocket {
  WebSocketChannel channel;
  ObserverList<Function> _listeners = new ObserverList<Function>();
  bool _isOn = false;
  
  connect() async {
    reset();

    try {
      channel = new IOWebSocketChannel.connect(SERVER_ADDRESS, headers: {
        'Content-Type': 'application/json',
      });
    } catch(e) {
      print('error in socket init $e');
    }
  }

  reset() {
    if (channel != null) {
      if (channel.sink != null) {
        channel.sink.close();
        _isOn = false;
      }
    }
  }

  addListener(Function callback) {
    _listeners.add(callback);
  }

  removeListener(Function callback) {
    _listeners.remove(callback);
  }

  send(String message) {
    if (channel != null) {
      if (channel.sink != null) {
        channel.sink.add(message);
        print('enviado ${channel.stream}');
      }
    }
  }

  _onReceptionMessageFromServer(message) {
    _isOn = true;
    _listeners.forEach((Function callback) {
      callback(message);
    });
  }

}

/*
  //Emitters
  connectProvider (Map user, Function callback) async {
    if (socket != null) {
      socket.sendMessage("add provider", 
        json.encode({
          "userName": user["name"],
          "id": user["id"],
        }),
          callback,
      );
    }
  }

  acceptService (String client, Function callback) async {
    if (socket != null) {
      socket.sendMessage("accept service", 
        json.encode({
          "clientId": client
        }),
        callback,
      );
    }
  }

  denyService (String client, Function callback) async {
    if (socket != null) {
      socket.sendMessage("deny service", 
        json.encode({
            "clientId": client
        }),
        callback,
      );
    }
  }

  message (String destinatary, String message, Function callback) async {
    if (socket != null) {
      socket.sendMessage("message", 
        json.encode({
          "userId": destinatary,
          "message": message
        }),
        callback,
      );
    }
  }

  // Listeners
 

  newService (Function callback) async {
    if (socket != null) {
      socket.subscribe("new service", (data) {
        print(data);
        callback(data);
      });
    }
  }

  cancelService (Function callback) async {
    if (socket != null) {
      socket.subscribe("cancel service", (data) {
        print(data);
        callback(data);
      });
    }
  }

  receiveMessage (Function callback) async {
    if (socket != null) {
      socket.subscribe("message", (data) {
        print(data);
        callback(data);
      });
    }
  }

  destroySocket() async { 
    if (socket != null) { 
      SocketIOManager().destroySocket(socket); 
    } 
  }
}
*/
