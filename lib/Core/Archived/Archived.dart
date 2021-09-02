import 'package:flutter/material.dart';
import 'package:flutter_app/Core/FoldersManagement/FolderView.dart';
import 'package:flutter_app/Core/Home/Home.dart';
import 'package:flutter_app/Designs/Colors.dart';
import 'package:flutter_app/Designs/Fonts.dart';
import 'package:flutter_app/Suppliments/Dismissable.dart';
import 'package:flutter_app/Suppliments/FolderSupport.dart';

class Archived extends StatefulWidget {
  FolderSupport ?archived;
  Archived({this.archived,Key? key}) : super(key: key);

  @override
  _ArchivedState createState() => _ArchivedState();
}

class _ArchivedState extends State<Archived> {
  @override
  Widget build(BuildContext context) {
    void archive(index) {
      setState(() {
        wisdom!.returnFolderByName(widget.archived!.notes[index].originFolder).add(widget.archived!.notes[index]);
        widget.archived!.notes.removeAt(index);
      });
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) =>
              Folders()), (Route<dynamic> route) => false);
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
      body: ( widget.archived!.notes.length == 0)
          ? Center(
              child: Text(
                "No notes are archived at this moment.",
                style: poppins(foreground, h3, FontWeight.w500),
              ),
            )
          : ListView.builder(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemCount:  widget.archived!.notes.length,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Column(
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 600),
                        child: Container(
                          margin: EdgeInsets.only(left:20,right:20,top: 5,bottom: 10),
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
                      DismissibleWidget2(
                          item:  widget.archived!.notes[index],
                          child: Container(
                            margin: EdgeInsets.only(left:20,right:20,top: 5,bottom: 10),
                            child: InkWell(
                                onTap: () {
                                  if (widget
                                      .archived!.notes[index].isPasswordProtected) {
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
                                                        'Password'),
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
                                                          widget.archived!
                                                              .notes[index]
                                                              .getPassword()) {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => widget
                                                                    .archived!
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
                                  }else{
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => widget
                                                .archived!.notes[index].noteEditor
                                                .notes()));
                                  }


                                },
                                child:  widget.archived!.notes[index].noteContainer()),
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
                      item:  widget.archived!.notes[index],
                      child: Container(
                        margin: EdgeInsets.only(left:20,right:20,top: 5,bottom: 10),
                        child: InkWell(
                          onTap: () {
                            if (widget
                                .archived!.notes[index].isPasswordProtected) {
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
                                                  'Password'),
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
                                                    widget.archived!
                                                        .notes[index]
                                                        .getPassword()) {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => widget
                                                              .archived!
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
                            }else{
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => widget
                                          .archived!.notes[index].noteEditor
                                          .notes()));
                            }

                          },
                          child:  widget.archived!.notes[index].noteContainer(),
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
