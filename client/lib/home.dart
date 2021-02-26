import 'dart:io';

import 'package:client/services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'config.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await this.picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        this.image = File(pickedFile.path);
      }
    });
  }

  void upload() async{
    loading();

    Socket sock = await connectToSocket();
    List<int> bytes = this.image.readAsBytesSync();

    sock.add(bytes);

    sock.listen((event) {

      setState(() {
        this.image = null;
      });

      if (String.fromCharCodes(event) == 'true') {
        success();
      } else {
        error();
      }
    });

    await sock.close();
    Navigator.pop(context);
  }

  Future<Widget> loading() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new Dialog(
          child: new CircularProgressIndicator(),
        );
      },
    );
  }

  Future<Widget> success() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return new Dialog(
          child: new Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            child: Text(
              'Success',
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }

  Future<Widget> error() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return new Dialog(
            child: new Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              child: Text(
                'Error',
                textAlign: TextAlign.center,
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("My File Uploader"),
        actions: [
          IconButton(
              icon: currentTheme.currentTheme() == ThemeMode.dark
                  ? Icon(
                      Icons.lightbulb,
                      color: Theme.of(context).primaryColorLight,
                    )
                  : Icon(
                      Icons.lightbulb,
                      color: Theme.of(context).primaryColorDark,
                    ),
              onPressed: () => currentTheme.switchTheme())
        ],
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: MediaQuery.of(context).size.height / 3,
                child: this.image == null ? Text('') : Image.file(this.image)),
            RaisedButton.icon(
              color: Theme.of(context).primaryColorLight,
              onPressed: getImage,
              icon: Icon(Icons.image),
              label: Text('Image'),
            ),
            this.image == null
                ? Container()
                : RaisedButton.icon(
                    color: Theme.of(context).colorScheme.secondaryVariant,
                    onPressed: () {
                      upload();
                    },
                    icon: Icon(Icons.upload_rounded),
                    label: Text('Upload'),
                  )
          ],
        ),
      ),
    );
  }
}
