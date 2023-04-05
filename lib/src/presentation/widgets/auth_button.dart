import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:youtube_clone_app/src/utils/colors.dart';
import 'package:youtube_clone_app/src/utils/custom_media_query.dart';
import 'package:youtube_clone_app/src/utils/strings.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({super.key, this.isSignIn = false});
  final bool isSignIn;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: () {},
        child: VxBox(
                child: (isSignIn ? signInTitle : signUpTitle)
                    .text
                    .light
                    .headline6(context)
                    .color(black)
                    .makeCentered())
            .size(CustomMediaQuery.makeWidth(context, .4),
                CustomMediaQuery.makeHeight(context, .05))
            .roundedLg
            .shadow
            .color(white)
            .border(color: gray)
            .makeCentered());
  }
}
