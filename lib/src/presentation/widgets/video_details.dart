import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:youtube_clone_app/src/data/models/video.dart';
import 'package:youtube_clone_app/src/data/providers/videos_api.dart';
import 'package:youtube_clone_app/src/utils/colors.dart';
import 'package:youtube_clone_app/src/utils/common_widgets.dart';
import 'package:youtube_clone_app/src/utils/custom_loading.dart';
import 'package:youtube_clone_app/src/utils/custom_media_query.dart';

class VideoDetails extends StatefulWidget {
  const VideoDetails({super.key, required this.video});
  final Video video;

  @override
  State<VideoDetails> createState() => _VideoDetailsState();
}

class _VideoDetailsState extends State<VideoDetails> {
  final VideosApi _videosApi = VideosApi();

  @override
  Widget build(BuildContext context) {
    return VxBox(
            child: VStack([
      //
      CustomMediaQuery.makeHeight(context, .01).heightBox,
      widget.video.videoName.text.bold.color(white).headline6(context).make(),

      //
      CustomMediaQuery.makeHeight(context, .02).heightBox,
      HStack([
        CommonWidgets.loadImage(
            context, _videosApi.getChannelProfile(widget.video.userId)),
        CustomMediaQuery.makeWidth(context, .01).widthBox,
        FutureBuilder<String>(
          future: _videosApi.getChannelName(widget.video.userId),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              VxBox()
                  .size(CustomMediaQuery.makeWidth(context, .1),
                      CustomMediaQuery.makeHeight(context, .01))
                  .color(darkGray)
                  .make()
                  .shimmer(showAnimation: true);
            }

            if (snapshot.hasData) {
              return snapshot.data!.text
                  .size(CustomMediaQuery.makeSize(context, .2))
                  .color(white)
                  .semiBold
                  .make();
            }

            return Container();
          }),
        ),
        const Spacer(),
        // subscribe button
        VxBox(
                child: FutureBuilder<bool>(
                    future: _videosApi.checkSubscribtion(widget.video.userId),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return snapshot.data!
                            ? 'Subscribed'
                                .text
                                .light
                                .color(darkGray)
                                .makeCentered()
                            : 'Subscribe'
                                .text
                                .light
                                .color(darkGray)
                                .makeCentered()
                                .onTap(_subscribe);
                      }

                      return 'loading..'
                          .text
                          .light
                          .color(darkGray)
                          .makeCentered();
                    }))
            .roundedLg
            .color(white)
            .height(CustomMediaQuery.makeHeight(context, .037))
            .width(CustomMediaQuery.makeWidth(context, .2))
            .make()
      ])
    ]).px(CustomMediaQuery.makeWidth(context, .02)))
        .color(darkGray)
        .width(CustomMediaQuery.makeWidth(context, 1.0))
        .makeCentered();
  }

  Future<void> _subscribe() async {
    CustomLoading.showLoading(context);

    try {
      await _videosApi.subscribe(widget.video.userId);
    } catch (e) {
      CommonWidgets.showSnackbar(context, message: e.toString());
    }

    CustomLoading.dismiss();

    // ignore: use_build_context_synchronously
    CommonWidgets.showSnackbar(context, message: 'Subscribed');
    setState(() {});
  }
}
