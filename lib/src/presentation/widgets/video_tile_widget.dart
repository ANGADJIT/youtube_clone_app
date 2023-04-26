import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:youtube_clone_app/src/utils/colors.dart';
import 'package:youtube_clone_app/src/utils/custom_media_query.dart';

class VideoTileWidget extends StatelessWidget {
  const VideoTileWidget(
      {super.key,
      required this.url,
      required this.channelUrl,
      required this.title});
  final String url;
  final String channelUrl;
  final String title;

  @override
  Widget build(BuildContext context) {
    return VStack([
      //
      VxBox(
              child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Image.network(
          url,
          fit: BoxFit.cover,
        ),
      ))
          .rounded
          .size(CustomMediaQuery.makeWidth(context, .9),
              CustomMediaQuery.makeHeight(context, .234))
          .makeCentered()
          .py(CustomMediaQuery.makeHeight(context, .015)),

      //
      HStack([
        CircleAvatar(
          backgroundImage: NetworkImage(channelUrl),
        ),
        const Spacer(),

        //
        title.text.color(white).semiBold.make(),
        const Spacer(
          flex: 5,
        )
      ]).centered().px(CustomMediaQuery.makeWidth(context, .02))
    ]).box.color(gray).make();
  }
}
