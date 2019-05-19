//Dart code for socket.io

//Connection
IO.Socket socket = IO.io("ws://localhost:3000");


//Emitters

///
/// 1. add provider
///


// 1.1: 18/05/2019 22:45:23
socket.emit("add provider", 
   {
      "userName": "Everton",
      "id": "5ccc976647fe3a382f4d0f65"
   }
);

///
/// 2. accept service
///


// 2.1: 18/05/2019 23:29:46
socket.emit("accept service", 
   {
      "clientId": "k0PmXQ1hgNem79KAAAAB"
   }
);

///
/// 3. deny service
///


// 3.1: 18/05/2019 23:30:02
socket.emit("deny service", 
   {
      "clientId": "k0PmXQ1hgNem79KAAAAB"
   }
);

///
/// 4. message
///


// 4.1: 18/05/2019 23:32:23
socket.emit("message", 
   {
      "userId": "k0PmXQ1hgNem79KAAAAB",
      "message": "fala seu chifrudo"
   }
);

// Listeners

socket.on("connect", (_) { print("connect"); });

socket.on("connected", (data) => print(data));

socket.on("new service", (data) => print(data));

socket.on("cancel service", (data) => print(data));

socket.on("message", (data) => print(data));

socket.on("disconnect", (_) => print("disconnect"));

// for more information: https://github.com/rikulo/socket.io-client-dart
// how to pass query as options: https://github.com/rikulo/socket.io-client-dart/blob/master/lib/socket_io_client.dart



