import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'Core/FoldersManagement/FolderView.dart';
import 'Suppliments/FolderSupport.dart';

bool isDarktheme = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // debugRepaintRainbowEnabled = true;
  if (kIsWeb) {
    runApp(MyApp());
  } else if (Platform.isAndroid || Platform.isIOS) {
    Directory directory = await getApplicationDocumentsDirectory();
    print("Path is going to be printed");
    print(directory.toString());
    Hive.init(directory.path);

    runApp(MyApp());
  }
  wisdom = new SuperFolders();
  colortags = new ColorTags();
  print((wisdom!.allFolders.length + colortags!.allFolders.length).toInt());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Folders(),
    );
  }
}
