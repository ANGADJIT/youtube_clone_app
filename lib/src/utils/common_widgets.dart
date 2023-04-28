import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:youtube_clone_app/src/presentation/pages/intro_page.dart';
import 'package:youtube_clone_app/src/utils/cache_manager.dart';
import 'package:youtube_clone_app/src/utils/colors.dart';
import 'package:youtube_clone_app/src/utils/custom_media_query.dart';

class CommonWidgets {
  static void showSnackbar(BuildContext context,
      {required String message, String? actionLabel, VoidCallback? onPressed}) {
    SnackBarAction? snackBarAction;

    if (actionLabel != null && onPressed != null) {
      snackBarAction = SnackBarAction(label: actionLabel, onPressed: onPressed);
    }

    final SnackBar snackBar = SnackBar(
        backgroundColor: black,
        elevation: 0,
        content: VxBox(
                child: HStack([
          message.text
              .size(CustomMediaQuery.makeTextSize(context, .4))
              .color(black)
              .make()
        ]).px(CustomMediaQuery.makeWidth(context, .01)))
            .color(white)
            .roundedSM
            .height(CustomMediaQuery.makeHeight(context, .06))
            .make(),
        action: snackBarAction);

    // show snackbar
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static loadImage(BuildContext context, Future future) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircleAvatar(
            backgroundColor: blue,
          ).onTap(() {
            CacheManager.deleteToken();

            context.nextAndRemoveUntilPage(const IntroPage());
          });
        }

        return CircleAvatar(
          backgroundImage: NetworkImage(snapshot.data!),
        );
      },
    );
  }
}
