import 'package:flutter/material.dart';
import 'package:flutter_app/Core/Home/Home.dart';
import 'package:flutter_app/Designs/Colors.dart';
import 'package:flutter_app/Designs/Fonts.dart';
import 'package:flutter_app/Suppliments/FolderSupport.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:painter/painter.dart';

import 'Paintview..dart';

class PaintScreen extends StatefulWidget {
  int? index;
  FolderSupport? self;
  PaintScreen({this.self, this.index});

  @override
  _PaintScreenState createState() => new _PaintScreenState();
}

class _PaintScreenState extends State<PaintScreen> {
  bool _finished = false;
  PainterController _controller = _newController();

  @override
  void initState() {
    super.initState();
  }

  static PainterController _newController() {
    PainterController controller = new PainterController();
    controller.thickness = 1.0;
    controller.backgroundColor = light;
    controller.drawColor = foreground;
    return controller;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> actions;
    if (_finished) {
      actions = <Widget>[
        new IconButton(
          icon: new Icon(Icons.content_copy),
          tooltip: 'New Painting',
          onPressed: () => setState(() {
            _finished = false;
            _controller = _newController();
          }),
        ),
      ];
    } else {
      actions = <Widget>[
        new IconButton(
            icon: new Icon(
              Icons.undo,
            ),
            tooltip: 'Undo',
            onPressed: () {
              if (_controller.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    duration: const Duration(milliseconds: 650),
                    backgroundColor: Colors.red.withOpacity(0.9),
                    content: Text(
                      'Canvas is empty',
                      style: poppins(light, h4, FontWeight.w500),
                    )));
              } else {
                _controller.undo();
              }
            }),
        new IconButton(icon: new Icon(Icons.delete), tooltip: 'Clear', onPressed: _controller.clear),
        new IconButton(icon: new Icon(Icons.check), onPressed: () => _show(_controller.finish(), context)),
      ];
    }
    return new Scaffold(
      backgroundColor: light,
      appBar: new AppBar(
          title: Text(
            'Draw',
            style: poppins(foreground, h2, FontWeight.w600),
          ),
          actions: actions,
          iconTheme: IconThemeData(
            color: foreground, //change your color here
          ),
          elevation: 0,
          backgroundColor: light,
          bottom: new PreferredSize(
            child: new DrawBar(_controller),
            preferredSize: new Size(MediaQuery.of(context).size.width, 30.0),
          )),
      body: Container(margin: EdgeInsets.all(10), child: Container(child: Painter(_controller))),
    );
  }

  _show(PictureDetails picture, BuildContext context) {
    if (widget.index == -1) {
      temp.isImageAdded = true;
      for (int i = 0; i < temp.noteEditor.noteContents.length; i++) {
        try {
          temp.noteEditor.noteContents[i].aut = false;
        } catch (e) {
          continue;
        }
      }
      print("paint");
      var currentPaint = new ImageView(
        self: widget.self,
        outerIndex: widget.index!.toInt(),
        innerIndex: temp.noteEditor.noteContents.length,
        picture: picture,
      );
      temp.noteEditor.paintIndexes.add(temp.noteEditor.noteContents.length);
      temp.noteEditor.addNewPaint(currentPaint);
      temp.noteEditor.addNewContentTextField();
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => temp.noteEditor.notes()), (Route<dynamic> route) => false);
    } else {
      widget.self!.notes[widget.index!.toInt()].isImageAdded = true;
      widget.self!.notes[widget.index!.toInt()].updater();
      for (int i = 0; i < widget.self!.notes[widget.index!.toInt()].noteEditor.noteContents.length; i++) {
        try {
          widget.self!.notes[widget.index!.toInt()].noteEditor.noteContents[i].aut = false;
        } catch (e) {
          continue;
        }
      }
      var currentPaint = new ImageView(
        self: widget.self,
        outerIndex: widget.index!.toInt(),
        innerIndex: widget.self!.notes[widget.index!.toInt()].noteEditor.noteContents.length,
        picture: picture,
      );
      widget.self!.notes[widget.index!.toInt()].noteEditor.addNewPaint(currentPaint);
      widget.self!.notes[widget.index!.toInt()].noteEditor.addNewContentTextField();
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => widget.self!.notes[widget.index!.toInt()].noteEditor.notes()), (Route<dynamic> route) => false);
    }
  }
}

