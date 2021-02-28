import 'dart:io';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path_provider/path_provider.dart';

Future<Socket> connectToSocket(String url, int port) async {
  final sock = await Socket.connect(url, port);
  return sock;
}


class DB{
  final store = StoreRef.main();

  Database db;

  DB(Database db){
    this.db = db;
  }

  Future<void> write(String record, dynamic newVal) async{
    if (record == 'port'){
      newVal = int.parse(newVal);
    }
    await this.store.record(record).put(this.db, newVal);
  }

  Future get(String record) async{
    return store.record(record).get(this.db);
  }
}


Future<Database> openDb() async{
  final directory = await getApplicationDocumentsDirectory();
  String dbPath = '${directory.path}/urlport.db';
  DatabaseFactory dbFactory = databaseFactoryIo;
  Database db = await dbFactory.openDatabase(dbPath);
  return db;
}
