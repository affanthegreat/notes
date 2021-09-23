import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Core/Alpha/Widgets/Paint.dart';
import 'package:flutter_app/Core/FoldersManagement/FolderView.dart';
import 'package:flutter_app/Core/Home/Home.dart';
import 'package:flutter_app/Core/Notes/Notemodel.dart';
import 'package:flutter_app/Designs/Colors.dart';
import 'package:flutter_app/Designs/Fonts.dart';
import 'package:flutter_app/Suppliments/Dismissable.dart';
import 'package:flutter_app/Suppliments/FolderSupport.dart';

var prev;

class NoteEditor extends StatefulWidget {
  late List<dynamic>? content;
  int? index;
  late FolderSupport? self;
  late Color? notecolor;

  NoteEditor({this.self, this.index, this.content, this.notecolor, Key? key}) : super(key: key);

  @override
  _NoteEditorState createState() => _NoteEditorState(this.notecolor);
}

class _NoteEditorState extends State<NoteEditor> {
  @override
  void initState() {
// TODO: implement initState
    super.initState();
  }

  var scaffoldcolor;

  _NoteEditorState(this.scaffoldcolor);

  @override
  Widget build(BuildContext context) {
    void delete(index) {
      setState(() {
        widget.content!.removeAt(index);
        widget.content!.removeAt(index);
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Drawing deleted.',
            style: poppins(light, h4, FontWeight.w500),
          )));
    }

    Widget circleSelect(double r, Color x, String b) {
      return Material(
        type: MaterialType.transparency,
        borderOnForeground: false,
        child: Container(
          margin: EdgeInsets.all(10),
          color: light,
          child: InkWell(
            onTap: () {
              if (widget.index == -1) {
                setState(() {
                  temp.setColor(x);
                  temp.colorName = b;
                  scaffoldcolor = x;
                });
              } else {
                setState(() {
                  prev = widget.self!.notes[widget.index!.toInt()].colorName;
                  widget.self!.notes[widget.index!.toInt()].setColor(x);
                  widget.self!.notes[widget.index!.toInt()].colorName = b;
                  scaffoldcolor = x;
                });
              }

              print("Changed Color");
            },
            child: CircleAvatar(
              maxRadius: r + 1,
              backgroundColor: foreground.withOpacity(0.2),
              child: CircleAvatar(
                maxRadius: r,
                backgroundColor: x,
              ),
            ),
          ),
        ),
      );
    }

