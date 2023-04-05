import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:youtube_clone_app/src/utils/colors.dart';
import 'package:youtube_clone_app/src/utils/custom_media_query.dart';
import 'package:youtube_clone_app/src/utils/strings.dart';

class AuthForm extends StatefulWidget {
  const AuthForm(
      {super.key,
      this.isSignIn = false,
      required this.email,
      required this.password});
  final bool isSignIn;
  final TextEditingController email;
  final TextEditingController password;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
        child: VStack([
      VxTextField(
          borderType: VxTextFieldBorderType.roundLine,
          controller: widget.email,
          hint: emailTextFieldHint,
          hintStyle: TextStyle(color: gray),
          style: TextStyle(color: white),
          cursorColor: white,
          borderColor: white,
          keyboardType: TextInputType.emailAddress),
      CustomMediaQuery.makeHeight(context, .03).heightBox,
      VxTextField(
          borderType: VxTextFieldBorderType.roundLine,
          controller: widget.password,
          borderColor: white,
          hint: passwordTextFieldHint,
          style: TextStyle(color: white),
          hintStyle: TextStyle(color: gray),
          isPassword: true,
          cursorColor: white,
          keyboardType: TextInputType.visiblePassword,
          obscureText: true)
    ]));
  }
}
