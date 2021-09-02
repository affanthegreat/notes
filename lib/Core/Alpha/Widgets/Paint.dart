import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_app/Core/FoldersManagement/FolderView.dart';
import 'package:flutter_app/Core/Home/Home.dart';
import 'package:flutter_app/Designs/Colors.dart';
import 'package:flutter_app/Designs/Fonts.dart';
import 'package:flutter_app/Suppliments/FolderSupport.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:painter/painter.dart';

class ExamplePage extends StatefulWidget {
  int ?index;
  FolderSupport ?self;
  ExamplePage({this.self,this.index});

  @override
  _ExamplePageState createState() => new _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
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
        new IconButton(
            icon: new Icon(Icons.delete),
            tooltip: 'Clear',
            onPressed: _controller.clear),
        new IconButton(
            icon: new Icon(Icons.check),
            onPressed: () => _show(_controller.finish(), context)),
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
      body: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
            border: Border.all(color: dark1,width: 1)
          ),
          height: MediaQuery.of(context).size.height * 0.65,
          child: Container(
              padding: EdgeInsets.all(10),
              child: Painter(_controller))),
    );
  }

  _show(PictureDetails picture, BuildContext context)  {

    if(widget.index == -1){
      temp.isImageAdded = true;
      for(int i = 0; i<temp.noteEditor.noteContents.length; i++){
        try{
          temp.noteEditor.noteContents[i].aut = false;
        }
        catch(e){
          continue;
        }
      }
      print("paint");


      temp.noteEditor.addNewPaint(Container(
          alignment: Alignment.center,
          child: new FutureBuilder<Uint8List>(
            future: picture.toPNG(),
            builder:
                (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return new Text('Error: ${snapshot.error}');
                  } else {
                    return Column(
                      children: [
                        Image.memory(snapshot.data!),
                        Container(
                          alignment: Alignment.bottomLeft,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.delete),
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  }
                default:
                  return new Container(
                      child: new FractionallySizedBox(
                        widthFactor: 0.1,
                        child: new AspectRatio(
                            aspectRatio: 1.0,
                            child: new CircularProgressIndicator()),
                        alignment: Alignment.center,
                      ));
              }
            },
          )));
      temp.noteEditor.addNewContentTextField();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => temp.noteEditor.notes()),
              (Route<dynamic> route) => false);
    }
    else{
      widget.self!.notes[widget.index!.toInt()].isImageAdded = true;
      widget.self!.notes[widget.index!.toInt()].updater();
      for(int i = 0; i< widget.self!.notes[widget.index!.toInt()].noteEditor.noteContents.length; i++){
        try{
          widget.self!.notes[widget.index!.toInt()].noteEditor.noteContents[i].aut = false;
        }
        catch(e){

          continue;
        }
      }

      widget.self!.notes[widget.index!.toInt()].noteEditor.addNewPaint(Container(
          alignment: Alignment.center,
          child: new FutureBuilder<Uint8List>(
            future: picture.toPNG(),
            builder:
                (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    return new Text('Error: ${snapshot.error}');
                  } else {
                    return Column(
                      children: [
                        Image.memory(snapshot.data!,filterQuality: FilterQuality.high,),
                        Container(
                          alignment: Alignment.bottomLeft,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.delete),
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  }
                default:
                  return new Container(
                      child: new FractionallySizedBox(
                        widthFactor: 0.1,
                        child: new AspectRatio(
                            aspectRatio: 1.0,
                            child: new CircularProgressIndicator()),
                        alignment: Alignment.center,
                      ));
              }
            },
          )));
      print("paint");
      print(wisdom!.allFolders[wisdom!.returnIndexOfFolder(widget.self!.folderName)].notes.length);
      widget.self!.notes[widget.index!.toInt()].noteEditor.addNewContentTextField();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => widget.self!.notes[widget.index!.toInt()].noteEditor.notes()),
              (Route<dynamic> route) => false);
    }

  }
}

class DrawBar extends StatelessWidget {
  final PainterController _controller;

  DrawBar(this._controller);

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Flexible(child: new StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return new Container(
              child: new Slider(
            value: _controller.thickness,
            onChanged: (double value) => setState(() {
              _controller.thickness = value;
            }),
            min: 1.0,
            max: 5.0,
            activeColor: dark3.withOpacity(0.6),
          ));
        })),
        new StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return new RotatedBox(
              quarterTurns: _controller.eraseMode ? 2 : 0,
              child: IconButton(
                  icon: new Icon(Icons.create),
                  tooltip: (_controller.eraseMode ? 'Disable' : 'Enable') +
                      ' eraser',
                  onPressed: () {
                    setState(() {
                      _controller.eraseMode = !_controller.eraseMode;
                    });
                  }));
        }),
        new ColorPickerButton(_controller, false),
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
    return new IconButton(
        icon: new Icon(_iconData, color: _color),
        tooltip: widget._background
            ? 'Change background color'
            : 'Change draw color',
        onPressed: _pickColor);
  }

  void _pickColor() {
    Color pickerColor = _color;
    Navigator.of(context)
        .push(new MaterialPageRoute(
            fullscreenDialog: true,
            builder: (BuildContext context) {
              return new Scaffold(
                  backgroundColor: light,
                  appBar: AppBar(
                    iconTheme: IconThemeData(
                      color: foreground, //change your color here
                    ),
                    backgroundColor: light,
                    elevation: 0,
                    title: Text(
                      'Pick color',
                      style: poppins(foreground, h2, FontWeight.w500),
                    ),
                  ),
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      new Container(
                          alignment: Alignment.center,
                          child: new ColorPicker(
                            pickerColor: pickerColor,
                            onColorChanged: (Color c) => pickerColor = c,
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

  Color get _color => widget._background
      ? widget._controller.backgroundColor
      : widget._controller.drawColor;

  IconData get _iconData =>
      widget._background ? Icons.format_color_fill : Icons.brush;

  set _color(Color color) {
    if (widget._background) {
      widget._controller.backgroundColor = color;
    } else {
      widget._controller.drawColor = color;
    }
  }
}
