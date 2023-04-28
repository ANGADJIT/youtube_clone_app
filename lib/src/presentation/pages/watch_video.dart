import 'package:flutter/material.dart';
import 'package:youtube_clone_app/src/data/models/video.dart';
import 'package:youtube_clone_app/src/presentation/widgets/custom_app_bar.dart';
import 'package:youtube_clone_app/src/utils/colors.dart';

class WatchVideo extends StatefulWidget {
  const WatchVideo({super.key, required this.video});
  final Video video;

  @override
  State<WatchVideo> createState() => _WatchVideoState();
}

class _WatchVideoState extends State<WatchVideo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      appBar: CustomAppBar().call(context, title: 'Watch Video', isHome: false),
    );
  }
}
