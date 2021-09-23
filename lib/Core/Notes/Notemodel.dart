import 'package:flutter_app/Core/Alpha/NoteEditorModal.dart';
import 'package:flutter_app/Core/Home/NoteContainer.dart';
import 'package:flutter_app/Designs/Colors.dart';
import 'package:flutter_app/Suppliments/FolderSupport.dart';
import 'package:hive/hive.dart';

class Note extends HiveObject {
  String title = "";
  String content = "";
  NoteContainer container = new NoteContainer("", "", dark1.withOpacity(0.5), DateTime.now(), false);
  late NoteEditorModal noteEditor;
  int? index;
  DateTime time = new DateTime.now();
  bool isImageAdded = false;
  late String? _password;
  late bool isPasswordProtected = false;
  late var noteColor = light;
  late var colorName = 'None';
  late int colortagIndex = -1;
  late String query = "";
  Note(index) {
    noteEditor = new NoteEditorModal(index!.toInt());
  }

  late String originFolder;

  setIndex(int index) {
    this.index = index;
  }

  updater() {
    print('________ Running updater for notes with title $title ___________');
    container.title = title;
    container.description = content;
    container.time = time;
    container.isImageAdded = isImageAdded;
    if (colorName != 'None') {
      print("Colors are being changed to $noteColor");
      container.notecolor = noteColor;
      noteEditor.notecolor = noteColor;
    } else {
      container.notecolor = light;
      noteEditor.notecolor = light;
    }
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

  setColor(var color) {
    this.noteColor = color;
  }

  getColor() {
    return this.noteColor;
  }
}
