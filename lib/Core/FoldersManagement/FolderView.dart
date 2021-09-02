import 'package:flutter/material.dart';
import 'package:flutter_app/Core/Alpha/NoteEditorModal.dart';
import 'package:flutter_app/Core/Archived/Archived.dart';
import 'package:flutter_app/Core/Home/Home.dart';
import 'package:flutter_app/Core/Security/PasswordScreen.dart';
import 'package:flutter_app/Core/Settings/Settings.dart';
import 'package:flutter_app/Designs/Colors.dart';
import 'package:flutter_app/Designs/Fonts.dart';
import 'package:flutter_app/Suppliments/Dismissable.dart';
import 'package:flutter_app/Suppliments/FolderSupport.dart';

SuperFolders? wisdom;
FolderSupport? current;

class Folders extends StatefulWidget {
  Folders({Key? key}) : super(key: key);

  @override
  _FoldersState createState() => _FoldersState();
}

class _FoldersState extends State<Folders> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Future _asyncInputDialog(BuildContext context) async {
      late String folderName = "";
      return showDialog(
        context: context,
        barrierDismissible: true, // dialog is dismissible with a tap on the barrier
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('New Folder Name?',style: poppins(foreground.withOpacity(0.75),h3,FontWeight.w600),),
            content: new Row(
              children: [
                new Expanded(
                    child: TextField(
                      autofocus: true,
                      style: poppins(foreground, h2, FontWeight.w500),
                      decoration: InputDecoration(
                          hintStyle: poppins(dark2, h4, FontWeight.w500),
                          hintText: 'Subject or Idea'),
                      onChanged: (value) {
                        folderName = value;
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
                     onTap: (){
                       if(folderName != "" && wisdom!.returnFolderByName(folderName).folderName == "" ){
                         FolderSupport temp = new FolderSupport(folderName, []);
                         setState(() {
                           wisdom!.addFolder(temp);
                         });
                         Navigator.pop(context);
                       }
                       else{
                         Navigator.pop(context);
                         final snackBar = SnackBar(content: Text('Folder Name cannot be empty or reused.',style: poppins(light,h3,FontWeight.w500 ,)),backgroundColor: Colors.red.withOpacity(0.9),);
                         ScaffoldMessenger.of(context).showSnackBar(snackBar);
                       }
                     },
                     child: Container(
                       margin: EdgeInsets.all(10),

                       decoration: BoxDecoration(
                         color: dark1,
                         borderRadius: BorderRadius.circular(5)
                       ),
                       padding: EdgeInsets.all(5),
                       child: Center(
                         child: Text("Ok",style: poppins(foreground.withOpacity(0.75),h3,FontWeight.w600),
                     ),
                       )
                     ),
                   ),
                 )],
             )
            ],
          );

        },
      );
    }






    return Scaffold(
      appBar: AppBar(
        backgroundColor: light,
        elevation: 0,
        title: GestureDetector(
          onLongPress: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Vault()));
          },
          child: Container(
            margin: EdgeInsets.only(left: 10),
            child: Text(
              "papernotes",
              style: poppins(foreground, h1, FontWeight.w600),
            ),
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
      floatingActionButton: Container(
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 31),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: FloatingActionButton(
                  heroTag: null,
                  mini: true,
                  backgroundColor: dark1.withOpacity(0.9),
                  onPressed: () {
                    _asyncInputDialog(context);
                  },
                  child: Icon(
                    Icons.create_new_folder_rounded,
                    color: foreground.withOpacity(0.5),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                heroTag: null,
                mini: true,
                backgroundColor: dark1.withOpacity(0.9),
                onPressed: () {},
                child: Icon(
                  Icons.new_label_rounded,
                  color: foreground.withOpacity(0.5),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 600,
            ),
            child: Container(
              alignment: Alignment.topCenter,
              child: ListView.builder(
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: wisdom!.allFolders.length,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Column(
                        children: [
                          Container(
                              alignment: Alignment.bottomLeft,
                              margin: EdgeInsets.only(
                                  left: 25, top: 20, bottom: 10),
                              child: Text(
                                "Your Folders",
                                style: poppins(dark2.withOpacity(0.95), h2,
                                    FontWeight.w600),
                              )),
                          FolderButton(
                            folder: wisdom!.allFolders[index],
                            archived: wisdom!.returnFolderByName("Archived"),
                          ),
                        ],
                      );
                    }
                    else if(index < 2){
                      return FolderButton(folder: wisdom!.allFolders[index]);
                    }
                    else{
                     return  DismissibleWidget3(
                       item:wisdom!.allFolders[index] ,
                        onDismissed: (DismissDirection direction) {
                          switch (direction) {
                            case DismissDirection.endToStart:
                              setState(() {
                                wisdom!.allFolders.removeAt(index);
                              });
                              final snackBar = SnackBar(content: Text('Folder Deleted.',style: poppins(light,h3,FontWeight.w500 ,)),backgroundColor: Colors.red.withOpacity(0.9),);
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              break;
                            case DismissDirection.startToEnd:
                              setState(() {
                                wisdom!.allFolders.removeAt(index);
                              });
                              final snackBar = SnackBar(content: Text('Folder Deleted.',style: poppins(light,h3,FontWeight.w500 ,)),backgroundColor: Colors.red.withOpacity(0.9),);
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
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

                        },
                        child: FolderButton(folder: wisdom!.allFolders[index],),
                      );
                    }

                  }),
            )),
      ),
    );
  }
}

class FolderButton extends StatelessWidget {
  FolderSupport? folder;
  FolderSupport? archived;

  FolderButton({this.folder, this.archived, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        folderNameHolder = folder!.folderName;
        current = folder;
        print(folder!.notes.length);
        if (folder!.folderName == "Archived") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Archived(archived: folder)));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Home(self: folder, archived: archived)));
        }
      },
      child: Container(
        margin: EdgeInsets.only(left: 25, right: 25, top: 5, bottom: 5),
        height: 50,
        padding: EdgeInsets.all(10),
        width: double.infinity,
        decoration: BoxDecoration(
            color: dark1.withOpacity(0.35),
            borderRadius: BorderRadius.circular(5)),
        child: Text(
          folder!.folderName,
          style: poppins(foreground.withOpacity(0.55), h3, FontWeight.w600),
        ),
      ),
    );
  }
}
