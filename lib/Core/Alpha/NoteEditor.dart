import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Core/Alpha/Widgets/Paint.dart';
import 'package:flutter_app/Core/FoldersManagement/FolderView.dart';
import 'package:flutter_app/Core/Home/Home.dart';
import 'package:flutter_app/Core/Notes/Notemodel.dart';
import 'package:flutter_app/Designs/Colors.dart';
import 'package:flutter_app/Suppliments/FolderSupport.dart';



class NoteEditor extends StatefulWidget {
  late List<dynamic> ?content;
  int ?index;
  late FolderSupport ?self;
  NoteEditor({this.self,this.index,this.content,Key? key}) : super(key: key);

  @override
  _NoteEditorState createState() => _NoteEditorState();
}

class _NoteEditorState extends State<NoteEditor> {


  @override
  void initState() {
// TODO: implement initState
    super.initState();

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: light,
        elevation: 0,
        iconTheme: IconThemeData(
          color: foreground, //change your color here
        ),
        leading: IconButton(
          onPressed: (){
            if(Navigator.canPop(context)){
              Navigator.pop(context);
            }
            else{
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => Home(self: current,archived: wisdom!.returnFolderByName("Archived"),)),
                      (Route<dynamic> route) => false);
            }

          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
              onPressed: () {
                print(wisdom!.allFolders[wisdom!.returnIndexOfFolder(widget.self!.folderName)].notes.length);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ExamplePage(index:widget.index!.toInt(),self: widget.self,)));
              },
              icon: Icon(Icons.brush_rounded)),
          IconButton(
              onPressed: () {
                if(widget.index == -1){
                  print("here");
                  temp.title = temp.noteEditor.noteContents[0].title;
                  temp.content = temp.noteEditor.noteContents[1].content;
                  temp.setIndex(widget.self!.notes.length);

                  temp.noteEditor.index =widget.self!.notes.length;
                  temp.updater();
                  setState(() {
                    widget.self!.notes.add(temp);
                    wisdom!.allFolders[wisdom!.returnIndexOfFolder(widget.self!.folderName)] = widget.self!;
                    print(wisdom!.allFolders[wisdom!.returnIndexOfFolder(widget.self!.folderName)].notes.length);
                  });

                  temp = new Note(-1);
                }
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => Folders()),
                        (Route<dynamic> route) => false);
              },
              icon: Icon(Icons.save_rounded))
        ],
      ),
      body: ListView.builder(
          physics: BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          itemCount:widget.content!.length ,
          itemBuilder: (context,index){
        return widget.content![index];
      })
    );
  }
}
