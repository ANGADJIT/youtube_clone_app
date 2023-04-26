import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:youtube_clone_app/src/presentation/widgets/video_tile_widget.dart';

class VideosPage extends StatefulWidget {
  const VideosPage({super.key});

  @override
  State<VideosPage> createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        VideoTileWidget(
            title: 'Dharmshala trip',
            channelUrl:
                'http://192.168.1.8:9000/airflow/a01cb695-dc48-450e-a9b1-66950d13bb4e/thumbanails/92a41118-7b8a-4036-9b0f-851657827f60/thumbnail.png?response-content-type=image%2F%2A&AWSAccessKeyId=VitOwrXH0LO05BpK&Signature=rl%2Bn%2FaoKX9zC2dClc6vcZGwDnpA%3D&Expires=1682535092',
            url:
                'http://192.168.1.8:9000/airflow/a01cb695-dc48-450e-a9b1-66950d13bb4e/profile_pic/profile.png?response-content-type=image%2F%2A&AWSAccessKeyId=VitOwrXH0LO05BpK&Signature=%2FKCPn9PGShqsxeln32c0UZV88Tw%3D&Expires=1682534982')
      ],
    ).px(12.0);
  }
}
