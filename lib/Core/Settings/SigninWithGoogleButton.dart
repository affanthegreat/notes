import 'package:flutter/material.dart';
import 'package:flutter_app/Designs/Colors.dart';
import 'package:flutter_app/Designs/Fonts.dart';

class SignInWithGoogleButton extends StatelessWidget {
  const SignInWithGoogleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 50,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: Text(
            "Sign in with google",
            style: poppins(light, h4, FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
