import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class SocketController extends GetxController {
  SocketController();
  IO.Socket? socket;
  @override
  void onInit() async {
    initializeSocket();
    super.onInit();
  }

  void initializeSocket() {
    socket = io("http://10.0.2.2:3000/", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket!.connect(); //connect the Socket.IO Client to the Server
    print("Socket controller initialized successfully");

    // //SOCKET EVENTS
    // // --> listening for connection
    // socket!.on('connect', (data) {
    //   print(socket!.connected);
    // });

    // //listen for incoming messages from the Server.
    // socket!.on('message', (data) {
    //   print(data); //
    // });

    // //listens when the client is disconnected from the Server
    // socket!.on('disconnect', (data) {
    //   print('disconnect');
    // });
  }

  Socket getSocket() {
    return socket!;
  }
}
