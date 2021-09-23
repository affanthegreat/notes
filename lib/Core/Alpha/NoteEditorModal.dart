import 'package:flutter/cupertino.dart';
import 'package:flutter_app/Core/Alpha/NoteEditor.dart';
import 'package:flutter_app/Core/FoldersManagement/FolderView.dart';
import 'package:flutter_app/Designs/Colors.dart';

import 'Widgets/TextFields.dart';
import 'Widgets/VoiceMemo.dart';

var folderNameHolder = "Your Notes";

class NoteEditorModal {
  String title = "";
  List<dynamic> noteContents = [];
  late NoteEditor noteEditor;
  late int index;
  late String foldername;
  int internalIndex = 0;
  var notecolor = light;
  late var paintIndexes = [];

  NoteEditorModal(int index) {
    addNewTitle(internalIndex);
    internalIndex += 1;
    addNewContentTextField();
    this.index = index;
    noteEditor = new NoteEditor(
      index: index,
      content: noteContents,
      self: wisdom!.returnFolderByName(folderNameHolder),
    );
  }

  addNewContentTextField() {
    noteContents.add(ContentTextField(true, ""));
  }

  addNewPaint(Widget img) {
    noteContents.add(img);
  }

  addNewAudio() {
    noteContents.add(new Audio());
    addNewContentTextField();
  }

  addNewTitle(int internalIndex) {
    noteContents.add(new TitleTextField(true, ""));
  }

  NoteEditor notes() {
    noteEditor = new NoteEditor(
      index: index,
      content: noteContents,
      self: wisdom!.returnFolderByName(folderNameHolder),
      notecolor: notecolor,
    );
    return noteEditor;
  }
}
