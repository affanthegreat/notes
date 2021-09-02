import 'package:flutter/material.dart';
import 'package:flutter_app/Core/Notes/Notemodel.dart';

import 'package:flutter_app/Core/Security/PasswordScreen.dart';
import 'package:flutter_app/Core/Settings/Settings.dart';
import 'package:flutter_app/Designs/Colors.dart';
import 'package:flutter_app/Designs/Fonts.dart';
import 'package:flutter_app/Suppliments/Dismissable.dart';
import 'package:flutter_app/Suppliments/FolderSupport.dart';

var temp;

class Home extends StatefulWidget {
  late FolderSupport? self;
  late FolderSupport? archived;

  Home({this.self, this.archived, Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    void archive(index) {
      setState(() {
        widget.self!.notes[index].setOriginFolder(widget.self!.folderName);
        widget.archived!.add(widget.self!.notes[index]);
        widget.self!.notes.removeAt(index);
      });
      print(widget.archived!.notes.length);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(milliseconds: 350),
          backgroundColor: Colors.orange,
          content: Text(
            'Note archived.',
            style: poppins(light, h4, FontWeight.w500),
          )));
    }

    void delete(index) {
      setState(() {
        widget.self!.notes.removeAt(index);
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: dark1.withOpacity(0.9),
        foregroundColor: Colors.black,
        mini: true,
        onPressed: () {
          temp = new Note(-1);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => temp.noteEditor.noteEditor));
        },
        child: Icon(
          Icons.add,
          color: foreground.withOpacity(0.5),
          size: 20,
        ),
      ),
      appBar: AppBar(
        backgroundColor: light,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: foreground, //change your color here
        ),
        title: GestureDetector(
          onLongPress: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Vault()));
          },
          child: Text(
            widget.self!.folderName.toString(),
            style: poppins(dark3, h4, FontWeight.w600),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Settings()));
              },
              icon: Icon(
                Icons.settings,
                color: dark3,
              ))
        ],
      ),
      body: (widget.self!.notes.length == 0)
          ? Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 600),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Add new notes to see here.",
                      style: poppins(foreground, h4, FontWeight.w500),
                    ),
                  ],
                ),
              ),
            )
          : ListView.builder(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemCount: widget.self!.notes.length,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Column(
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 600),
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 20, right: 20, top: 5, bottom: 10),
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: foreground.withOpacity(0.25),
                                width: 0.4),
                            borderRadius: BorderRadius.circular(5),
                            color: light,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.25),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: TextField(
                            style: poppins(foreground.withOpacity(0.7), h2 - 4,
                                FontWeight.w500),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.search,
                                color: dark2,
                              ),
                              hintText: "Search for any keyword you remember.",
                              hintStyle: poppins(foreground.withOpacity(0.5),
                                  h4, FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      DismissibleWidget(
                          item: widget.self!.notes[index],
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 20, right: 20, top: 5, bottom: 10),
                            child: InkWell(
                                onTap: () {
                                  if (widget
                                      .self!.notes[index].isPasswordProtected) {
                                    late String password = "";
                                    showDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      // dialog is dismissible with a tap on the barrier
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                            'Enter your password',
                                            style: poppins(
                                                foreground.withOpacity(0.75),
                                                h3,
                                                FontWeight.w600),
                                          ),
                                          content: new Row(
                                            children: [
                                              new Expanded(
                                                  child: TextField(
                                                autofocus: true,
                                                style: poppins(foreground, h2,
                                                    FontWeight.w500),
                                                decoration: InputDecoration(
                                                    hintStyle: poppins(dark2,
                                                        h4, FontWeight.w500),
                                                    hintText:
                                                        'Subject or Idea'),
                                                onChanged: (value) {
                                                  password = value;
                                                },
                                              ))
                                            ],
                                          ),
                                          actions: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: InkWell(
                                                    onTap: () {
                                                      if (password ==
                                                          widget.self!
                                                              .notes[index]
                                                              .getPassword()) {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => widget
                                                                    .self!
                                                                    .notes[
                                                                        index]
                                                                    .noteEditor
                                                                    .notes()));
                                                      }
                                                    },
                                                    child: Container(
                                                        margin:
                                                            EdgeInsets.all(10),
                                                        decoration: BoxDecoration(
                                                            color: dark1,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                        padding:
                                                            EdgeInsets.all(5),
                                                        child: Center(
                                                          child: Text(
                                                            "Ok",
                                                            style: poppins(
                                                                foreground
                                                                    .withOpacity(
                                                                        0.75),
                                                                h3,
                                                                FontWeight
                                                                    .w600),
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
                                  }

                                  else{
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => widget
                                                .self!.notes[index].noteEditor
                                                .notes()));
                                  }

                                },
                                child: widget.self!.notes[index].noteContainer(
                                    self: widget.self, index: index)),
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
                  child: DismissibleWidget(
                      item: widget.self!.notes[index],
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 20, right: 20, top: 5, bottom: 10),
                        child: InkWell(
                          onTap: () {
                            if (widget
                                .self!.notes[index].isPasswordProtected) {
                              late String password = "";
                              showDialog(
                                context: context,
                                barrierDismissible: true,
                                // dialog is dismissible with a tap on the barrier
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      'Enter your password',
                                      style: poppins(
                                          foreground.withOpacity(0.75),
                                          h3,
                                          FontWeight.w600),
                                    ),
                                    content: new Row(
                                      children: [
                                        new Expanded(
                                            child: TextField(
                                              autofocus: true,
                                              style: poppins(foreground, h2,
                                                  FontWeight.w500),
                                              decoration: InputDecoration(
                                                  hintStyle: poppins(dark2,
                                                      h4, FontWeight.w500),
                                                  hintText:
                                                  'Subject or Idea'),
                                              onChanged: (value) {
                                                password = value;
                                              },
                                            ))
                                      ],
                                    ),
                                    actions: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                if (password ==
                                                    widget.self!
                                                        .notes[index]
                                                        .getPassword()) {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => widget
                                                              .self!
                                                              .notes[
                                                          index]
                                                              .noteEditor
                                                              .notes()));
                                                }
                                              },
                                              child: Container(
                                                  margin:
                                                  EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      color: dark1,
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          5)),
                                                  padding:
                                                  EdgeInsets.all(5),
                                                  child: Center(
                                                    child: Text(
                                                      "Ok",
                                                      style: poppins(
                                                          foreground
                                                              .withOpacity(
                                                              0.75),
                                                          h3,
                                                          FontWeight
                                                              .w600),
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
                            }
                            else{
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => widget
                                          .self!.notes[index].noteEditor
                                          .notes()));
                            }


                          },
                          child: widget.self!.notes[index]
                              .noteContainer(self: widget.self, index: index),
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
