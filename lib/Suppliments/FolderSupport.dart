import 'package:flutter/material.dart';
import 'package:flutter_app/Core/Notes/Notemodel.dart';

class FolderSupport {
  final folderName;
  List<Note> notes;

  FolderSupport(this.folderName, this.notes);

  add(Note note){
    notes.add(note);
  }
}

class SuperFolders {

  late List<FolderSupport> allFolders = [FolderSupport("Your Notes", []),FolderSupport("Archived", [])];

  FolderSupport returnFolderByName(String folderName) {
    FolderSupport foldertoReturn = new FolderSupport("", []);
    for (int i = 0; i < allFolders.length; i++) {
      if (folderName == allFolders[i].folderName) {
        foldertoReturn = allFolders[i];
        break;
      }
    }
    return foldertoReturn;
  }


  int returnIndexOfFolder(String folderName) {
    for (int i = 0; i < allFolders.length; i++) {
      if (folderName == allFolders[i].folderName) {
        return i;
      }
    }
    return -1;
  }


  bool addFolder(FolderSupport folder) {
    bool doesExists = false;
    for (int i = 0; i < allFolders.length; i++) {
      if (folder.folderName == allFolders[i].folderName) {
        doesExists = true;
        break;
      }
    }
    if (doesExists == false) {
      allFolders.add(folder);
      return true;
    } else {
      return false;
    }
  }
}
