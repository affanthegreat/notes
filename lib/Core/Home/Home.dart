import 'package:flutter/material.dart';
import 'package:flutter_app/Core/Notes/Notemodel.dart';
import 'package:flutter_app/Core/Security/PasswordScreen.dart';
import 'package:flutter_app/Designs/Colors.dart';
import 'package:flutter_app/Designs/Fonts.dart';
import 'package:flutter_app/Suppliments/Dismissable.dart';
import 'package:flutter_app/Suppliments/FolderSupport.dart';

late Note temp;

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
        widget.self!.notes[index].setIndex(widget.archived!.notes.length);
        widget.archived!.add(widget.self!.notes[index]);
        widget.self!.notes.removeAt(index);
      });
      print("Archived notes length: " + widget.archived!.notes.length.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(milliseconds: 350),
          backgroundColor: Colors.orange,
          content: Text(
            'Note archived.',
            style: poppins(light, h4, FontWeight.w500),
          )));
    }

    void passwordialogbox(int index) {
      if (widget.self!.notes[index].isPasswordProtected) {
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
                          if (password == widget.self!.notes[index].getPassword()) {
                            Navigator.pop(context);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => widget.self!.notes[index].noteEditor.notes()));
                          } else {
                            Navigator.pop(context);
                            final snackBar = SnackBar(
                              content: Text('Wrong password.',
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
                            height: 50,
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(color: dark1.withOpacity(0.5), borderRadius: BorderRadius.circular(5)),
                            padding: EdgeInsets.all(5),
                            child: Center(
                              child: Text(
                                "Unlock note",
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
        Navigator.push(context, MaterialPageRoute(builder: (context) => widget.self!.notes[index].noteEditor.notes()));
      }
    }

    void delete(index) {
      setState(() {
        if (widget.self!.notes[index].colorName != 'None') {
          colortags.returnTagByName(widget.self!.notes[index].colorName).notes.removeAt(widget.self!.notes[index].colortagIndex);
        }
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
      floatingActionButton: widget.archived == widget.self
          ? null
          : FloatingActionButton(
              backgroundColor: dark1.withOpacity(0.9),
              foregroundColor: Colors.black,
              mini: true,
              onPressed: () {
                temp = new Note(-1);
                Navigator.push(context, MaterialPageRoute(builder: (context) => temp.noteEditor.noteEditor));
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => Vault()));
          },
          child: Text(
            widget.self!.folderName.toString(),
            style: poppins(dark3, h4, FontWeight.w600),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
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
                      widget.archived == widget.self ? "No notes archived at this moment." : "Add new notes to see here.",
                      style: poppins(foreground, h4, FontWeight.w500),
                    ),
                  ],
                ),
              ),
            )
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.5),
              physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              itemCount: widget.self!.notes.length,
              itemBuilder: (context, index) {
                if (index % 2 == 0) {
                  return Container(
                    margin: EdgeInsets.only(left: 15, right: 5, top: 5, bottom: 10),
                    child: DismissibleWidget(
                        item: widget.self!.notes[index],
                        child: InkWell(
                            onTap: () {
                              passwordialogbox(index);
                            },
                            child: widget.self!.notes[index].noteContainer(self: widget.self, index: index)),
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
                }

                return Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.only(left: 5, right: 15, top: 5, bottom: 10),
                    child: DismissibleWidget(
                        item: widget.self!.notes[index],
                        child: InkWell(
                          onTap: () {
                            passwordialogbox(index);
                          },
                          child: widget.self!.notes[index].noteContainer(self: widget.self, index: index),
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
                  ),
                );
              },
            ),
    );
  }
}
