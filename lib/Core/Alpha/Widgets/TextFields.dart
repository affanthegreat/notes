import 'package:flutter/material.dart';
import 'package:flutter_app/Designs/Colors.dart';
import 'package:flutter_app/Designs/Fonts.dart';

class TitleTextField extends StatefulWidget {
  String? title;
  bool aut;
  String widgetType() {
    return 'Title';
  }

  String text() {
    return this.title.toString();
  }

  TitleTextField(this.aut, this.title, {Key? key}) : super(key: key);

  @override
  _TitleTextFieldState createState() => _TitleTextFieldState();
}

class _TitleTextFieldState extends State<TitleTextField> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.title == null) widget.title = "";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 13, right: 13),
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        textCapitalization: TextCapitalization.sentences,
        textAlign: TextAlign.start,
        onChanged: (txt) {
          setState(() {
            widget.title = txt;
          });
        },
        autofocus: widget.aut,
        initialValue: widget.title,
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: "Title",
          hintStyle: poppins(dark3, h4, FontWeight.w500),
        ),
        style: poppins(foreground, h2, FontWeight.w500),
      ),
    );
  }
}

class ContentTextField extends StatefulWidget {
  String? content;
  bool aut;
  String widgetType() {
    return 'text';
  }

  String text() {
    return this.content.toString();
  }

  ContentTextField(this.aut, String content, {Key? key}) : super(key: key);

  @override
  _ContentTextFieldState createState() => _ContentTextFieldState();
}

class _ContentTextFieldState extends State<ContentTextField> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.content == null) widget.content = "";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 13, right: 13),
        child: TextFormField(
          keyboardType: TextInputType.multiline,
          textCapitalization: TextCapitalization.sentences,
          textAlign: TextAlign.start,
          maxLines: null,
          onChanged: (txt) {
            setState(() {
              widget.content = txt;
            });
          },
          autofocus: widget.aut,
          initialValue: widget.content.toString(),
          decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            hintText: "Content",
            hintStyle: poppins(dark2, h4, FontWeight.w500),
          ),
          style: poppins(foreground, h3, FontWeight.w500),
        ));
  }
}
