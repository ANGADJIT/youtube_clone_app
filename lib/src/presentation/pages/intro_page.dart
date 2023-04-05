import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:youtube_clone_app/src/presentation/pages/auth_page.dart';
import 'package:youtube_clone_app/src/presentation/widgets/intro_image_widget.dart';
import 'package:youtube_clone_app/src/utils/colors.dart';
import 'package:youtube_clone_app/src/utils/custom_media_query.dart';
import 'package:youtube_clone_app/src/utils/strings.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: SafeArea(
          child: VStack([
        //
        CustomMediaQuery.makeHeight(context, .07).heightBox,
        const IntroImageWidget(),

        //
        CustomMediaQuery.makeHeight(context, .014).heightBox,
        youtubeSignInOrSignUpMessage.text
            .color(white)
            .bold
            .size(CustomMediaQuery.makeTextSize(context, .52))
            .make(),

        //
        const Spacer(),

        //
        TextButton(
            onPressed: () => _navigateToAuth(context: context, isSignIn: true),
            child: signInWithEmail.text
                .color(gray)
                .size(CustomMediaQuery.makeTextSize(context, .5))
                .make()),
        TextButton(
            onPressed: () => _navigateToAuth(context: context),
            child: signUpWithEmail.text
                .color(gray)
                .italic
                .bold
                .size(CustomMediaQuery.makeTextSize(context, .5))
                .make()),
        CustomMediaQuery.makeHeight(context, .02).heightBox,
      ])).px(CustomMediaQuery.makeWidth(context, .07)),
    );
  }

  // auth navigation function
  void _navigateToAuth(
          {required BuildContext context, bool isSignIn = false}) =>
      context.nextPage(AuthPage(isSignIn: isSignIn));
}