class DrawBar extends StatefulWidget {
  final PainterController _controller;

  DrawBar(this._controller);

  @override
  State<DrawBar> createState() => _DrawBarState();
}

class _DrawBarState extends State<DrawBar> {
  @override
  Widget build(BuildContext context) {
    Widget circleSelect(double r) {
      return InkWell(
        onTap: () {
          setState(() {
            widget._controller.thickness = r;
          });
        },
        child: Container(
          margin: EdgeInsets.all(10),
          child: CircleAvatar(
            maxRadius: r + 3,
            backgroundColor: dark3,
            child: CircleAvatar(
              maxRadius: r,
              backgroundColor: Colors.black,
            ),
          ),
        ),
      );
    }

    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Flexible(child: new StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [circleSelect(5), circleSelect(6), circleSelect(7), circleSelect(8), circleSelect(9), circleSelect(10)],
          );
        })),
        new StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
          return new RotatedBox(
              quarterTurns: widget._controller.eraseMode ? 2 : 0,
              child: IconButton(
                  icon: new Icon(
                    Icons.create,
                  ),
                  tooltip: (widget._controller.eraseMode ? 'Disable' : 'Enable') + ' eraser',
                  onPressed: () {
                    setState(() {
                      widget._controller.eraseMode = !widget._controller.eraseMode;
                    });
                  }));
        }),
        new ColorPickerButton(widget._controller, false),
      ],
    );
  }
}

class ColorPickerButton extends StatefulWidget {
  final PainterController _controller;
  final bool _background;

  ColorPickerButton(this._controller, this._background);

  @override
  _ColorPickerButtonState createState() => new _ColorPickerButtonState();
}

class _ColorPickerButtonState extends State<ColorPickerButton> {
  @override
  Widget build(BuildContext context) {
    return new IconButton(icon: new Icon(_iconData, color: _color), tooltip: widget._background ? 'Change background color' : 'Change draw color', onPressed: _pickColor);
  }

  void _pickColor() {
    Color pickerColor = _color;
    Navigator.of(context)
        .push(new MaterialPageRoute(
            fullscreenDialog: true,
            builder: (BuildContext context) {
              return Scaffold(
                  backgroundColor: light,
                  appBar: AppBar(
                    iconTheme: IconThemeData(
                      color: foreground, //change your color here
                    ),
                    backgroundColor: light,
                    elevation: 0,
                    centerTitle: true,
                    title: Text(
                      'Pick color',
                      style: poppins(foreground, h2, FontWeight.w500),
                    ),
                  ),
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          'Choose the color you want to use in your note for your pencil.',
                          style: poppins(foreground, h3, FontWeight.normal),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(border: Border.all(color: dark1, width: 2)),
                          alignment: Alignment.center,
                          child: Container(
                            margin: EdgeInsets.only(top: 50, left: 10, right: 10, bottom: 30),
                            child: new ColorPicker(
                              pickerColor: pickerColor,
                              onColorChanged: (Color c) => pickerColor = c,
                            ),
                          )),
                    ],
                  ));
            }))
        .then((_) {
      setState(() {
        _color = pickerColor;
      });
    });
  }

  Color get _color => widget._background ? widget._controller.backgroundColor : widget._controller.drawColor;

  IconData get _iconData => widget._background ? Icons.format_color_fill : Icons.circle;

  set _color(Color color) {
    if (widget._background) {
      widget._controller.backgroundColor = color;
    } else {
      widget._controller.drawColor = color;
    }
  }
}