    void showDialog() {
      showGeneralDialog(
        barrierLabel: "Barrier",
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.15),
        transitionDuration: Duration(milliseconds: 450),
        context: context,
        pageBuilder: (_, __, ___) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 190,
              child: Column(
                children: [
                  Material(
                    type: MaterialType.transparency,
                    child: Container(
                      margin: EdgeInsets.only(left: 15, right: 15, top: 10),
                      height: 100,
                      child: Text(
                        "Add a color to your note. This enables faster access to the specified color notes from home screen by Color tags.",
                        style: poppins(foreground, h4, FontWeight.normal),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        circleSelect(12, Colors.red.shade200, "Red"),
                        circleSelect(12, Colors.blue.shade200, "Blue"),
                        circleSelect(12, Colors.yellow.shade200, "Yellow"),
                        circleSelect(12, Colors.green.shade200, "Green"),
                        circleSelect(12, Colors.orange.shade200, "Orange"),
                        circleSelect(12, Colors.purple.shade200, "Purple"),
                        circleSelect(12, Colors.grey.shade200, "Grey"),
                        circleSelect(12, light, "None"),
                      ],
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: light,
                boxShadow: [
                  BoxShadow(
                    color: foreground.withOpacity(0.6),
                    offset: Offset(
                      5.0,
                      5.0,
                    ),
                    blurRadius: 10.0,
                    spreadRadius: 2.0,
                  )
                ],
                borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15)),
              ),
            ),
          );
        },
        transitionBuilder: (_, anim, __, child) {
          return SlideTransition(
            position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
            child: child,
          );
        },
      );
    }

    return Scaffold(
        backgroundColor: scaffoldcolor,
        appBar: AppBar(
          backgroundColor: scaffoldcolor ?? light,
          elevation: 0,
          iconTheme: IconThemeData(
            color: foreground, //change your color here
          ),
          leading: IconButton(
            onPressed: () {
              super.dispose();
              if (Navigator.canPop(context)) {
                Navigator.of(context, rootNavigator: true).pop();
              } else {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => Home(
                              self: current,
                              archived: wisdom!.returnFolderByName("Archived"),
                            )),
                    (Route<dynamic> route) => false);
              }
            },
            icon: Icon(Icons.arrow_back),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  showDialog();
                },
                icon: Icon(Icons.circle)),
            IconButton(
              onPressed: () {
                if (widget.index == -1) {
                  setState(() {
                    temp.noteEditor.addNewAudio();
                  });

                  print(temp.noteEditor.noteContents.length);
                } else {
                  setState(() {
                    widget.self!.notes[widget.index!.toInt()].noteEditor.addNewAudio();
                  });
                }
              },
              icon: Icon(Icons.keyboard_voice_rounded),
              color: foreground.withOpacity(0.5),
            ),
            IconButton(
                onPressed: () {
                  print(wisdom!.allFolders[wisdom!.returnIndexOfFolder(widget.self!.folderName)].notes.length);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PaintScreen(
                                index: widget.index!.toInt(),
                                self: widget.self,
                              )));
                },
                icon: Icon(
                  Icons.brush_rounded,
                  color: foreground.withOpacity(0.5),
                )),
            IconButton(
                onPressed: () {
                  print(widget.index);
                  print(widget.self!.folderName);
                  if (widget.index == -1) {
                    print("||||||||||||||||||||||setting temp note variables ||||||||||||||||||||||||||||||||");
                    print("Setting title, content to note container.");
                    temp.title = temp.noteEditor.noteContents[0].title;
                    temp.content = temp.noteEditor.noteContents[1].content;
                    print("Setting title, content to note container done. now setting indexes.");
                    temp.setIndex(widget.self!.notes.length);
                    temp.noteEditor.index = widget.self!.notes.length;
                    temp.originFolder = current!.folderName;
                    temp.updater();

                    for (var i in temp.noteEditor.paintIndexes) {
                      temp.noteEditor.noteContents[i].innerIndex = i;

                      temp.noteEditor.noteContents[i].outerIndex = widget.self!.notes.length;
                    }

                    for (int i = 0; i < temp.noteEditor.noteContents.length; i += 1) {
                      if (temp.noteEditor.paintIndexes.contains(i)) {
                        continue;
                      } else {
                        temp.query += temp.noteEditor.noteContents[i].text();
                      }
                    }

                    print("The condition for adding the note to color tag is ${temp.colorName != 'None' && temp.colortagIndex == -1}");

                    setState(() {
                      widget.self!.notes.add(temp);

                      if (temp.colorName != 'None' && temp.colortagIndex == -1) {
                        temp.colortagIndex = (colortags.returnTagByName(temp.colorName)).notes.length;
                        print("Added note to color tag folder.");
                        (colortags.returnTagByName(temp.colorName)).add(temp);
                      }
                      wisdom!.allFolders[wisdom!.returnIndexOfFolder(widget.self!.folderName)] = widget.self!;
                    });

                    temp = new Note(-1);

                    print("Current note title(temp) : ${temp.title}");
                    print("Current note color tag index(temp) : ${temp.colortagIndex}");
                    print("Current note colorname(temp): ${temp.colorName}");
                    print("Current note index(temp) : ${temp.index}");
                    print("||||||||||||||||||||||Temp note assigned to folder ${widget.self!.folderName} ||||||||||||||||||||||||||||||||");
                  } else {
                    print("||||||||||||||||||||||setting note variables ||||||||||||||||||||||||||||||||");
                    print("Setting title, content to note container.");
                    widget.self!.notes[widget.index!.toInt()].title = widget.self!.notes[widget.index!.toInt()].noteEditor.noteContents[0].title;
                    widget.self!.notes[widget.index!.toInt()].content = widget.self!.notes[widget.index!.toInt()].noteEditor.noteContents[1].content;
                    widget.self!.notes[widget.index!.toInt()].updater();
                    print("Setting title, content to note container done. now setting indexes.");
                    for (var i in widget.self!.notes[widget.index!.toInt()].noteEditor.paintIndexes) {
                      widget.self!.notes[widget.index!.toInt()].noteEditor.noteContents[i].innerIndex = i;
                      widget.self!.notes[widget.index!.toInt()].noteEditor.noteContents[i].outerIndex = widget.self!.notes.length;
                    }

                    for (int i = 0; i < widget.self!.notes[widget.index!.toInt()].noteEditor.noteContents.length; i += 1) {
                      if (widget.self!.notes[widget.index!.toInt()].noteEditor.paintIndexes.contains(i)) {
                        continue;
                      } else {
                        widget.self!.notes[widget.index!.toInt()].query += widget.self!.notes[widget.index!.toInt()].noteEditor.noteContents[i].text();
                      }
                    }

                    print(widget.self!.notes[widget.index!.toInt()].colorName);

                    if (widget.self!.notes[widget.index!.toInt()].colorName == 'None') {
                      print(widget.self!.notes[widget.index!.toInt()].colorName);
                      print(widget.self!.notes[widget.index!.toInt()].noteColor);
                    }

                    print("The condition for adding the note to color tag is ${widget.self!.notes[widget.index!.toInt()].colorName != 'None' && widget.self!.notes[widget.index!.toInt()].colortagIndex == -1}");

                    if (widget.self!.notes[widget.index!.toInt()].colorName == 'None' && widget.self!.notes[widget.index!.toInt()].colortagIndex != -1) {
                      print("Color changed to default so removing note from its color tag folder.");
                      (colortags.returnTagByName(widget.self!.notes[widget.index!.toInt()])).notes.removeAt(widget.self!.notes[widget.index!.toInt()].colortagIndex);
                      widget.self!.notes[widget.index!.toInt()].colortagIndex = -1;
                    }
                    setState(() {
                      if (widget.self!.notes[widget.index!.toInt()].colorName != 'None' && widget.self!.notes[widget.index!.toInt()].colortagIndex == -1) {
                        print("Note has color and it has index -1. adding it to color tag folder.");
                        widget.self!.notes[widget.index!.toInt()].colortagIndex = (colortags.returnTagByName(temp.colorName)).notes.length;
                        (colortags.returnTagByName(widget.self!.notes[widget.index!.toInt()].colorName)).notes.add(widget.self!.notes[widget.index!.toInt()]);
                      }
                    });
                    print("Current note title : ${widget.self!.notes[widget.index!.toInt()].title}");
                    print("Current note color tag index : ${widget.self!.notes[widget.index!.toInt()].colortagIndex}");
                    print("Current note colorname : ${widget.self!.notes[widget.index!.toInt()].colorName}");
                    print("Current note index : ${widget.self!.notes[widget.index!.toInt()].index}");
                    print("Current note ispasswordprotected : ${widget.self!.notes[widget.index!.toInt()].isPasswordProtected}");
                    print("||||||||||||||||||||||note assigned to folder ${widget.self!.folderName} ||||||||||||||||||||||||||||||||");
                  }
                  super.dispose();
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Folders()), (Route<dynamic> route) => false);
                },
                icon: Icon(
                  Icons.save_rounded,
                  color: foreground.withOpacity(0.5),
                ))
          ],
        ),
        body: ListView.builder(
            physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            itemCount: widget.content!.length,
            itemBuilder: (context, index) {
              if (widget.content![index].widgetType() == 'Image' || widget.content![index].widgetType() == 'Audio') {
                void ee() async {
                  await new Future.delayed(new Duration(milliseconds: 2000), () {
                    print("Wait complete");
                  });
                }

                ee();
                return DismissibleWidget4(
                    item: widget.content![index],
                    child: widget.content![index],
                    onDismissed: (direction) {
                      switch (direction) {
                        case DismissDirection.endToStart:
                          delete(index);
                          break;
                        case DismissDirection.startToEnd:
                          delete(index);
                          break;
                        case DismissDirection.vertical:
                          print("12");
                          break;
                        case DismissDirection.horizontal:
                          print("12");
                          break;
                        case DismissDirection.up:
                          print("12");
                          break;
                        case DismissDirection.down:
                          print("12");
                          break;
                        case DismissDirection.none:
                          print("12");
                          break;
                      }
                    });
              } else {
                return widget.content![index];
              }
            }));
  }
}
