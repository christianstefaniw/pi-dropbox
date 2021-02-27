import 'dart:io';
import 'package:flutter_config/flutter_config.dart';

Future<Socket> connectToSocket() async {
  final sock = await Socket.connect(FlutterConfig.get('URL'), int.parse(FlutterConfig.get('PORT')));
  return sock;
}

