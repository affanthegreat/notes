import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Designs/Colors.dart';
import 'package:flutter_app/Designs/Fonts.dart';
import 'package:flutter_app/Suppliments/FolderSupport.dart';

class NoteContainer extends StatefulWidget {
  String title;
  String description;
  DateTime time;
  bool isImageAdded;
  FolderSupport? self;
  Color? notecolor;
  int? index;

  NoteContainer(this.title, this.description, this.notecolor, this.time, this.isImageAdded, {this.self, this.index}) {
    try {
      print(self!.folderName);
    } catch (E) {}
  }

  @override
  _NoteContainerState createState() => _NoteContainerState();
}

class _NoteContainerState extends State<NoteContainer> {
  var newFormat;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future removepassword() {
      late String password = "";
      return showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Change password',
                style: poppins(foreground.withOpacity(0.75), h3, FontWeight.w600),
              ),
              content: new Row(
                children: [
                  new Expanded(
                      child: TextField(
                    autofocus: true,
                    obscureText: true,
                    style: poppins(foreground, h2, FontWeight.w500),
                    decoration: InputDecoration(hintStyle: poppins(dark2, h4, FontWeight.w500), hintText: 'Your previous password?'),
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
                          if (widget.self!.notes[widget.index!.toInt()].getPassword() == password) {
                            setState(() {
                              widget.self!.notes[widget.index!.toInt()].isPasswordProtected = false;
                            });

                            widget.self!.notes[widget.index!.toInt()].setPassword("");
                            Navigator.pop(context);
                            final snackBar = SnackBar(
                              content: Text('Password removed',
                                  style: poppins(
                                    light,
                                    h3,
                                    FontWeight.w500,
                                  )),
                              backgroundColor: Colors.green.withOpacity(0.9),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          } else {
                            Navigator.pop(context);
                            final snackBar = SnackBar(
                              content: Text('Wrong password entered',
                                  style: poppins(
                                    light,
                                    h3,
                                    FontWeight.w500,
                                  )),
                              backgroundColor: Colors.red.withOpacity(0.9),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                        },
                        child: Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(color: dark1, borderRadius: BorderRadius.circular(5)),
                            padding: EdgeInsets.all(5),
                            child: Center(
                              child: Text(
                                "Okay",
                                style: poppins(foreground.withOpacity(0.75), h3, FontWeight.w600),
                              ),
                            )),
                      ),
                    )
                  ],
                )
              ],
            );
          });
    }

    Future passwordbox(BuildContext context) async {
      late String password = "";
      return showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            if (widget.self!.notes[widget.index!.toInt()].isPasswordProtected) {
              return AlertDialog(
                title: Text(
                  'Change password',
                  style: poppins(foreground.withOpacity(0.75), h3, FontWeight.w600),
                ),
                content: new Row(
                  children: [
                    new Expanded(
                        child: TextField(
                      autofocus: true,
                      obscureText: true,
                      style: poppins(foreground, h2, FontWeight.w500),
                      decoration: InputDecoration(hintStyle: poppins(dark2, h4, FontWeight.w500), hintText: 'Your previous password?'),
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
                            if (widget.self!.notes[widget.index!.toInt()].getPassword() == password) {
                              widget.self!.notes[widget.index!.toInt()].isPasswordProtected = false;
                              widget.self!.notes[widget.index!.toInt()].setPassword("");
                              Navigator.pop(context);
                              passwordbox(context);
                            } else {
                              Navigator.pop(context);
                              final snackBar = SnackBar(
                                content: Text('Wrong password entered',
                                    style: poppins(
                                      light,
                                      h3,
                                      FontWeight.w500,
                                    )),
                                backgroundColor: Colors.red.withOpacity(0.9),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }
                          },
                          child: Container(
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(color: dark1, borderRadius: BorderRadius.circular(5)),
                              padding: EdgeInsets.all(5),
                              child: Center(
                                child: Text(
                                  "Okay",
                                  style: poppins(foreground.withOpacity(0.75), h3, FontWeight.w600),
                                ),
                              )),
                        ),
                      )
                    ],
                  )
                ],
              );
            } else {
              return AlertDialog(
                title: Text(
                  'Change Password',
                  style: poppins(foreground.withOpacity(0.75), h3, FontWeight.w600),
                ),
                content: new Row(
                  children: [
                    new Expanded(
                        child: TextField(
                      autofocus: true,
                      obscureText: true,
                      style: poppins(foreground, h2, FontWeight.w500),
                      decoration: InputDecoration(hintStyle: poppins(dark2, h4, FontWeight.w500), hintText: 'New password'),
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
                            setState(() {
                              widget.self!.notes[widget.index!.toInt()].isPasswordProtected = true;
                              widget.self!.notes[widget.index!.toInt()].setPassword(password);
                              Navigator.pop(context);
                              final snackBar = SnackBar(
                                content: Text('Password protection enabled.',
                                    style: poppins(
                                      light,
                                      h3,
                                      FontWeight.w500,
                                    )),
                                backgroundColor: Colors.green.withOpacity(0.9),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            });
                          },
                          child: Container(
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(color: dark1, borderRadius: BorderRadius.circular(5)),
                              padding: EdgeInsets.all(5),
                              child: Center(
                                child: Text(
                                  "Okay",
                                  style: poppins(foreground.withOpacity(0.75), h3, FontWeight.w600),
                                ),
                              )),
                        ),
                      )
                    ],
                  )
                ],
              );
            }
          });
    }

    String timeBuilder() {
      return "${widget.time.day}/${widget.time.month}/${widget.time.year}";
    }

    Widget smallBox(String name, double x, String what) {
      return Expanded(
        child: Material(
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
              if (what == "change") {
                passwordbox(context);
              } else if (what == 'remove') {
                removepassword();
              } else if (what == 'hide') {}
            },
            child: Container(
              height: 70,
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(color: dark1.withOpacity(0.4), borderRadius: BorderRadius.circular(8)),
              child: Center(
                child: Text(
                  name,
                  style: poppins(foreground.withOpacity(0.8), x, FontWeight.w600),
                ),
              ),
            ),
          ),
        ),
      );
    }

    void showBiggerDialog() {
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
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Material(
                    type: MaterialType.transparency,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 10),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Quick Actions",
                            style: poppins(dark3.withOpacity(0.80), h4, FontWeight.w600),
                          ),
                        ),
                        widget.self!.notes[widget.index!.toInt()].isPasswordProtected
                            ? Container(
                                margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [smallBox('Change \npassword', h4, 'change'), smallBox('Remove \npassword', h4, 'remove'), smallBox('Hide this note', h4, 'hide')],
                                ),
                              )
                            : Container(
                                margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [smallBox('Set password', h4, 'change'), smallBox('Hide this note', h4, 'hide')],
                                ),
                              )
                      ],
                    ),
                  ),
                ],
              ),
              //margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
              decoration: BoxDecoration(
                color: light,
                boxShadow: [
                  BoxShadow(
                    color: foreground.withOpacity(0.5),
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

    return GestureDetector(
      onLongPress: () {
        showBiggerDialog();
      },
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 600,
          // minHeight: 100
        ),
        child: Container(
          decoration: BoxDecoration(color: widget.notecolor == light ? dark1.withOpacity(0.5) : widget.notecolor!.withOpacity(0.7), borderRadius: BorderRadius.circular(5)),
          child: Stack(children: [
            Column(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        margin: EdgeInsets.all(10),
                        child: AutoSizeText(
                          widget.title,
                          style: tt(foreground, h3, FontWeight.w600),
                          maxLines: 1,
                        ))),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        margin: EdgeInsets.all(10),
                        child: AutoSizeText(
                          widget.description,
                          style: tt(foreground, h4, FontWeight.w500),
                          maxLines: 1,
                        ))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10, bottom: 10),
                      child: Text(timeBuilder(), style: poppins(widget.notecolor != light ? foreground : dark3, h5, FontWeight.w600)),
                    ),
                  ],
                ),
              ],
            ),
            widget.self!.notes[widget.index!.toInt()].isPasswordProtected
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.all(10),
                          alignment: Alignment.topRight,
                          child: Icon(
                            Icons.lock,
                            color: widget.notecolor != light ? foreground : dark3,
                          ))
                    ],
                  )
                : Container()
          ]),
        ),
      ),
    );
  }
}
