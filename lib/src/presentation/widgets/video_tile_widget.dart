import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:youtube_clone_app/src/data/providers/videos_api.dart';
import 'package:youtube_clone_app/src/utils/colors.dart';
import 'package:youtube_clone_app/src/utils/common_widgets.dart';
import 'package:youtube_clone_app/src/utils/custom_media_query.dart';

class VideoTileWidget extends StatelessWidget {
  VideoTileWidget(
      {super.key,
      required this.uri,
      required this.userId,
      required this.title,
      required this.channelName,
      required this.isFirstTile});
  final String uri;
  final String userId;
  final String title;
  final bool isFirstTile;
  final String channelName;

  final VideosApi _videosApi = VideosApi();

  @override
  Widget build(BuildContext context) {
    return VStack([
      //
      isFirstTile
          ? Divider(
              color: darkGray,
              thickness: CustomMediaQuery.makeHeight(context, .01),
              height: CustomMediaQuery.makeHeight(context, .01),
            )
          : Container(),
      VxBox(
              child: FutureBuilder<String>(
        future: _videosApi.getThumbnail(uri),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return VStack([
              CircularProgressIndicator(
                strokeWidth: 3.4,
                color: red,
              ).centered()
            ]);
          }

          return Image.network(
            snapshot.data!,
            fit: BoxFit.cover,
          );
        },
      ))
          .size(CustomMediaQuery.makeWidth(context, 1.0),
              CustomMediaQuery.makeHeight(context, .234))
          .makeCentered(),

      ListTile(
        leading: CommonWidgets.loadImage(
            context, _videosApi.getChannelProfile(userId)),
        title: title.text.color(white).light.make(),
        subtitle: VxBox()
            .size(CustomMediaQuery.makeWidth(context, .1),
                CustomMediaQuery.makeHeight(context, .01))
            .color(darkGray)
            .make()
            .shimmer(showAnimation: true),
      ),

      Divider(
        color: darkGray,
        thickness: CustomMediaQuery.makeHeight(context, .01),
      )
    ]);
  }
}
