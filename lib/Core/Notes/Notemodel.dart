import 'package:flutter_app/Core/Alpha/NoteEditor.dart';
import 'package:flutter_app/Core/Alpha/NoteEditorModal.dart';
import 'package:flutter_app/Core/Home/NoteContainer.dart';
import 'package:flutter_app/Suppliments/FolderSupport.dart';

import 'package:hive/hive.dart';

class Note extends HiveObject {

  String title = "";
  String content = "";
  NoteContainer container = new NoteContainer("", "", DateTime.now(), false);
  late NoteEditorModal noteEditor;
  int? index;
  DateTime time = new DateTime.now();
  bool isImageAdded = false;
  late String? _password;
  late bool isPasswordProtected = false;

  Note(index) {
    noteEditor = new NoteEditorModal(index!.toInt());
  }

  late String originFolder;

  setIndex(int index) {
    this.index = index;
  }

  updater() {
    container.title = title;
    container.description = content;
    container.time = time;
    container.isImageAdded = isImageAdded;
  }

  setOriginFolder(String folder) {
    originFolder = folder;
  }

  NoteContainer noteContainer({FolderSupport? self, int? index}) {
    container.self = self;
    container.index = index;
    return container;
  }

  setPassword(String pass) {
    this._password = pass;
  }

  getPassword() {
    return this._password;
  }
}
