import 'dart:html';

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
  int? index;

  NoteContainer(this.title, this.description, this.time, this.isImageAdded,
      {this.self, this.index});

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


    Future passwordbox(BuildContext context) async {
      late String password = "";
      return showDialog(
          context: context,
          barrierDismissible: true,
          // dialog is dismissible with a tap on the barrier
          builder: (BuildContext context) {
            if (widget.self!.notes[widget.index!.toInt()].isPasswordProtected) {
              return AlertDialog(
                title: Text(
                  'Change password',
                  style: poppins(
                      foreground.withOpacity(0.75), h3, FontWeight.w600),
                ),
                content: Column(
                  children: [
                    new Row(
                      children: [
                        new Expanded(
                            child: TextField(
                          autofocus: true,
                          obscureText: true,
                          style: poppins(foreground, h2, FontWeight.w500),
                          decoration: InputDecoration(
                              hintStyle: poppins(dark2, h4, FontWeight.w500),
                              hintText: 'Your previous password?'),
                          onChanged: (value) {
                            password = value;
                          },
                        ))
                      ],
                    ),
                    new Row(
                      children: [
                        new Expanded(
                            child: TextField(
                              autofocus: true,
                              obscureText: true,
                              style: poppins(foreground, h2, FontWeight.w500),
                              decoration: InputDecoration(
                                  hintStyle: poppins(dark2, h4, FontWeight.w500),
                                  hintText: 'New Password'),
                              onChanged: (value) {
                                password = value;
                              },
                            ))
                      ],
                    ),
                  ],
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: dark1,
                                  borderRadius: BorderRadius.circular(5)),
                              padding: EdgeInsets.all(5),
                              child: Center(
                                child: Text(
                                  "Okay",
                                  style: poppins(foreground.withOpacity(0.75),
                                      h3, FontWeight.w600),
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
                  style: poppins(
                      foreground.withOpacity(0.75), h3, FontWeight.w600),
                ),
                content: new Row(
                  children: [
                    new Expanded(
                        child: TextField(
                      autofocus: true,
                      obscureText: true,
                      style: poppins(foreground, h2, FontWeight.w500),
                      decoration: InputDecoration(
                          hintStyle: poppins(dark2, h4, FontWeight.w500),
                          hintText: 'New password'),
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
                           });

                          },
                          child: Container(
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: dark1,
                                  borderRadius: BorderRadius.circular(5)),
                              padding: EdgeInsets.all(5),
                              child: Center(
                                child: Text(
                                  "Okay",
                                  style: poppins(foreground.withOpacity(0.75),
                                      h3, FontWeight.w600),
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

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 600,
        // minHeight: 100
      ),
      child: Container(
        decoration: BoxDecoration(
            color: dark1.withOpacity(0.5),
            borderRadius: BorderRadius.circular(5)),
        child: Stack(
          children:[ Column(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        widget.title,
                        style: tt(foreground, h2, FontWeight.w600),
                      ))),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      margin: EdgeInsets.all(10),
                      child: AutoSizeText(
                        widget.description,
                        style: tt(foreground, h4, FontWeight.w500),
                        maxLines: 2,
                      ))),
              widget.isImageAdded
                  ? Row(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Text(
                            timeBuilder() + "   •Drawing(s) added",
                            style: poppins(dark3, h5, FontWeight.w600),
                          ),
                        ),
                        Container(
                          child: DropdownButton<String>(
                            elevation: 2,
                            underline: Container(),
                            style: poppins(
                                foreground.withOpacity(0.5), h4, FontWeight.w500),
                            items: <String>['Change Password', 'Hide']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                            onChanged: (val) {
                              if (val == 'Change Password') {
                                passwordbox(context);
                              }
                            },
                          ),
                        )
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Text(timeBuilder(),
                              style: poppins(dark3, h5, FontWeight.w600)),
                        ),
                        Container(
                          child: DropdownButton<String>(
                            elevation: 2,
                            underline: Container(),
                            style: poppins(
                                foreground.withOpacity(0.5), h4, FontWeight.w500),
                            items: <String>['Change Password', 'Hide']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                            onChanged: (val) {
                              if (val == 'Change Password') {
                                passwordbox(context);
                              }
                            },
                          ),
                        )
                      ],
                    ),
            ],
          ),
            widget.self!.notes[widget.index!.toInt()].isPasswordProtected? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.all(10),
                    alignment: Alignment.topRight,
                    child: Icon(Icons.lock))
              ],
            ):Container()
        ]),
      ),
    );
  }
}
