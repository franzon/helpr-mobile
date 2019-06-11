import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

const String SERVER_ADDRESS = "ws://10.1.4.96:3000";

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
 * 
 * 
*/

// Use example

/*
  class Page extends StatefulWidget {
    _PageState createState() => _PageState();
  }

  class _PageState extends State<Page> {
    WSocket socket;
    String name = "nome";
    String id = "id"

    void initState() {
      super.initState();
      initPlatformState();
    }

    Future<Widget> initPlatformState() async {
      try {
        socket = new WSocket();

        socket.connect();
        
        final String addClient = json.encode({
          "action": "add client",
          "user": {
            "userName": name,
            "userId": id,
          }
        });

        socket.send(addClient);
      }

      Widget receiveProviders(String message) {
        Map<String, dynamic> data = json.decode(message);

        if (data['listener'] == 'providers') {
          providers = [];

          List<dynamic> provids = data['providers'];
          provids.forEach((value) {
            providers.add(value);
          });
        }

        if (providers.length > 0) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: providers.length,
            itemBuilder: (BuildContext context, int index) {
              return Text(providers[index]['userName']);
            }
          );
        }
        else {
          return Container(
            child: Text(
              'Nenhum provider connectado no momento!'
            ),
          );
        }
      }

      Widget providersList(WebSocketChannel channel) {
        return StreamBuilder(
          stream: channel.stream,
          builder: (BuilderContext context, snapshot) {
            if (snapshot.hasData) {
              return receiveProviders(snapshot.data);
            }
            return Container();
          },
        );
      }

      Widget build(BuildContext context) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: providersList(socket.channel),
                ),
              ],
            ),
          ),
        );
      }
    }
  }
*/
