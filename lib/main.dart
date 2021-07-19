import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() async {

  // var data = await readData();
  // if(data != null){
  //   String message = await readData();
  //   print(message);
  // }  

  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "IO",
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _enterDataField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Read/Write"),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: Container(
        padding: EdgeInsets.all(13),
        alignment: Alignment.topCenter,
        child: ListTile(
          title: TextField(
            controller: _enterDataField,
            decoration: InputDecoration(
              labelText: "Write Something",
            ),
          ),
          subtitle: FlatButton(
            onPressed: () {
              writeData(_enterDataField.text);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Save data"),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: FutureBuilder(
                    future: readData(),
                    builder: (BuildContext context,AsyncSnapshot<String> data){
                      if(data.hasData != null){
                        return Text(
                          data.data.toString(),
                          style: TextStyle(color: Colors.blueAccent),
                        );
                      } else{
                        return Text("No data Saved");
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path; //home/directory/
}

Future<File> get _localFile async {
  final path = await _localPath;

  return new File(
      "$path/data.txt"); //home/directory/data.txt(it's an empty text file)
}

//write and read from our file
Future<File> writeData(String message) async {
  final file = await _localFile;

  //write to file
  return file.writeAsString("$message");
}

Future<String> readData() async {
  try {
    final file = await _localFile;

    //Read
    String data = await file.readAsString();
    return data;
  } catch (e) {
    return "Nothing saved yet";
  }
}
