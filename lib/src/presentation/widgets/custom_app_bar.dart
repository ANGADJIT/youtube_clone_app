import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:youtube_clone_app/src/presentation/pages/intro_page.dart';
import 'package:youtube_clone_app/src/utils/cache_manager.dart';
import 'package:youtube_clone_app/src/utils/colors.dart';
import 'package:youtube_clone_app/src/utils/custom_media_query.dart';

class CustomAppBar {
  VxAppBar call(BuildContext context,
      {required String title, bool showLogo = false}) {
    return VxAppBar(
      backgroundColor: black,
      title: HStack([
        showLogo
            ? FaIcon(
                FontAwesomeIcons.youtube,
                color: red,
                size: CustomMediaQuery.makeSize(context, .4),
              ).onTap(() {
                CacheManager.deleteToken();

                context.nextAndRemoveUntilPage(const IntroPage());
              })
            : Container(),
        showLogo
            ? CustomMediaQuery.makeWidth(context, .01).widthBox
            : Container(),
        title.text.color(white).headline6(context).bold.make()
      ]).px(CustomMediaQuery.makeWidth(context, .01)),
    );
  }
}
