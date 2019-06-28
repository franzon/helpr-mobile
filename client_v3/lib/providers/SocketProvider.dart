import 'package:client_v3/constants/apiUrl.dart';
import 'package:web_socket_channel/io.dart';

class SocketProvider {
  final channel = IOWebSocketChannel.connect(socketUrl);
}
