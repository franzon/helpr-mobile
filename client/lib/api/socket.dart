//Dart code for socket.io

//Connection
IO.Socket socket = IO.io("ws://localhost:3000");


//Emitters

///
/// 1. add client
///


// 1.1: 18/05/2019 22:13:14
socket.emit("add client", 
   {
      "userName": "Everton",
      "id": "5ccc976647fe3a382f4d0f65"
   }
);

///
/// 2. new service
///


// 2.1: 18/05/2019 23:27:52
socket.emit("new service", 
   {
      "providerId": "Gg5RvsJzfBO-L3R4AAAA"
   }
);

///
/// 3. cancel service
///


// 3.1: 18/05/2019 23:28:07
socket.emit("cancel service", 
   {
      "providerId": "Gg5RvsJzfBO-L3R4AAAA"
   }
);

///
/// 4. message
///


// 4.1: 18/05/2019 23:31:15
socket.emit("message", 
   {
      "userId": "Gg5RvsJzfBO-L3R4AAAA",
      "message": "fala seu corno manso"
   }
);

// Listeners

socket.on("connect", (_) { print("connect"); });

socket.on("connected", (data) => print(data));

socket.on("providers", (data) => print(data));

socket.on("confirm service", (data) => print(data));

socket.on("deny service", (data) => print(data));

socket.on("message", (data) => print(data));

socket.on("disconnect", (_) => print("disconnect"));

// for more information: https://github.com/rikulo/socket.io-client-dart
// how to pass query as options: https://github.com/rikulo/socket.io-client-dart/blob/master/lib/socket_io_client.dart



