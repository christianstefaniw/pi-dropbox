import 'dart:io';

Future<Socket> connectToSocket() async {
  final sock = await Socket.connect('192.168.1.128', 1234);
  return sock;
}

