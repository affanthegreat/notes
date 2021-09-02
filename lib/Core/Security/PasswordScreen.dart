import 'package:flutter/material.dart';
import 'package:flutter_app/Designs/Colors.dart';
import 'package:flutter_app/Designs/Fonts.dart';

class Vault extends StatelessWidget {
  const Vault({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    String password = "";

    return Scaffold(
      backgroundColor: light,
      appBar: AppBar(
        backgroundColor: light,
        elevation: 0,
        iconTheme: IconThemeData(
          color: foreground, //change your color here
        ),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 25,right: 25,top: 5,bottom: 10),
            child: Text("Inside Vault, you can hide your personal notes that you don't want others to never know about them.",style: poppins(foreground.withOpacity(0.7), h3 - 2,
                FontWeight.w500),),
          ),
          ConstrainedBox(

            constraints: BoxConstraints(maxWidth: 600),
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 25,right: 25,top: 5,bottom: 10),
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
                onChanged: (value){
                  password = value;
                },
                style: poppins(foreground.withOpacity(0.7), h2 - 4,
                    FontWeight.w500),
                obscureText: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.password,
                    color: dark2,
                  ),
                  hintText: "Your secret vault code?",
                  hintStyle: poppins(foreground.withOpacity(0.5), h4, FontWeight.w500),
                ),
              ),
            ),
          ),
          LockButton(password),
          ConstrainedBox(constraints: BoxConstraints(minHeight: 50))
        ],
      ),
    );
  }
}


class LockButton extends StatelessWidget {

  String password;

  LockButton(this.password);



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 50,
      width: 200,
      decoration: BoxDecoration(
        color: dark1,
        borderRadius: BorderRadius.circular(8)
      ),
      child:Center(
        child: Text("Unlock Vault",style: poppins(foreground.withOpacity(0.7),h3,FontWeight.w600),),
      ) ,
    );
  }
}
