import 'package:flutter/material.dart';
import 'package:flutter_app/Core/FoldersManagement/FolderView.dart';
import 'package:flutter_app/Core/Home/Searchbox.dart';
import 'package:flutter_app/Designs/Colors.dart';
import 'package:flutter_app/Designs/Fonts.dart';
import 'package:flutter_app/Suppliments/Dismissable.dart';
import 'package:flutter_app/Suppliments/FolderSupport.dart';

class Archived extends StatefulWidget {
  FolderSupport? archived;
  Archived({this.archived, Key? key}) : super(key: key);

  @override
  _ArchivedState createState() => _ArchivedState();
}

class _ArchivedState extends State<Archived> {
  @override
  Widget build(BuildContext context) {
    void archive(index) {
      setState(() {
        if (widget.archived!.notes[index].colortagIndex != -1 && widget.archived!.notes[index].colorName != 'None') {
          var a = colortags.returnTagByName(widget.archived!.notes[index].colorName);
          widget.archived!.notes[index].colortagIndex = a.notes.length;
          widget.archived!.notes[index].index = wisdom!.returnFolderByName(widget.archived!.notes[index].originFolder).notes.length;
          widget.archived!.notes[index].noteEditor.index = wisdom!.returnFolderByName(widget.archived!.notes[index].originFolder).notes.length;
          a.notes.add(widget.archived!.notes[index]);
          wisdom!.returnFolderByName(widget.archived!.notes[index].originFolder).add(widget.archived!.notes[index]);
          widget.archived!.notes.removeAt(index);
        } else {
          widget.archived!.notes[index].index = wisdom!.returnFolderByName(widget.archived!.notes[index].originFolder).notes.length;
          widget.archived!.notes[index].noteEditor.index = wisdom!.returnFolderByName(widget.archived!.notes[index].originFolder).notes.length;
          wisdom!.returnFolderByName(widget.archived!.notes[index].originFolder).add(widget.archived!.notes[index]);
          widget.archived!.notes.removeAt(index);
        }
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(milliseconds: 350),
          backgroundColor: Colors.orange,
          content: Text(
            'Note moved from archived.',
            style: poppins(light, h4, FontWeight.w500),
          )));
    }

    void delete(index) {
      setState(() {
        widget.archived!.notes.removeAt(index);
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(milliseconds: 350),
          backgroundColor: Colors.red,
          content: Text(
            'Note deleted.',
            style: poppins(light, h4, FontWeight.w500),
          )));
    }

    return Scaffold(
      backgroundColor: light,
      appBar: AppBar(
        backgroundColor: light,
        iconTheme: IconThemeData(
          color: foreground, //change your color here
        ),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Archived Notes",
          style: poppins(dark3, h4, FontWeight.w600),
        ),
      ),
      body: (widget.archived!.notes.length == 0)
          ? Center(
              child: Text(
                "No notes are archived at this moment.",
                style: poppins(foreground, h3, FontWeight.w500),
              ),
            )
          : ListView.builder(
              physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              itemCount: widget.archived!.notes.length,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Column(
                    children: [
                      SearchBar(),
                      DismissibleWidget2(
                          item: widget.archived!.notes[index],
                          child: Container(
                            margin: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 10),
                            child: InkWell(
                                onTap: () {
                                  if (widget.archived!.notes[index].isPasswordProtected) {
                                    late String password = "";
                                    showDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      // dialog is dismissible with a tap on the barrier
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                            'Enter your password',
                                            style: poppins(foreground.withOpacity(0.75), h3, FontWeight.w600),
                                          ),
                                          content: new Row(
                                            children: [
                                              new Expanded(
                                                  child: TextField(
                                                autofocus: true,
                                                style: poppins(foreground, h2, FontWeight.w500),
                                                decoration: InputDecoration(hintStyle: poppins(dark2, h4, FontWeight.w500), hintText: 'Password'),
                                                onChanged: (value) {
                                                  password = value;
                                                },
                                              ))
                                            ],
                                          ),
                                          actions: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: InkWell(
                                                    onTap: () {
                                                      if (password == widget.archived!.notes[index].getPassword()) {
                                                        Navigator.push(context, MaterialPageRoute(builder: (context) => widget.archived!.notes[index].noteEditor.notes()));
                                                      }
                                                    },
                                                    child: Container(
                                                        margin: EdgeInsets.all(10),
                                                        decoration: BoxDecoration(color: dark1, borderRadius: BorderRadius.circular(5)),
                                                        padding: EdgeInsets.all(5),
                                                        child: Center(
                                                          child: Text(
                                                            "Ok",
                                                            style: poppins(foreground.withOpacity(0.75), h3, FontWeight.w600),
                                                          ),
                                                        )),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        );
                                      },
                                    );
                                  } else {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => widget.archived!.notes[index].noteEditor.notes()));
                                  }
                                },
                                child: widget.archived!.notes[index].noteContainer(self: widget.archived, index: index)),
                          ),
                          onDismissed: (direction) {
                            switch (direction) {
                              case DismissDirection.endToStart:
                                delete(index);
                                break;
                              case DismissDirection.startToEnd:
                                archive(index);
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
                          }),
                    ],
                  );
                }

                return Align(
                  alignment: Alignment.center,
                  child: DismissibleWidget2(
                      item: widget.archived!.notes[index],
                      child: Container(
                        margin: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 10),
                        child: InkWell(
                          onTap: () {
                            if (widget.archived!.notes[index].isPasswordProtected) {
                              late String password = "";
                              showDialog(
                                context: context,
                                barrierDismissible: true,
                                // dialog is dismissible with a tap on the barrier
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      'Enter your password',
                                      style: poppins(foreground.withOpacity(0.75), h3, FontWeight.w600),
                                    ),
                                    content: new Row(
                                      children: [
                                        new Expanded(
                                            child: TextField(
                                          autofocus: true,
                                          style: poppins(foreground, h2, FontWeight.w500),
                                          decoration: InputDecoration(hintStyle: poppins(dark2, h4, FontWeight.w500), hintText: 'Password'),
                                          onChanged: (value) {
                                            password = value;
                                          },
                                        ))
                                      ],
                                    ),
                                    actions: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                if (password == widget.archived!.notes[index].getPassword()) {
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => widget.archived!.notes[index].noteEditor.notes()));
                                                }
                                              },
                                              child: Container(
                                                  margin: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(color: dark1, borderRadius: BorderRadius.circular(5)),
                                                  padding: EdgeInsets.all(5),
                                                  child: Center(
                                                    child: Text(
                                                      "Ok",
                                                      style: poppins(foreground.withOpacity(0.75), h3, FontWeight.w600),
                                                    ),
                                                  )),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  );
                                },
                              );
                            } else {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => widget.archived!.notes[index].noteEditor.notes()));
                            }
                          },
                          child: widget.archived!.notes[index].noteContainer(self: widget.archived, index: index),
                        ),
                      ),
                      onDismissed: (direction) {
                        switch (direction) {
                          case DismissDirection.endToStart:
                            delete(index);
                            break;
                          case DismissDirection.startToEnd:
                            archive(index);
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
                      }),
                );
              },
            ),
    );
  }
}
