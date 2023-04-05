import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:youtube_clone_app/src/utils/custom_media_query.dart';
import 'package:youtube_clone_app/src/utils/strings.dart';

class IntroImageWidget extends StatelessWidget {
  const IntroImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius:
          BorderRadius.circular(CustomMediaQuery.makeRadius(context, .2)),
      child: Image.asset(
        introPageAssetString,
        fit: BoxFit.cover,
      )
          .box
          .size(CustomMediaQuery.makeWidth(context, .6),
              CustomMediaQuery.makeHeight(context, .12))
          .make(),
    );
  }
}
