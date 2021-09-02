import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/Core/Home/Home.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'Core/FoldersManagement/FolderView.dart';
import 'Suppliments/FolderSupport.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // debugRepaintRainbowEnabled = true;
  if (kIsWeb) {
    runApp(MyApp());
  } else if (Platform.isAndroid || Platform.isIOS) {
    Directory directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    runApp(MyApp());
  }
  wisdom = new SuperFolders();
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
