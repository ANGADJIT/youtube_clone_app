import 'package:bottom_bar_matu/bottom_bar_double_bullet/bottom_bar_double_bullet.dart';
import 'package:bottom_bar_matu/bottom_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:youtube_clone_app/src/presentation/pages/all_videos_page.dart';
import 'package:youtube_clone_app/src/presentation/pages/upload_page.dart';
import 'package:youtube_clone_app/src/presentation/widgets/custom_app_bar.dart';
import 'package:youtube_clone_app/src/utils/colors.dart';
import 'package:youtube_clone_app/src/utils/custom_media_query.dart';
import 'package:youtube_clone_app/src/utils/strings.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: CustomAppBar().call(context, title: youtubeTitle, showLogo: true),
      bottomNavigationBar: BottomBarDoubleBullet(
          color: white,
          backgroundColor: black,
          height: CustomMediaQuery.makeHeight(context, .04),
          items: [
            BottomBarItem(
              iconData: Icons.home,
            ),
            BottomBarItem(
              iconData: Icons.add_rounded,
            ),
            BottomBarItem(
              iconData: Icons.library_add_check,
            ),
          ]),
      body: VideosPage(),
    );
  }
}
