import 'package:flutter/material.dart';
import 'package:flutter_app/Designs/Colors.dart';
import 'package:flutter_app/Designs/Fonts.dart';

import '../../main.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    String themeSwitcher() {
      if (isDarktheme == false) {
        return "Switch to Dark theme";
      } else {
        return "Switch to Light theme";
      }
    }

    return Scaffold(
      backgroundColor: light,
      appBar: AppBar(
        backgroundColor: light,
        elevation: 0,
        iconTheme: IconThemeData(
          color: foreground, //change your color here
        ),
        centerTitle: true,
        title: Text(
          "Settings",
          style: poppins(foreground, h3, FontWeight.w600),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //SignInWithGoogleButton(),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        margin: EdgeInsets.all(5),
                        child: Text(
                          "General",
                          style: poppins(dark3, h3, FontWeight.w500),
                        ))),
                SettingsContainer("Backup"),
                SettingsContainer("Restore"),
                // InkWell(
                //     onTap: () {
                //       if (isDarktheme) {
                //         setState(() {
                //           light = Color(0xffF9F9F9);
                //           dark1 = Color(0xffF4DFD0);
                //           dark2 = Color(0xffDAD0C2);
                //           dark3 = Color(0xffCDBBA7);
                //           foreground = Color(0xff343A40);
                //         });
                //       } else {
                //         setState(() {
                //           light = Color(0xff171717);
                //           dark1 = Color(0xffF4DFD0);
                //           dark2 = Color(0xffDAD0C2);
                //           dark3 = Color(0xffCDBBA7);
                //           foreground = Color(0xfffafafa);
                //         });
                //       }
                //       isDarktheme = !isDarktheme;
                //     },
                //     child: SettingsContainer(themeSwitcher())),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        margin: EdgeInsets.all(5),
                        child: Text(
                          "About",
                          style: poppins(dark3, h3, FontWeight.w500),
                        ))),
                SettingsContainer("About Notes"),
                SettingsContainer("Developer Info"),
              ],
            ),
          ),
          Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                "Notes_0.4_Alpha-ATG-build: 19/9/2021".toUpperCase(),
                style: poppins(foreground, h6, FontWeight.w500),
              ))
        ],
      ),
    );
  }
}

class SettingsContainer extends StatelessWidget {
  String? txt;
  SettingsContainer(String txt, {Key? key}) : super(key: key) {
    this.txt = txt;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: light,
        border: Border(bottom: BorderSide(color: dark1, width: 0.3)),
      ),
      child: Row(
        children: [
          Text(
            txt.toString(),
            style: poppins(foreground.withOpacity(0.7), h4, FontWeight.w500),
          )
        ],
      ),
    );
  }
}
