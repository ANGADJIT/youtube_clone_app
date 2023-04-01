import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
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
        ClipRRect(
          borderRadius:
              BorderRadius.circular(CustomMediaQuery.makeRadius(context, .2)),
          child: Image.asset(
            'assets/images/intro.jpg',
            fit: BoxFit.cover,
          )
              .box
              .size(CustomMediaQuery.makeWidth(context, .6),
                  CustomMediaQuery.makeHeight(context, .12))
              .make(),
        ),

        //
        CustomMediaQuery.makeHeight(context, .01).heightBox,
        youtubeSignInOrSignUpMessage.text
            .color(white)
            .bold
            .size(CustomMediaQuery.makeTextSize(context, .5))
            .make(),
        
        //
        
      ])).px(CustomMediaQuery.makeWidth(context, .07)),
    );
  }
}
